<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        // User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);

        $this->call([
            ManufacturerSeeder::class,    // メーカー
            CameraTypeSeeder::class,      // カメラタイプ
            LensMountSeeder::class,       // レンズマウント
            SensorTypeSeeder::class,      // センサータイプ
            ColorOptionSeeder::class,     // カラー展開
            SelfTimerSecondSeeder::class, // セルフタイマー
            PhotoFormatSeeder::class,     // 静止画記録フォーマット
            VideoFormatSeeder::class,     // 動画記録フォーマット
            VideoCodecSeeder::class,      // 映像圧縮方式
            InterfaceModelSeeder::class,  // インターフェース
            RecordingMediaSeeder::class,  // 記録メディア
            AccessorySeeder::class,       // 付属品
            FeatureSeeder::class,         // その他機能
            DisplayLanguageSeeder::class, // 表示言語
            CameraSeeder::class,          // カメラデータ
            UserSeeder::class,            // ユーザーデータ
        ]);
    }
}
