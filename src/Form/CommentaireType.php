<?php
namespace App\Form;
use App\Entity\Commentaire;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;

class CommentaireType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('commentaire', TextareaType::class)
            ->add('rating', IntegerType::class, [
                'label' => 'Note (1 à 5)',
                'attr' => [
                    'min' => 1,
                    'max' => 5
                ]
            ]);
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Commentaire::class,
            // Ajoutez cette option si votre formulaire inclut des données qui ne sont pas dans l'entité Commentaire
            'allow_extra_fields' => true, 
        ]);
    }
}
