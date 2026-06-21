<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            TipoDocumentoSeeder::class,
            ConfiguracionInstitucionalSeeder::class,
            SedeSeeder::class,
            GrupoAcademicoSeeder::class,
            FacultadSeeder::class,
            CarreraSeeder::class,
            CicloAcademicoSeeder::class,
            TurnoSeeder::class,
            CanalPagoSeeder::class,
            ConceptoPagoSeeder::class,
            CodigoPagoExternoSeeder::class,
            RolePermissionSeeder::class,
        ]);
    }
}
