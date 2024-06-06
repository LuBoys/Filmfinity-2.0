<?php
    
namespace App\Controller;

use App\Entity\Suggestion;
use App\Form\SuggestionType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SuggestionController extends AbstractController
{
    #[Route('/suggestion', name: 'app_suggestion')]
    public function suggest(Request $request, EntityManagerInterface $entityManager): Response
    {
        $suggestion = new Suggestion();
        $form = $this->createForm(SuggestionType::class, $suggestion);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($suggestion);
            $entityManager->flush();

            $this->addFlash('success', 'Votre suggestion a été envoyée avec succès!');
            return $this->redirectToRoute('app_suggestion');
        }

        return $this->render('suggestion/suggest.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}
