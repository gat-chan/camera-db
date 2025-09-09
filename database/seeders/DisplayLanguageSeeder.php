<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DisplayLanguageSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('display_languages')->insert([
            ['name_en' => 'English',             'name_ja' => '英語'],
            ['name_en' => 'German',              'name_ja' => 'ドイツ語'],
            ['name_en' => 'French',              'name_ja' => 'フランス語'],
            ['name_en' => 'Italian',             'name_ja' => 'イタリア語'],
            ['name_en' => 'Spanish',             'name_ja' => 'スペイン語'],
            ['name_en' => 'Portuguese',          'name_ja' => 'ポルトガル語'],
            ['name_en' => 'Russian',             'name_ja' => 'ロシア語'],
            ['name_en' => 'Japanese',            'name_ja' => '日本語'],
            ['name_en' => 'Traditional Chinese', 'name_ja' => '繁体中国語'],
            ['name_en' => 'Simplified Chinese',  'name_ja' => '簡体中国語'],
            ['name_en' => 'Korean',              'name_ja' => '韓国語'],
            ['name_en' => 'Arabic',              'name_ja' => 'アラビア語'],
            ['name_en' => 'Persian',             'name_ja' => 'ペルシャ語'],
            ['name_en' => 'Thai',                'name_ja' => 'タイ語'],
            ['name_en' => 'Malay',               'name_ja' => 'マレー語'],
        ]);
    }
}
