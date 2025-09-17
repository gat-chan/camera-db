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
            'is_admin' => '1',
            ],
            ['name'    => 'normaluser',
            'email'    => 'normal@example.com',
            'password' => '$2y$12$xv/Pa5425eoyZYzo7gCfQeP96BCFbHCVu33OJY8g/1KtnY4O0/MPK',
            'is_admin' => '0',
            ],
        ]);
    }
}
