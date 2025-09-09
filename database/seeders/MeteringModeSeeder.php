<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class MeteringModeSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('metering_modes')->insert([
            ['name_en' => 'Multi-pattern',         'name_ja' => 'マルチパターン測光'], // Nikon系
            ['name_en' => 'Evaluative',            'name_ja' => '評価測光'],           // Canon系
            ['name_en' => 'Spot',                  'name_ja' => 'スポット測光'],
            ['name_en' => 'Partial',               'name_ja' => '部分測光'],           // Canon系
            ['name_en' => 'Center-weighted',       'name_ja' => '中央重点測光'],
            ['name_en' => 'Highlight-weighted',    'name_ja' => 'ハイライト重点測光'],
            ['name_en' => 'Average',               'name_ja' => '画面全体平均測光'],   // 一般的には "Average" や "Full-frame average"
        ]);
    }
}
