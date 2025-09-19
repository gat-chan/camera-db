<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Camera;
use App\Models\Manufacturer;
use App\Models\CameraType;
use App\Models\LensMount;
use App\Models\SensorType;
use App\Models\ColorOption;
use App\Models\Feature;
use App\Models\RecordingMedia;
use App\Models\InterfaceModel;
use App\Models\Accessory;
use App\Models\AfMethod;
use App\Models\DisplayLanguage;
use App\Models\PhotoFormat;
use App\Models\VideoFormat;
use App\Models\VideoCodec;
use App\Models\SelfTimerSecond;

class CameraSeeder extends Seeder
{
    public function run(): void
    {
        $rawCameras = include(database_path('data/cameras/all_cameras.php'));

        DB::beginTransaction();

        try {
            foreach ($rawCameras as $item) {
                // 各リレーション取得
                $manufacturer       = Manufacturer::where('name_ja', $item['manufacturer_name'])->orWhere('name_en', $item['manufacturer_name'])->first();
                $camera_type        = CameraType::where('name_ja', $item['camera_type_name'])->orWhere('name_en', $item['camera_type_name'])->first();
                $lens_mount         = LensMount::where('name_ja', $item['lens_mount_name'])->orWhere('name_en', $item['lens_mount_name'])->first();
                $sensor_type        = SensorType::where('name_ja', $item['sensor_type_name'])->orWhere('name_en', $item['sensor_type_name'] ?? '')->first();
                $color_option       = ColorOption::where('name_ja', $item['color_option_name'] ?? '')->orWhere('name_en', $item['color_option_name'] ?? '')->first();
                $self_timer_second  = SelfTimerSecond::where('name_ja', $item['self_timer_second_name'] ?? '')->orWhere('name_en', $item['self_timer_second_name'] ?? '')->first();
                $recording_media    = RecordingMedia::where('name_ja', $item['recording_media_name'] ?? '')->orWhere('name_en', $item['recording_media_name'] ?? '')->first();
                $photo_format       = PhotoFormat::where('name_ja', $item['photo_format_name'] ?? '')->orWhere('name_en', $item['photo_format_name'] ?? '')->first();
                $video_format       = VideoFormat::where('name_ja', $item['video_format_name'] ?? '')->orWhere('name_en', $item['video_format_name'] ?? '')->first();
                $video_codec        = VideoCodec::where('name_ja', $item['video_codec_name'] ?? '')->orWhere('name_en', $item['video_codec_name'] ?? '')->first();
                $interface_model    = InterfaceModel::where('name_ja', $item['interface_model_name'] ?? '')->orWhere('name_en', $item['interface_model_name'] ?? '')->first();
                $accessory          = Accessory::where('name_ja', $item['accessory_name'] ?? '')->orWhere('name_en', $item['accessory_name'] ?? '')->first();
                $display_language   = DisplayLanguage::where('name_ja', $item['display_language_name'] ?? '')->orWhere('name_en', $item['display_language_name'] ?? '')->first();

                // 登録
                $camera = Camera::create([
                    'manufacturer_id'          => optional($manufacturer)->id,
                    'camera_name'              => $item['camera_name'],
                    'model_number'             => $item['model_number'] ?? null,
                    'camera_type_id'           => optional($camera_type)->id,
                    'lens_mount_id'            => optional($lens_mount)->id,
                    'release_year'             => $item['release_year'] ?? null,
                    'discontinued_year'        => $item['discontinued_year'] ?? null,
                    'price'                    => $item['price_history']['price'] ?? $item['price'] ?? null,
                    'price_data' => $item['price_data'] ?? null,
                    // 'price_data'               => $item['price_history']['price_data'] ?? $item['price_data'] ?? null,
                    'color_option_id'          => optional($color_option)->id,
                    'total_pixels'             => $item['total_pixels'] ?? null,
                    'effective_pixels'         => $item['effective_pixels'] ?? null,
                    'sensor_type_id'           => optional($sensor_type)->id,
                    'sensor_width_mm'          => $item['sensor_width_mm'] ?? null,
                    'sensor_height_mm'         => $item['sensor_height_mm'] ?? null,
                    'image_sensor'             => $item['image_sensor'] ?? null,
                    'image_processor'          => $item['image_processor'] ?? null,
                    'viewfinder_type'          => $item['viewfinder_type'] ?? null,
                    'viewfinder_coverage'      => $item['viewfinder_coverage'] ?? null,
                    'viewfinder_magnification' => $item['viewfinder_magnification'] ?? null,
                    'lcd_type'                 => $item['lcd_type'] ?? null,
                    'lcd_size_inch'            => $item['lcd_size_inch'] ?? null,
                    'lcd_resolution_dots'      => $item['lcd_resolution_dots'] ?? null,
                    'iso_standard_min'         => $item['iso_standard_min'] ?? null,
                    'iso_standard_max'         => $item['iso_standard_max'] ?? null,
                    'iso_extended_min'         => $item['iso_extended_min'] ?? null,
                    'iso_extended_max'         => $item['iso_extended_max'] ?? null,
                    'metering_method'          => $item['metering_method'] ?? null,
                    'metering_mode'            => $item['metering_mode'] ?? null,
                    'exposure_value'           => $item['exposure_value'] ?? null,
                    'shutter_electronic_min'   => $item['shutter_electronic_min'] ?? null,
                    'shutter_electronic_max'   => $item['shutter_electronic_max'] ?? null,
                    'shutter_mechanical_min'   => $item['shutter_mechanical_min'] ?? null,
                    'shutter_mechanical_max'   => $item['shutter_mechanical_max'] ?? null,
                    'drive_mode'               => $item['drive_mode'] ?? null,
                    'burst_mode_fps'           => $item['burst_mode_fps'] ?? null,
                    'self_timer_second_id'     => optional($self_timer_second)->id,
                    'white_balance'            => $item['white_balance'] ?? null,
                    'temperature_low'          => $item['temperature_low'] ?? null,
                    'temperature_high'         => $item['temperature_high'] ?? null,
                    'af_methods'               => $item['af_methods'] ?? null,
                    'af_points'                => $item['af_points'] ?? null,
                    'buffer_memory_mb'         => $item['buffer_memory_mb'] ?? null,
                    'internal_memory_gb'       => $item['internal_memory_gb'] ?? null,
                    'recording_media_id'       => optional($recording_media)->id,
                    'card_slot_count'          => $item['card_slot_count'] ?? null,
                    'photo_format_id'          => optional($photo_format)->id,
                    'photo_size_l_mb'          => $item['photo_size_l_mb'] ?? null,
                    'photo_size_m_mb'          => $item['photo_size_m_mb'] ?? null,
                    'photo_size_s_mb'          => $item['photo_size_s_mb'] ?? null,
                    'photo_resolution_l'       => $item['photo_resolution_l'] ?? null,
                    'photo_resolution_m'       => $item['photo_resolution_m'] ?? null,
                    'photo_resolution_s'       => $item['photo_resolution_s'] ?? null,
                    'video_format_id'          => optional($video_format)->id,
                    'video_resolution'         => $item['video_resolution'] ?? null,
                    'audio_format'             => $item['audio_format'] ?? null,
                    'interface_model_id'       => optional($interface_model)->id,
                    'bluetooth'                => $item['bluetooth'] ?? null,
                    'wifi'                     => $item['wifi'] ?? null,
                    'microphone'               => $item['microphone'] ?? null,
                    'speaker'                  => $item['speaker'] ?? null,
                    'tripod_mount'             => $item['tripod_mount'] ?? null,
                    'battery_type'             => $item['battery_type'] ?? null,
                    'battery_capacity_mAh'     => $item['battery_capacity_mAh'] ?? null,
                    'battery_weight_g'         => $item['battery_weight_g'] ?? null,
                    'shots_per_charge'         => $item['shots_per_charge'] ?? null,
                    'body_material'            => $item['body_material'] ?? null,
                    'operating_temp_min_c'     => $item['operating_temp_min_c'] ?? null,
                    'operating_temp_max_c'     => $item['operating_temp_max_c'] ?? null,
                    'body_width'               => $item['body_width'] ?? null,
                    'body_height'              => $item['body_height'] ?? null,
                    'body_depth'               => $item['body_depth'] ?? null,
                    'body_weight_g'            => $item['body_weight_g'] ?? null,
                    'body_total_weight_g'      => $item['body_total_weight_g'] ?? null,
                    'accessory_id'             => optional($accessory)->id,
                    'display_language_id'      => optional($display_language)->id,
                ]);

                // 多対多リレーションの同期処理
                $pivotMap = [
                    'colorOptions'     => [ColorOption::class,     'colorOptions'],
                    'selfTimerSeconds' => [SelfTimerSecond::class, 'selfTimerSeconds'],
                    'recordingMedias'  => [RecordingMedia::class,  'recordingMedias'],
                    'photoFormats'     => [PhotoFormat::class,     'photoFormats'],
                    'videoFormats'     => [VideoFormat::class,     'videoFormats'],
                    'videoCodecs'      => [VideoCodec::class,      'videoCodecs'],
                    'interfaceModels'  => [InterfaceModel::class,  'interfaceModels'],
                    'accessories'      => [Accessory::class,       'accessories'],
                    'displayLanguages' => [DisplayLanguage::class, 'displayLanguages'],
                    'features'         => [Feature::class,         'features'],
                ];

                foreach ($pivotMap as $itemKey => [$modelClass, $relationMethod]) {
                    $names = $item[$itemKey] ?? [];

                    dump("🔍 [{$itemKey}] チェック開始");

                    // 配列でない or 要素がゼロの場合だけスキップ
                    if (!is_array($names) || count($names) === 0) {
                        dump("⚠️ スキップ: 配列が空、または配列ではありません");
                        continue;
                    }

                    $firstModel = $modelClass::first();
                    if (!$firstModel) {
                        dump("❌ モデル {$modelClass} にデータが存在しません");
                        continue;
                    }

                    $column = $firstModel?->getFillable()[0] ?? null;
                    dump("🔑 使用カラム: {$column}");

                        if (!$column) {
                        dump("❌ カラム特定失敗（fillable未設定？）");
                        continue;
                    }

                    $ids = $modelClass::whereIn($column, $names)->pluck('id')->toArray();
                    if (!empty($ids)) {
                        $camera->$relationMethod()->sync($ids);
                    }

                    $this->command->info("🟡 Pivot処理: {$itemKey}");

                }
            }

            DB::commit();
            $this->command->info('✅ カメラのデータをシードしました。');
        } catch (\Exception $e) {
            DB::rollBack();
            $this->command->error('❌ シードに失敗: ' . $e->getMessage());
        }
    }
}
