<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('users')->insert([
            ['name'    => 'admin',
            'email'    => 'test@example.com',
            'password' => '$2y$12$EkzhLjQb2zSa9hiQZ51flOFcouNUqcY61TeqwrmRQuFxsre7ndZUe',
            ]
        ]);
    }
}
