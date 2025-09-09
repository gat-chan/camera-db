<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CameraTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        DB::table('camera_types')->insert([
            [
                'name_en' => 'DSLR',
                'name_ja' => '一眼レフ',
            ],
            [
                'name_en' => 'Mirrorless',
                'name_ja' => 'ミラーレス',
            ],
            [
                'name_en' => 'Rangefinder',
                'name_ja' => 'レンジファインダー',
            ],
            [
                'name_en' => 'Compact',
                'name_ja' => 'コンパクト',
            ],
            [
                'name_en' => 'Medium Format',
                'name_ja' => '中判カメラ',
            ],
            [
                'name_en' => 'Film',
                'name_ja' => 'フィルムカメラ',
            ],
        ]);
    }
}
