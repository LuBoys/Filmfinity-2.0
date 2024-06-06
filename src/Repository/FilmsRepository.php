<?php

namespace App\Repository;

use App\Entity\Films;
use App\Entity\Genre;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Films>
 */
class FilmsRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Films::class);
    }

    public function findFilmsByGenre(Genre $genre)
    {
        return $this->createQueryBuilder('f')
            ->innerJoin('f.genres', 'g')
            ->where('g = :genre')
            ->setParameter('genre', $genre)
            ->getQuery()
            ->getResult();
    }

    public function findPopularFilms()
    {
        return $this->createQueryBuilder('f')
            ->leftJoin('f.commentaires', 'c')
            ->addSelect('COALESCE(AVG(c.rating), 0) AS HIDDEN avgRating') // Treat NULL as 0
            ->groupBy('f.id')
            ->orderBy('avgRating', 'DESC') // Sort by avgRating descending
            ->setMaxResults(10)
            ->getQuery()
            ->getResult();
    }
    
    

    public function findLatestReleases()
    {
        return $this->createQueryBuilder('f')
            ->orderBy('f.date_sortie', 'DESC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult();
    }

    // Ajouter la méthode pour trier par ordre alphabétique
    public function findAllOrderedByName()
    {
        return $this->createQueryBuilder('f')
            ->orderBy('f.name', 'ASC')
            ->getQuery()
            ->getResult();
    }
    

    // Ajouter la méthode pour trier par durée
    public function findFilmsOrderedByLongestDuration()
    {
        return $this->createQueryBuilder('f')
            ->orderBy('f.duree', 'DESC') // Supposons que 'duree' représente la durée du film
            ->getQuery()
            ->getResult();
    }
    public function findByPartialName(string $searchTerm): array
    {
        return $this->createQueryBuilder('f')
            ->where('LOWER(f.name) LIKE LOWER(:searchTerm)')
            ->setParameter('searchTerm', '%' . $searchTerm . '%')
            ->getQuery()
            ->getResult();
    }
    
}
