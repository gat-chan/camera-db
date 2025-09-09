<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class VideoCodecSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('video_codecs')->insert([
            ['name_en' => 'H.264',         'name_ja' => 'H.264 (MPEG-4 Part 10/AVC)'],
            ['name_en' => 'H.265',         'name_ja' => 'H.265 (MPEG-H Part 2/HEVC)'],
            ['name_en' => 'ProRes',        'name_ja' => 'ProRes (422/HQ/LT)'],
            ['name_en' => 'ProRes RAW',    'name_ja' => 'ProRes RAW(Apple)'],
            ['name_en' => 'BRAW',          'name_ja' => 'BRAW（Blackmagic RAW）'],
            ['name_en' => 'Canon RAW/CRM', 'name_ja' => 'Canon RAW/CRM（Cinema RAW Light）'],
            ['name_en' => 'N-RAW',         'name_ja' => 'N-RAW'],
            ['name_en' => 'Long GOP',      'name_ja' => 'Long GOP'],
        ]);
    }
}
