<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ColorOptionSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('color_options')->insert([
            ['name_en' => 'Black',       'name_ja' => 'ブラック'],
            ['name_en' => 'Silver',      'name_ja' => 'シルバー'],
            ['name_en' => 'White',       'name_ja' => 'ホワイト'],
            ['name_en' => 'Gray',        'name_ja' => 'グレー'],
            ['name_en' => 'Red',         'name_ja' => 'レッド'],
            ['name_en' => 'Blue',        'name_ja' => 'ブルー'],
            ['name_en' => 'Brown',       'name_ja' => 'ブラウン'],
            ['name_en' => 'Green',       'name_ja' => 'グリーン'],
            ['name_en' => 'Champagne',   'name_ja' => 'シャンパンゴールド'],
            ['name_en' => 'Titanium',    'name_ja' => 'チタン'],
            ['name_en' => 'Beige',       'name_ja' => 'ベージュ'],
            ['name_en' => 'Pink',        'name_ja' => 'ピンク'],
            ['name_en' => 'Orange',      'name_ja' => 'オレンジ'],
            ['name_en' => 'Navy',        'name_ja' => 'ネイビー'],
            ['name_en' => 'Olive',       'name_ja' => 'オリーブ'],
            ['name_en' => 'Graphite',    'name_ja' => 'グラファイト'],
            ['name_en' => 'Gunmetal',    'name_ja' => 'ガンメタリック'],
            ['name_en' => 'Limited Edition', 'name_ja' => '限定カラー'],
        ]);
    }
}
