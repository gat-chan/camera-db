<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SensorTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        DB::table('sensor_types')->insert([
            [
                'name_en' => 'Full Frame',
                'name_ja' => 'フルサイズ',
            ],
            [
                'name_en' => 'APS-C',
                'name_ja' => 'APS-C',
            ],
            [
                'name_en' => 'APS-H',
                'name_ja' => 'APS-H',
            ],
            [
                'name_en' => 'Micro Four Thirds',
                'name_ja' => 'マイクロフォーサーズ',
            ],
            [
                'name_en' => '1 inch',
                'name_ja' => '1型',
            ],
            [
                'name_en' => 'Medium Format',
                'name_ja' => '中判',
            ],
            [
                'name_en' => '1/1.7 inch',
                'name_ja' => '1/1.7型',
            ],
            [
                'name_en' => '1/2.3 inch',
                'name_ja' => '1/2.3型',
            ],
            [
                'name_en' => 'Four Thirds',
                'name_ja' => 'フォーサーズ',
            ],
            [
                'name_en' => 'CX (1 inch Nikon)',
                'name_ja' => 'CX（ニコン1型）',
            ],
        ]);
    }
}
