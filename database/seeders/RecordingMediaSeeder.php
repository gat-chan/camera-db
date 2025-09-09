<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RecordingMediaSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('recording_medias')->insert([
            ['name_en' => 'SD',     'name_ja' => 'SD'],
            ['name_en' => 'SDHC',   'name_ja' => 'SDHC'],
            ['name_en' => 'SDXC',   'name_ja' => 'SDXC'],
            ['name_en' => 'CFexpress card type B',   'name_ja' => 'CFexpress card type B'],
            ['name_en' => 'UHS-I',  'name_ja' => 'UHS-I対応'],
            ['name_en' => 'UHS-II', 'name_ja' => 'UHS-II対応'],
        ]);
    }
}
