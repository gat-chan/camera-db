<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AudioFormatSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('audio_formats')->insert([
            ['name_en' => 'AAC 48 kHz/16 Bit',       'name_ja' => 'AAC 48 kHz/16 Bit'],
            ['name_en' => 'LPCM 48 kHz/24 Bit',      'name_ja' => 'LPCM 48 kHz/24 Bit'],
            ['name_en' => 'LPCM 2ch (16bit 48 kHz)', 'name_ja' => 'LPCM 2ch (16bit 48 kHz)'],
        ]);
    }
}
