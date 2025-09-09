<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ManufacturerSeeder extends Seeder
{
    public function run(): void
    {

        DB::table('manufacturers')->insert([
            [
                'name_en' => 'Canon',
                'name_ja' => 'キヤノン',
                'country_en' => 'Japan',
                'country_ja' => '日本',
                'founded_year' => 1937,
            ],
            [
                'name_en' => 'Nikon',
                'name_ja' => 'ニコン',
                'country_en' => 'Japan',
                'country_ja' => '日本',
                'founded_year' => 1917,
            ],
            [
                'name_en' => 'Sony',
                'name_ja' => 'ソニー',
                'country_en' => 'Japan',
                'country_ja' => '日本',
                'founded_year' => 1946,
            ],
            [
                'name_en' => 'Fujifilm',
                'name_ja' => '富士フイルム',
                'country_en' => 'Japan',
                'country_ja' => '日本',
                'founded_year' => 1934,
            ],
            [
                'name_en' => 'Olympus',
                'name_ja' => 'オリンパス',
                'country_en' => 'Japan',
                'country_ja' => '日本',
                'founded_year' => 1919,
            ],
            [
                'name_en' => 'Leica',
                'name_ja' => 'ライカ',
                'country_en' => 'Germany',
                'country_ja' => 'ドイツ',
                'founded_year' => 1914,
            ],
            [
                'name_en' => 'Panasonic',
                'name_ja' => 'パナソニック',
                'country_en' => 'Japan',
                'country_ja' => '日本',
                'founded_year' => 1918,
            ],
            [
                'name_en' => 'Pentax',
                'name_ja' => 'ペンタックス',
                'country_en' => 'Japan',
                'country_ja' => '日本',
                'founded_year' => 1919,
            ],
            [
                'name_en' => 'Hasselblad',
                'name_ja' => 'ハッセルブラッド',
                'country_en' => 'Sweden',
                'country_ja' => 'スウェーデン',
                'founded_year' => 1841,
            ],
        ]);
    }
}
