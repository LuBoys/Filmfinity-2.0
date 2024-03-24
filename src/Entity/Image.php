<?php

namespace App\Entity;

use App\Repository\ImageRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: ImageRepository::class)]
class Image
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $titre = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $photo = null;

    #[ORM\ManyToOne(inversedBy: 'images', cascade: ["remove"])]
    private ?Films $imagefilm = null;
    
    #[ORM\Column(type: "string", length: 255, nullable: true)]
    private ?string $path = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitre(): ?string
    {
        return $this->titre;
    }

    public function setTitre(?string $titre): static
    {
        $this->titre = $titre;

        return $this;
    }

    public function getPhoto(): ?string
    {
        return $this->photo;
    }

    public function setPhoto(?string $photo): static
    {
        $this->photo = $photo;

        return $this;
    }

    public function getImagefilm(): ?Films
    {
        return $this->imagefilm;
    }

    public function setImagefilm(?Films $imagefilm): static
    {
        $this->imagefilm = $imagefilm;

        return $this;
    }

    public function __toString(): string
    {
        return $this->titre ?: ''; // retourne le titre si défini, sinon une chaîne vide
    }

    public function getPath(): ?string
    {
        return $this->path;
    }

}
