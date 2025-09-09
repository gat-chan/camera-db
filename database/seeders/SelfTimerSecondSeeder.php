<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SelfTimerSecondSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('self_timer_seconds')->insert([
            ['name_en' => '2s',    'name_ja' => '2秒'],
            ['name_en' => '3s',    'name_ja' => '3秒'],
            ['name_en' => '5s',    'name_ja' => '5秒'],
            ['name_en' => '6s',    'name_ja' => '6秒'],
            ['name_en' => '10s',    'name_ja' => '10秒'],
            ['name_en' => '12s',    'name_ja' => '12秒'],
            ['name_en' => '20s',    'name_ja' => '20秒'],
            ['name_en' => '30s',    'name_ja' => '30秒'],
        ]);
    }
}
