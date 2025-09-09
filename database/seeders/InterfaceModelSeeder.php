<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class InterfaceModelSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('interface_models')->insert([
            ['name_en' => 'Accessory Shoe',                     'name_ja' => 'アクセサリーシュー（電子接点無）'],
            ['name_en' => 'Hot Shoe',                           'name_ja' => 'ホットシュー（電子接点有）'],
            ['name_en' => 'Sync Terminal / Timecode Terminal',  'name_ja' => 'シンクロターミナル/タイムコード端子'],
            ['name_en' => 'Remote Terminal (Type N3)',          'name_ja' => 'リモコン端子（タイプN3）'],
            ['name_en' => 'USB 3.1 Gen1 Type-C',                'name_ja' => 'USB 3.1 Gen1 Type C'],
            ['name_en' => 'HDMI Type-A Terminal (2.1)',         'name_ja' => 'HDMI端子 2.1 Type A'],
            ['name_en' => 'HDMI Micro Terminal (Type D)',       'name_ja' => 'HDMIマイクロ端子（タイプD）'],
            ['name_en' => 'Audio Output (3.5mm)',               'name_ja' => 'オーディオ アウト3.5 mm'],
            ['name_en' => 'Audio Input (3.5mm)',                'name_ja' => 'オーディオ イン3.5 mm'],
            ['name_en' => 'LAN Terminal',                       'name_ja' => 'LAN端子'],
            ['name_en' => 'Communication Interface',            'name_ja' => '通信インターフェース'],
        ]);
    }
}
