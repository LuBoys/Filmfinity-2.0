<?php

namespace App\Controller;

use App\Entity\Films;
use App\Entity\Favorie;
use App\Entity\Commentaire;
use App\Form\CommentaireType;
use App\Repository\FilmsRepository;
use App\Repository\CommentaireRepository;
use App\Repository\GenreRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Security;
use App\Repository\FavorieRepository; // Assurez-vous que le namespace est correct



class FilmsController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(FilmsRepository $filmsRepository, CommentaireRepository $commentaireRepository, GenreRepository $genreRepository): Response
    {
        $latestFilms = $filmsRepository->findLatestReleases();
        $popularFilms = $filmsRepository->findPopularFilms();
        $commentaires = $commentaireRepository->findBy([], ['date_commentaire' => 'DESC'], 5);
        $genres = $genreRepository->findAll();
    
        return $this->render('homepage/index.html.twig', [
            'latestFilms' => $latestFilms,
            'popularFilms' => $popularFilms,
            'commentaires' => $commentaires,
            'genres' => $genres,
        ]);
    }
    

    #[Route('/film/{id}', name: 'app_film_detail')]
    public function filmDetail(int $id, FilmsRepository $filmsRepository, GenreRepository $genreRepository, EntityManagerInterface $entityManager, Request $request): Response
    {
        $film = $filmsRepository->find($id);
    
        if (!$film) {
            throw $this->createNotFoundException('Ce film n\'existe pas.');
        }
    
        $commentaires = $film->getCommentaires();
        $totalNotes = 0;
        foreach ($commentaires as $comment) {
            $totalNotes += $comment->getRating();
        }
        $moyenneNotes = count($commentaires) > 0 ? round($totalNotes / count($commentaires), 1) : null;
    
        $userHasCommented = false;
        $existingComment = null;
        if ($this->getUser()) {
            foreach ($commentaires as $comment) {
                if ($comment->getUsers() === $this->getUser()) {
                    $userHasCommented = true;
                    $existingComment = $comment;
                    break;
                }
            }
        }
    
        $commentaire = new Commentaire();
        if (!$userHasCommented) {
            $commentaire->setFilms($film);
            $commentaire->setUsers($this->getUser());
            // Ajouter la date automatiquement
            $commentaire->setDateCommentaire(new \DateTime());
            $form = $this->createForm(CommentaireType::class, $commentaire);
            $form->handleRequest($request);
    
            if ($form->isSubmitted() && $form->isValid()) {
                $entityManager->persist($commentaire);
                $entityManager->flush();
                $this->addFlash('success', 'Commentaire ajouté avec succès!');
                return $this->redirectToRoute('app_film_detail', ['id' => $film->getId()]);
            }
        }
    
        $genres = $genreRepository->findAll();
    
        return $this->render('films/detail.html.twig', [
            'film' => $film,
            'form' => $userHasCommented ? null : $form->createView(),
            'commentaires' => $commentaires,
            'moyenne_notes' => $moyenneNotes,
            'userHasCommented' => $userHasCommented,
            'existingComment' => $existingComment,
            'genres' => $genres,
        ]);
    }
    

    #[Route('/edit-comment/{id}', name: 'app_edit_comment', methods: ['GET', 'POST'])]
    public function editComment(Commentaire $commentaire, Request $request, EntityManagerInterface $entityManager, GenreRepository $genreRepository): Response
    {
        if (!$commentaire || $commentaire->getUsers() !== $this->getUser()) {
            throw $this->createAccessDeniedException('Vous n\'avez pas le droit de modifier ce commentaire.');
        }

        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();
            $this->addFlash('success', 'Votre commentaire a été mis à jour.');

            return $this->redirectToRoute('app_film_detail', ['id' => $commentaire->getFilms()->getId()]);
        }

        return $this->render('films/edit_comment.html.twig', [
            'commentForm' => $form->createView(),
        ]);
    }

    #[Route('/recherche/films', name: 'recherche_film')]
    public function search(Request $request, FilmsRepository $filmsRepository, GenreRepository $genreRepository): Response
    {
        // Récupérer le terme de recherche de la requête
        $searchTerm = $request->query->get('recherche', '');
    
        // Utiliser findByPartialName pour trouver les films par terme de recherche partiel
        $films = $filmsRepository->findByPartialName($searchTerm);
    
        // Récupérer tous les genres pour les afficher dans un filtre, par exemple
        $genres = $genreRepository->findAll();
    
        return $this->render('films/recherche_film.html.twig', [
            'films' => $films,
            'genres' => $genres,
        ]);
    }
    

    #[Route('/genre/{id}', name: 'genre_show')]
    public function showByGenre(int $id, GenreRepository $genreRepository, FilmsRepository $filmsRepository): Response
    {
        $genre = $genreRepository->find($id);

        if (!$genre) {
            throw $this->createNotFoundException('Genre non trouvé.');
        }

        $films = $filmsRepository->findFilmsByGenre($genre);

        return $this->render('films/genre_show.html.twig', [
            'genre' => $genre,
            'genres' => $genreRepository->findAll(),
            'films' => $films,
        ]);
    }

    #[Route('/films-tous', name: 'film_list_all')]
    public function listAllFilms(FilmsRepository $filmsRepository,GenreRepository $genreRepository, Request $request): Response
    {
        $order = $request->query->get('order', 'alphabetical'); // Changer la valeur par défaut à 'alphabetical'
    
        $films = match($order) {
            'alphabetical' => $filmsRepository->findAllOrderedByName(),
            'duration' => $filmsRepository->findFilmsOrderedByLongestDuration(),
            'latest' => $filmsRepository->findLatestReleases(),
            default => $filmsRepository->findPopularFilms(),
        };
    
        return $this->render('films/all_films.html.twig', [
            'films' => $films,
            'genres' => $genreRepository->findAll(),

            'current_order' => $order
        ]);
    }
    
    #[Route('/films/populaires', name: 'popular_films')]
