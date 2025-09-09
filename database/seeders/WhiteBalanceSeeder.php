<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class WhiteBalanceSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('white_balances')->insert([
            ['name_en' => 'Auto',                 'name_ja' => 'オート'],
            ['name_en' => 'Daylight',             'name_ja' => '晴天 (太陽光)'],
            ['name_en' => 'Cloudy',               'name_ja' => '曇天 (くもり)'],
            ['name_en' => 'Shade',                'name_ja' => '日陰'],
            ['name_en' => 'Tungsten',             'name_ja' => '白熱灯 (電球)'],
            ['name_en' => 'Fluorescent Warm',     'name_ja' => '蛍光灯 (暖色)'],
            ['name_en' => 'Fluorescent Cool',     'name_ja' => '蛍光灯 (寒色)'],
            ['name_en' => 'Flash',                'name_ja' => 'フラッシュ'],
            ['name_en' => 'Water',                'name_ja' => '水中オート'],
            ['name_en' => 'Custom Color Temp',    'name_ja' => '色温度マニュアル'],
        ]);
    }
}
