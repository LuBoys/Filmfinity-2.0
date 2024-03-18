<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use App\Entity\Users;
use App\Form\RegistrationFormType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Http\Authentication\UserAuthenticatorInterface;
use App\Security\LoginAuthentificatorAuthenticator;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Symfony\Component\Form\FormError;


class RegistrationController extends AbstractController
{
    #[Route('/register', name: 'app_register')]
    public function register(
        Request $request, 
        UserPasswordHasherInterface $passwordHasher, 
        EntityManagerInterface $entityManager,
        UserAuthenticatorInterface $userAuthenticator,
        LoginAuthentificatorAuthenticator $authenticator
    ): Response {
        $user = new Users();
        $form = $this->createForm(RegistrationFormType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted()) {
            $plainPassword = $form->get('plainPassword')->getData();
            if (!is_array($plainPassword) || !isset($plainPassword['first'], $plainPassword['second']) || $plainPassword['first'] !== $plainPassword['second']) {
                $form->get('plainPassword')->addError(new FormError('Les mots de passe ne correspondent pas.'));
            }

            if ($form->isValid()) {
                $user->setPassword($passwordHasher->hashPassword($user, $plainPassword['first']));

                $entityManager->persist($user);
                $entityManager->flush();

                // Authentifier l'utilisateur
                $userAuthenticator->authenticateUser($user, $authenticator, $request);

                // Rediriger vers la page d'accueil après inscription et connexion réussies
                return $this->redirectToRoute('app_homepage');
            }
        }

        return $this->render('registration/register.html.twig', [
            'registrationForm' => $form->createView(),
        ]);
    }
}
