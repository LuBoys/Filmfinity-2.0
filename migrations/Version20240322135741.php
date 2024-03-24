<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240322135741 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE acteur DROP tmdb_id');
        $this->addSql('ALTER TABLE films ADD duree VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE genre DROP tmdb_id');
        $this->addSql('ALTER TABLE producteur DROP tmdb_id');
        $this->addSql('ALTER TABLE realisateur DROP tmdb_id');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE films DROP duree');
        $this->addSql('ALTER TABLE acteur ADD tmdb_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE producteur ADD tmdb_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE realisateur ADD tmdb_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE genre ADD tmdb_id INT DEFAULT NULL');
    }
}
