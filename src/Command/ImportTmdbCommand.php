<?php
namespace App\Command;

use App\Entity\Films;
use App\Entity\Genre;
use App\Entity\Image;
use App\Entity\Acteur;
use App\Entity\Realisateur;
use App\Entity\Producteur;
use Doctrine\ORM\EntityManagerInterface;
use GuzzleHttp\Client;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\ProgressBar;

class ImportTmdbCommand extends Command
{
    protected static $defaultName = 'app:import-tmdb';
    private $apiKey = 'a23257f2e4cf281bcc3fc09c1bff96f4';
    private $client;
    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        parent::__construct();
        $this->client = new Client(['timeout' => 120]);
        $this->entityManager = $entityManager;
    }

    protected function configure()
    {
        $this
            ->setDescription('Imports movies from TMDB.')
            ->setHelp('This command allows you to import movies from TMDB API');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output->writeln([
            'Importation de films',
            '=====================',
            '',
        ]);

        $response = $this->client->request('GET', "https://api.themoviedb.org/3/genre/movie/list?api_key={$this->apiKey}&language=fr-FR");
        $genres = json_decode($response->getBody(), true)['genres'];
        $genreMap = [];
        foreach ($genres as $genre) {
            $genreMap[$genre['id']] = $genre['name'];
        }

        // Ajouter les genres à la base de données en utilisant genreMap
        foreach ($genreMap as $id => $name) {
            $existingGenre = $this->entityManager->getRepository(Genre::class)->find($id);
            if (!$existingGenre) {
                $genre = new Genre();
                $genre->setName($name);
                $this->entityManager->persist($genre);
                $this->entityManager->flush();  // Flusher ici pour s'assurer que l'ID est généré
                // Manuellement définir l'ID en base de données
                $connection = $this->entityManager->getConnection();
                $connection->executeStatement('UPDATE genre SET id = ? WHERE name = ?', [$id, $name]);
            }
        }

        $response = $this->client->request('GET', "https://api.themoviedb.org/3/movie/popular?api_key={$this->apiKey}&language=fr-FR");
        $films = json_decode($response->getBody(), true)['results'];

        $progressBar = new ProgressBar($output, count($films));
        $progressBar->start();

        foreach ($films as $filmData) {
            $film = new Films();
            $film->setName($filmData['title']);
            $film->setDescription($filmData['overview']);
            $film->setDateSortie(new \DateTime($filmData['release_date']));

            if (!empty($filmData['genre_ids'])) {
                foreach ($filmData['genre_ids'] as $genreId) {
                    if (isset($genreMap[$genreId])) {
                        // Associer le genre existant en base de données
                        $genre = $this->entityManager->getRepository(Genre::class)->find($genreId);
                        if ($genre) {
                            $film->addGenre($genre);
                        }
                    }
                }
            }

            if (!empty($filmData['poster_path'])) {
                $imageUrl = 'https://image.tmdb.org/t/p/w500' . $filmData['poster_path'];
                try {
                    $response = $this->client->request('GET', $imageUrl, ['timeout' => 120]);
                    $imageContents = $response->getBody()->getContents();

                    $filename = basename($filmData['poster_path']);
                    $localPath = __DIR__ . '/../../public/assets/img/' . $filename;
                    file_put_contents($localPath, $imageContents);

                    $image = new Image();
                    $titreImage = "Poster : " . $filmData['title'];
                    $image->setTitre($titreImage);
                    $image->setPhoto($filename);
                    $this->entityManager->persist($image);

                    $film->addImage($image);
                } catch (\GuzzleHttp\Exception\GuzzleException $e) {
                    $output->writeln('Erreur lors du téléchargement de l\'image : ' . $e->getMessage());
                }
            }

            // Gestion des acteurs, réalisateurs et producteurs
            $creditsResponse = $this->client->request('GET', "https://api.themoviedb.org/3/movie/{$filmData['id']}/credits?api_key={$this->apiKey}");
            $creditsData = json_decode($creditsResponse->getBody(), true);

            foreach ($creditsData['cast'] as $castMember) {
                $acteur = new Acteur();
                $acteur->setName($castMember['name']);
                $this->entityManager->persist($acteur);
                $film->addActeur($acteur);
            }

            foreach ($creditsData['crew'] as $crewMember) {
                if ($crewMember['job'] == 'Director') {
                    $realisateur = new Realisateur();
                    $realisateur->setName($crewMember['name']);
                    $this->entityManager->persist($realisateur);
                    $film->addRealisateur($realisateur);
                } elseif ($crewMember['job'] == 'Producer') {
                    $producteur = new Producteur();
                    $producteur->setName($crewMember['name']);
                    $this->entityManager->persist($producteur);
                    $film->addProducteur($producteur);
                }
            }

            $this->entityManager->persist($film);
            $progressBar->advance();
        }

        $this->entityManager->flush();
        $progressBar->finish();
        $output->writeln('Importation terminée !');

        return Command::SUCCESS;
    }
}
