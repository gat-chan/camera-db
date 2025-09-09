<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LensMountSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        DB::table('lens_mounts')->insert([
            [
                'name_en' => 'Canon EF',
                'name_ja' => 'キヤノンEFマウント',
            ],
            [
                'name_en' => 'Canon RF',
                'name_ja' => 'キヤノンRFマウント',
            ],
            [
                'name_en' => 'Nikon F',
                'name_ja' => 'ニコンFマウント',
            ],
            [
                'name_en' => 'Nikon Z',
                'name_ja' => 'ニコンZマウント',
            ],
            [
                'name_en' => 'Sony E',
                'name_ja' => 'ソニーEマウント',
            ],
            [
                'name_en' => 'Sony A',
                'name_ja' => 'ソニーAマウント',
            ],
            [
                'name_en' => 'Fujifilm X',
                'name_ja' => '富士フイルムXマウント',
            ],
            [
                'name_en' => 'Micro Four Thirds',
                'name_ja' => 'マイクロフォーサーズマウント',
            ],
            [
                'name_en' => 'Leica M',
                'name_ja' => 'ライカMバヨネットマウント',
            ],
            [
                'name_en' => 'Leica L',
                'name_ja' => 'ライカLバヨネットマウント',
            ],
            [
                'name_en' => 'Leica L39',
                'name_ja' => 'ライカL39マウント',
            ],
            [
                'name_en' => 'Pentax K',
                'name_ja' => 'ペンタックスKマウント',
            ],
            [
                'name_en' => 'Hasselblad X (XCD)',
                'name_ja' => 'ハッセルブラッド Xマウント (XCD)',
            ],
        ]);
    }
}
