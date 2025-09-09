<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class FeatureSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('features')->insert([
            ['name_en' => 'Dust and Splash Resistance',     'name_ja' => '防塵・防滴'],
            ['name_en' => 'Image Stabilization',            'name_ja' => '手ブレ補正機構'],
            ['name_en' => '5-Axis Stabilization',           'name_ja' => '5軸手ブレ補正'],
            ['name_en' => 'Selfie Support',                 'name_ja' => '自分撮り機能'],
            ['name_en' => 'Touch Panel',                    'name_ja' => 'タッチパネル'],
            ['name_en' => 'Dust Removal System',            'name_ja' => 'ゴミ取り機構'],
            ['name_en' => 'Built-in Flash',                 'name_ja' => '内蔵フラッシュ'],
            ['name_en' => 'Time-lapse Photography',         'name_ja' => 'タイムラプス'],
            ['name_en' => 'Live View',                      'name_ja' => 'ライブビュー'],
            ['name_en' => 'GPS',                            'name_ja' => 'GPS'],
            ['name_en' => 'USB Charging',                   'name_ja' => 'UBS充電'],
            ['name_en' => 'RAW+JPEG Simultaneous Recording','name_ja' => 'RAW+JPEG同時記録'],
            ['name_en' => 'Bulb Mode',                      'name_ja' => 'バルブ'],
            ['name_en' => 'Wi-Fi',                          'name_ja' => 'Wi-Fi'],
            ['name_en' => 'NFC',                            'name_ja' => 'NFC'],
            ['name_en' => 'Focus Peaking',                  'name_ja' => 'ピーキング表示'],
        ]);
    }
}
