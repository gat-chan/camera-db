<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PhotoFormatSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('photo_formats')->insert([
            ['name_en' => 'JPEG',      'name_ja' => 'JPEG'],
            ['name_en' => 'HEIF',      'name_ja' => 'HEIF'],
            ['name_en' => 'RAW',       'name_ja' => 'RAW'],
            ['name_en' => 'DPRAW',     'name_ja' => 'DPRAW'],
            ['name_en' => 'C-RAW',     'name_ja' => 'C-RAW'],
            ['name_en' => '3FR RAW',   'name_ja' => '3FR RAW'],
            ['name_en' => 'DNG',       'name_ja' => 'DNG'],
            ['name_en' => 'NEF(RAW)',  'name_ja' => 'NEF（RAW）'],
            ['name_en' => 'TIFF',  'name_ja' => 'TIFF'],
        ]);
    }
}
