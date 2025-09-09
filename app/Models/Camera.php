<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Camera extends Model
{
    protected $fillable = [
        'manufacturer', 'camera_name', 'model_number', 'camera_type',
        'lens_mount', 'total_pixels', 'effective_pixels', 'sensor_type',
        'sensor_width_mm', 'sensor_height_mm', 'image_sensor', 'viewfinder_type',
        'viewfinder_coverage', 'viewfinder_magnification', 'iso_standard_min', 'iso_standard_max',
        'iso_extended_min', 'iso_extended_max', 'shutter_electronic_min', 'shutter_electronic_max',
        'shutter_mechanical_min', 'shutter_mechanical_max','battery_type','battery_capacity_mAh',
        'battery_weight_g','shots_per_charge','buffer_memory_mb','internal_memory_gb',
        'card_slot_count','burst_mode_fps','body_material','operating_temp_min_c',
        'operating_temp_max_c','body_width_mm','body_height_mm','body_depth_mm',
        'body_weight_g','body_total_weight_g','lcd_size_inch','lcd_resolution_dots',
        'monitor_type','tripod_mount','microphone','speaker','release_year',
        'discontinued_year','bluetooth','photo_size_l','photo_size_m','photo_size_s',
        'photo_resolution_l','photo_resolution_m','photo_resolution_s','video_resolution',

        'price',
        'price_data',
        'color_option_id',
        'sensor_width_mm',
        'sensor_height_mm',
        'image_sensor',
        'image_processor',
        'viewfinder_type',
        'viewfinder_coverage',
        'viewfinder_magnification',
        'lcd_type',
        'iso_standard_min',
        'iso_standard_max',
        'iso_extended_min',
        'iso_extended_max',
        'metering_method',
        'metering_mode_id',
        'exposure_value',
        'shutter_electronic_min',
        'shutter_electronic_max',
        'shutter_mechanical_min',
        'shutter_mechanical_max',
        'drive_mode',
        'burst_mode_fps',
        'self_timer_second_id',
        'white_balance_id',
        'recording_media_id',
        'photo_format_id',
        'video_format_id',
        'video_codec_id',
        'audio_format',
        'interface_model_id',
        'bluetooth',
        'wifi',
        'microphone',
        'speaker',
        'tripod_mount',
        'battery_type',
        'battery_capacity_mAh',
        'battery_weight_g',
        'shots_per_charge',
        'body_material',
        'operating_temp_min_c',
        'operating_temp_max_c',
        'body_width',
        'body_height',
        'body_depth',
        'body_weight_g',
        'body_total_weight_g',
        'accessory_id',
        'display_language_id',
    ];

    // メーカー
    public function manufacturer()
    {
        return $this->belongsTo(Manufacturer::class);
    }

    // カメラタイプ
    public function cameraType()
    {
        return $this->belongsTo(CameraType::class);
    }

    // センサータイプ
    public function sensorType()
    {
        return $this->belongsTo(SensorType::class, 'sensor_type_id');
    }
    
    // カメラ価格
    public function prices()
    {
        return $this->hasMany(CameraPrice::class);
    }

    // 多対多リレーションの定義
    public function colorOptions()
    {
        return $this->belongsToMany(ColorOption::class, 'camera_color_option');
    }

    public function meteringModes()
    {
        return $this->belongsToMany(MeteringMode::class, 'camera_metering_mode');
    }

    public function selfTimerSeconds()
    {
        return $this->belongsToMany(SelfTimerSecond::class, 'camera_self_timer_second');
    }

    public function whiteBalances()
    {
        return $this->belongsToMany(WhiteBalance::class, 'camera_white_balance');
    }

    public function recordingMedias()
    {
        return $this->belongsToMany(RecordingMedia::class, 'camera_recording_media');
    }

    public function photoFormats()
    {
        return $this->belongsToMany(PhotoFormat::class, 'camera_photo_format');
    }

    public function videoFormats()
    {
        return $this->belongsToMany(VideoFormat::class, 'camera_video_format', 'camera_id', 'video_format_id');
    }

    public function videoCodecs()
    {
        return $this->belongsToMany(VideoCodec::class, 'camera_video_codec');
    }

    public function interfaceModels()
    {
        return $this->belongsToMany(InterfaceModel::class, 'camera_interface_model');
    }

    public function accessories()
    {
        return $this->belongsToMany(Accessory::class, 'camera_accessory');
    }

    public function displayLanguages()
    {
        return $this->belongsToMany(DisplayLanguage::class, 'camera_display_language');
    }

    public function features()
    {
        return $this->belongsToMany(Feature::class, 'camera_feature', 'camera_id', 'feature_id');
    }
}