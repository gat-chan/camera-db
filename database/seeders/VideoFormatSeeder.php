<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class VideoFormatSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('video_formats')->insert([
            ['name_en' => 'MP4',             'name_ja' => 'MP4'],
            ['name_en' => 'MOV',             'name_ja' => 'MOV'],
            ['name_en' => 'AVCHD',           'name_ja' => 'AVCHD'],
            ['name_en' => 'XAVC S',          'name_ja' => 'XAVC S'],
            ['name_en' => 'XAVC HS',         'name_ja' => 'XAVC HS'],
            ['name_en' => 'XAVC S-I',        'name_ja' => 'XAVC S-I'],
            ['name_en' => 'MOV All-I / IPB', 'name_ja' => 'MOV All-I/IPB'],
        ]);
    }
}
