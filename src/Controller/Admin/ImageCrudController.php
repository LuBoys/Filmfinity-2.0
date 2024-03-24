<?php

namespace App\Controller\Admin;

use App\Entity\Image;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;


class ImageCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Image::class;
    }

    
    public function configureFields(string $pageName): iterable
    {
        return [
            AssociationField::new('imagefilm'),
            TextField::new('titre', 'Type de l\'image'),
            ImageField::new('photo', 'Votre image')
                    ->setBasePath('assets/img/') // Correspond au chemin public de votre image
                    ->setUploadDir('public/assets/img') // Correspond au chemin de téléchargement
                    ->setUploadedFileNamePattern('[randomhash].[extension]')
                    ->setRequired(false),
        ];
    }
    
    
    

    
}
