<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AccessorySeeder extends Seeder
{
    public function run(): void
    {
        DB::table('accessories')->insert([
            ['name_en' => 'Battery',             'name_ja' => 'バッテリー'],
            ['name_en' => 'Battery charger',     'name_ja' => 'バッテリーチャージャー'],
            ['name_en' => 'Strap',               'name_ja' => 'ストラップ'],
            ['name_en' => 'Body cap',            'name_ja' => 'ボディキャップ'],
            ['name_en' => 'Hot shoe cover',      'name_ja' => 'ホットシューカバー'],
            ['name_en' => 'USB cable',           'name_ja' => 'USBケーブル'],
            ['name_en' => 'Cable protector',     'name_ja' => 'ケーブルプロテクター'],
            ['name_en' => 'Eyepiece cup',        'name_ja' => 'アイピースカップ'],
        ]);
    }
}