public function listPopularFilms(FilmsRepository $filmsRepository, GenreRepository $genreRepository, Request $request): Response
{
    $order = $request->query->get('order', 'popular'); // 'popular' est la valeur par défaut si aucun paramètre 'order' n'est fourni
    $films = match($order) {
        'alphabetical' => $filmsRepository->findAllOrderedByName(),
        'duration' => $filmsRepository->findFilmsOrderedByLongestDuration(),
        'latest' => $filmsRepository->findLatestReleases(),
        default => $filmsRepository->findPopularFilms(),
    };

    return $this->render('films/popular.html.twig', [
        'films' => $films,
        'genres' => $genreRepository->findAll(),
        'current_order' => $order, // Ajoutez cette ligne pour passer la variable au template
    ]);
}
    
    


    // src/Controller/FilmsController.php

    #[Route('/dernieres-sorties', name: 'latest_releases')]
    public function latestReleases(FilmsRepository $filmsRepository, GenreRepository $genreRepository, Request $request): Response
    {
        $order = $request->query->get('order', 'latest'); // 'latest' est la valeur par défaut
        $films = match($order) {
            'alphabetical' => $filmsRepository->findAllOrderedByName(),
            'duration' => $filmsRepository->findFilmsOrderedByLongestDuration(),
            'latest' => $filmsRepository->findLatestReleases(), // Tri par date de sortie par défaut
            default => $filmsRepository->findLatestReleases(),
        };
    
        return $this->render('films/latest_releases.html.twig', [
            'latestFilms' => $films,
            'genres' => $genreRepository->findAll(),
            'current_order' => $order // Ajouter cette ligne pour conserver le tri actuel dans la vue
        ]);
    }
    
    #[Route('/film/add-to-favorites/{id}', name: 'film_add_to_favorites')]
    public function addToFavorites(int $id, EntityManagerInterface $em, Security $security, FavorieRepository $favorieRepository): Response
    {
        $user = $security->getUser();
        if (!$user) {
            return $this->redirectToRoute('app_login');
        }
    
        $film = $em->getRepository(Films::class)->find($id); // Correction ici
        if (!$film) {
            throw $this->createNotFoundException('Le film n\'a pas été trouvé.');
        }
    
        $favorie = $favorieRepository->findOneBy(['users' => $user, 'films' => $film]);
    
        if ($favorie) {
            // Le film est déjà en favori, le retirer des favoris
            $em->remove($favorie);
            $em->flush();
            $this->addFlash('success', 'Le film a été retiré de vos favoris.');
        } else {
            // Ajouter le film aux favoris
            $favorie = new Favorie();
            $favorie->setUsers($user);
            $favorie->setFilms($film);
            $em->persist($favorie);
            $em->flush();
            $this->addFlash('success', 'Le film a été ajouté à vos favoris.');
        }
    
        return $this->redirectToRoute('app_film_detail', ['id' => $id]);
    }
    
        #[Route('/mes-favoris', name: 'mes_favoris')]
        public function mesFavoris(EntityManagerInterface $em,GenreRepository $genreRepository, Security $security): Response
        {
            $user = $security->getUser();
            if (!$user) {
                return $this->redirectToRoute('app_login');
            }
    
            $favoris = $em->getRepository(Favorie::class)->findBy(['users' => $user]);
    
            return $this->render('favoris/mes_favoris.html.twig', [
                'favoris' => $favoris,
                'genres' => $genreRepository->findAll(),

            ]);
        }
    }
