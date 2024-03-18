<?php

namespace App\Controller\Admin;

use App\Entity\Films;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;

class FilmsCrudController extends AbstractCrudController
{
    
    public static function getEntityFqcn(): string
    {
        return Films::class;
    }

    public function configureFields(string $pageName): iterable
    {
        return [
            TextField::new('name'),
            IntegerField::new('duree')->setLabel('Durée (en minutes)'),
            DateField::new('date_sortie')->setLabel('Date de sortie'),
            TextEditorField::new('description'),
            AssociationField::new('genres')
                ->setFormTypeOptions([
                    'by_reference' => false,
                ]),
            AssociationField::new('acteurs')
                ->setFormTypeOptions([
                    'by_reference' => false,
                ]),
            AssociationField::new('producteurs')
                ->setFormTypeOptions([
                    'by_reference' => false,
                ]),
            AssociationField::new('realisateurs')
                ->setFormTypeOptions([
                    'by_reference' => false,
                ]),
                AssociationField::new('images')
                ->setFormTypeOptions([
                    'by_reference' => false,
                ]),
                AssociationField::new('notes')
                ->setFormTypeOptions([
                    'by_reference' => false,
                ]),
            ];
    }
}
