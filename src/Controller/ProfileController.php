<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Form\UserProfileType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use Symfony\Component\Form\FormError;

class ProfileController extends AbstractController
{
    #[Route('/profile', name: 'app_profile')]
    public function edit(Request $request, UserPasswordHasherInterface $passwordHasher, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();
        if (!$user) {
            throw new AccessDeniedException('Vous devez être connecté pour accéder à cette page.');
        }

        $form = $this->createForm(UserProfileType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Vérifiez d'abord si le formulaire est valide avant de vérifier le mot de passe
            $password = $form->get('password')->getData();
            if ($password && !$passwordHasher->isPasswordValid($user, $password)) {
                $form->get('password')->addError(new FormError('Le mot de passe est incorrect.'));
            } else {
                // La logique de mise à jour du profil ici
                $entityManager->persist($user);
                $entityManager->flush();
                
                $this->addFlash('success', 'Votre profil a été mis à jour avec succès.');
                return $this->redirectToRoute('app_profile');
            }
        }
        
        return $this->render('profile/index.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}
