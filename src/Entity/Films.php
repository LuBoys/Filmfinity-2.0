<?php

namespace App\Entity;

use App\Repository\FilmsRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: FilmsRepository::class)]
class Films
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $name = null;

    #[ORM\Column(type: "text", nullable: true)]
    private ?string $description = null;
    
    #[ORM\Column(length: 255, nullable: true)]
    private ?string $duree = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $moderation = null;

    #[ORM\ManyToMany(targetEntity: Acteur::class, mappedBy: 'films')]
    private Collection $acteurs;

    #[ORM\ManyToMany(targetEntity: Realisateur::class, mappedBy: 'films')]
    private Collection $realisateurs;

    #[ORM\ManyToMany(targetEntity: Producteur::class, mappedBy: 'films')]
    private Collection $producteurs;

    #[ORM\ManyToMany(targetEntity: Genre::class, mappedBy: 'films')]
    private Collection $genres;

    #[ORM\OneToMany(mappedBy: 'films', targetEntity: Notes::class)]
    private Collection $notes;

    #[ORM\OneToMany(mappedBy: 'films', targetEntity: Commentaire::class)]
    private Collection $commentaires;

    #[ORM\OneToMany(mappedBy: 'films', targetEntity: Favorie::class)]
    private Collection $favories;

    #[ORM\Column(type: Types::DATE_MUTABLE, nullable: true)]
    private ?\DateTimeInterface $date_sortie = null;

    #[ORM\ManyToMany(targetEntity: LikesFilms::class, inversedBy: 'films')]
    private Collection $likes_films;

    #[ORM\OneToMany(mappedBy: 'imagefilm', targetEntity: Image::class)]
    private Collection $images;
    

    public function __construct()
    {
        $this->acteurs = new ArrayCollection();
        $this->realisateurs = new ArrayCollection();
        $this->producteurs = new ArrayCollection();
        $this->genres = new ArrayCollection();
        $this->notes = new ArrayCollection();
        $this->commentaires = new ArrayCollection();
        $this->favories = new ArrayCollection();
        $this->likes_films = new ArrayCollection();
        $this->image = new ArrayCollection();
        $this->images = new ArrayCollection();
    }

    // ... (toutes vos autres méthodes de getters et setters)

    public function __toString(): string
    {
        return $this->name ?? 'Film sans nom';
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(?string $name): static
    {
        $this->name = $name;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(?string $description): static
    {
        $this->description = $description;

        return $this;
    }

    public function getDuree(): ?string
    {
        return $this->duree;
    }

    public function setDuree(?string $duree): static
    {
        $this->duree = $duree;

        return $this;
    }

    public function getModeration(): ?string
    {
        return $this->moderation;
    }

    public function setModeration(?string $moderation): static
    {
        $this->moderation = $moderation;

        return $this;
    }

    /**
     * @return Collection<int, Acteur>
     */
    public function getActeurs(): Collection
    {
        return $this->acteurs;
    }

    public function addActeur(Acteur $acteur): static
    {
        if (!$this->acteurs->contains($acteur)) {
            $this->acteurs->add($acteur);
            $acteur->addFilm($this);
        }

        return $this;
    }

    public function removeActeur(Acteur $acteur): static
    {
        if ($this->acteurs->removeElement($acteur)) {
            $acteur->removeFilm($this);
        }

        return $this;
    }

    /**
     * @return Collection<int, Realisateur>
     */
    public function getRealisateurs(): Collection
    {
        return $this->realisateurs;
    }

    public function addRealisateur(Realisateur $realisateur): static
    {
        if (!$this->realisateurs->contains($realisateur)) {
            $this->realisateurs->add($realisateur);
            $realisateur->addFilm($this);
        }

        return $this;
    }

    public function removeRealisateur(Realisateur $realisateur): static
    {
        if ($this->realisateurs->removeElement($realisateur)) {
            $realisateur->removeFilm($this);
        }

        return $this;
    }

    /**
     * @return Collection<int, Producteur>
     */
    public function getProducteurs(): Collection
    {
        return $this->producteurs;
    }

    public function addProducteur(Producteur $producteur): static
    {
        if (!$this->producteurs->contains($producteur)) {
            $this->producteurs->add($producteur);
            $producteur->addFilm($this);
        }

        return $this;
    }

    public function removeProducteur(Producteur $producteur): static
    {
        if ($this->producteurs->removeElement($producteur)) {
            $producteur->removeFilm($this);
        }

        return $this;
    }

    /**
     * @return Collection<int, Genre>
     */
    public function getGenres(): Collection
    {
        return $this->genres;
    }

    public function addGenre(Genre $genre): static
    {
        if (!$this->genres->contains($genre)) {
            $this->genres->add($genre);
            $genre->addFilm($this);
        }

        return $this;
    }

    public function removeGenre(Genre $genre): static
    {
        if ($this->genres->removeElement($genre)) {
            $genre->removeFilm($this);
        }

        return $this;
    }

    /**
     * @return Collection<int, Notes>
     */
    public function getNotes(): Collection
    {
        return $this->notes;
    }

    public function addNote(Notes $note): static
    {
        if (!$this->notes->contains($note)) {
            $this->notes->add($note);
            $note->setFilms($this);
        }

        return $this;
    }

    public function removeNote(Notes $note): static
    {
        if ($this->notes->removeElement($note)) {
            // set the owning side to null (unless already changed)
            if ($note->getFilms() === $this) {
                $note->setFilms(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Commentaire>
     */
    public function getCommentaires(): Collection
    {
        return $this->commentaires;
    }

    public function addCommentaire(Commentaire $commentaire): static
    {
        if (!$this->commentaires->contains($commentaire)) {
            $this->commentaires->add($commentaire);
            $commentaire->setFilms($this);
        }

        return $this;
    }

    public function removeCommentaire(Commentaire $commentaire): static
    {
        if ($this->commentaires->removeElement($commentaire)) {
            // set the owning side to null (unless already changed)
            if ($commentaire->getFilms() === $this) {
                $commentaire->setFilms(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Favorie>
     */
    public function getFavories(): Collection
    {
        return $this->favories;
    }

    public function addFavory(Favorie $favory): static
    {
        if (!$this->favories->contains($favory)) {
            $this->favories->add($favory);
            $favory->setFilms($this);
        }

        return $this;
    }

    public function removeFavory(Favorie $favory): static
    {
        if ($this->favories->removeElement($favory)) {
            // set the owning side to null (unless already changed)
            if ($favory->getFilms() === $this) {
                $favory->setFilms(null);
            }
        }

        return $this;
    }

    public function getDateSortie(): ?\DateTimeInterface
    {
        return $this->date_sortie;
    }

    public function setDateSortie(?\DateTimeInterface $date_sortie): static
    {
        $this->date_sortie = $date_sortie;

        return $this;
    }

    /**
     * @return Collection<int, LikesFilms>
     */
    public function getLikesFilms(): Collection
    {
        return $this->likes_films;
    }

    public function addLikesFilm(LikesFilms $likesFilm): static
    {
        if (!$this->likes_films->contains($likesFilm)) {
            $this->likes_films->add($likesFilm);
        }

        return $this;
    }

    public function removeLikesFilm(LikesFilms $likesFilm): static
    {
        $this->likes_films->removeElement($likesFilm);

        return $this;
    }
    public function isLikedByUser(Users $user): bool {
        foreach ($this->likes_films as $likeFilm) {
            if ($likeFilm->getUser()->getId() === $user->getId()) return true;
        }
        return false;
    }

/**
 * @return Collection<int, Image>
 */
public function getImages(): Collection
{
    return $this->images;
}

public function addImage(Image $image): static
{
    if (!$this->images->contains($image)) {
        $this->images->add($image);
        $image->setImagefilm($this); // Changed from setFilms
    }

    return $this;
}

public function removeImage(Image $image): static
{
    if ($this->images->removeElement($image)) {
        // set the owning side to null (unless already changed)
        if ($image->getImagefilm() === $this) { // Changed from getFilms
            $image->setImagefilm(null); // Changed from setFilms
        }
    }

    return $this;
}
public function getFirstImagePath(): ?string
{
    if ($this->images->isEmpty()) {
        return null;
    }

    return $this->images->first()->getPath();
}
  /**
     * @ORM\OneToMany(targetEntity=Commentaire::class, mappedBy="film")
     */

    public function getAverageRating(): ?float
    {
        if (count($this->commentaires) === 0) {
            return null;
        }
        
        $sum = array_reduce($this->commentaires->toArray(), function ($total, $commentaire) {
            return $total + $commentaire->getRating();
        }, 0);
        
        return $sum / count($this->commentaires);
    }
}
