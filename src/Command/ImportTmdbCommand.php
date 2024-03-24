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

        $response = $this->client->request('GET', "https://api.themoviedb.org/3/movie/popular?api_key={$this->apiKey}&language=fr-FR");
        $films = json_decode($response->getBody(), true)['results'];

        $progressBar = new ProgressBar($output, count($films));
        $progressBar->start();

        $genreMap = [
            28 => 'Action',
            12 => 'Adventure',
            16 => 'Animation',
            35 => 'Comedy',
            80 => 'Crime',
            99 => 'Documentary',
            18 => 'Drama',
            10751 => 'Family',
            14 => 'Fantasy',
            36 => 'History',
            27 => 'Horror',
            10402 => 'Music',
            9648 => 'Mystery',
            10749 => 'Romance',
            878 => 'Science Fiction',
            10770 => 'TV Movie',
            53 => 'Thriller',
            10752 => 'War',
            37 => 'Western',
        ];

        foreach ($films as $filmData) {
            $film = new Films();
            $film->setName($filmData['title']);
            $film->setDescription($filmData['overview']);
            $film->setDateSortie(new \DateTime($filmData['release_date']));

            if (!empty($filmData['genre_ids'])) {
                foreach ($filmData['genre_ids'] as $genreId) {
                    if (isset($genreMap[$genreId])) {
                        $genre = new Genre();
                        $genre->setName($genreMap[$genreId]);
                        $this->entityManager->persist($genre);
                        $film->addGenre($genre);
                    }
                }
            }

           // ... (code précédent)

// ... (code précédent)

if (!empty($filmData['poster_path'])) {
    $imageUrl = 'https://image.tmdb.org/t/p/w500' . $filmData['poster_path'];
    try {
        $response = $this->client->request('GET', $imageUrl, ['timeout' => 120]);
        $imageContents = $response->getBody()->getContents();

        $filename = basename($filmData['poster_path']);
        $localPath = __DIR__ . '/../../public/assets/img/' . $filename;
        file_put_contents($localPath, $imageContents);
        
        $image = new Image();
        $titreImage = "Poster : " . $filmData['title']; // Créez un titre pour l'image
        $image->setTitre($titreImage); // Définissez le titre de l'image
        $image->setPhoto($filename); // Enregistre le nom de fichier uniquement.
        $this->entityManager->persist($image);
        
        $film->addImage($image);
    } catch (\GuzzleHttp\Exception\GuzzleException $e) {
        $output->writeln('Erreur lors du téléchargement de l\'image : ' . $e->getMessage());
    }
}

// ... (code suivant)


// ... (code suivant)

            


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

