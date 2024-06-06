<?php
namespace App\Controller\Admin;

use App\Repository\SuggestionRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin')]
class AdminController extends AbstractController
{
    #[Route('/suggestions', name: 'admin_suggestions')]
    public function suggestions(SuggestionRepository $suggestionRepository): Response
    {
        $suggestions = $suggestionRepository->findAll();

        return $this->render('admin/suggestions.html.twig', [
            'suggestions' => $suggestions,
        ]);
    }
}
