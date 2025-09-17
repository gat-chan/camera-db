<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('cameras', function (Blueprint $table) {
            $table->id();
            $table->foreignId('manufacturer_id')->nullable()->constrained('manufacturers')->onDelete('cascade');
            $table->string('camera_name');
            $table->string('model_number')->nullable();
            $table->foreignId('camera_type_id')->nullable()->constrained('camera_types')->onDelete('cascade');
            $table->foreignId('lens_mount_id')->nullable()->constrained('lens_mounts')->onDelete('cascade');
            $table->date('release_year')->nullable();
            $table->date('discontinued_year')->nullable();
            $table->integer('price')->nullable();
            $table->unsignedSmallInteger('price_data')->nullable();
            $table->foreignId('color_option_id')->nullable()->constrained('color_options')->onDelete('cascade');
            $table->integer('total_pixels')->nullable();
            $table->integer('effective_pixels')->nullable();
            $table->foreignId('sensor_type_id')->nullable()->constrained('sensor_types')->onDelete('cascade');
            $table->decimal('sensor_width_mm', 5, 2)->nullable();
            $table->decimal('sensor_height_mm', 5, 2)->nullable();
            $table->string('image_sensor')->nullable();
            $table->string('image_processor')->nullable();
            $table->string('viewfinder_type')->nullable();
            $table->decimal('viewfinder_coverage', 5, 2)->nullable();
            $table->decimal('viewfinder_magnification', 5, 2)->nullable();
            $table->string('lcd_type')->nullable();
            $table->decimal('lcd_size_inch', 4, 2)->nullable();
            $table->integer('lcd_resolution_dots')->nullable();
            $table->integer('iso_standard_min')->nullable();
            $table->integer('iso_standard_max')->nullable();
            $table->integer('iso_extended_min')->nullable();
            $table->integer('iso_extended_max')->nullable();
            $table->string('metering_method')->nullable();
            $table->foreignId('metering_mode_id')->nullable()->constrained('metering_modes')->onDelete('cascade');
            $table->string('exposure_value')->nullable();
            $table->decimal('shutter_electronic_min', 10, 1)->nullable();
            $table->decimal('shutter_electronic_max', 10, 10)->nullable();
            $table->decimal('shutter_mechanical_min', 10, 1)->nullable();
            $table->decimal('shutter_mechanical_max', 10, 10)->nullable();
            $table->string('drive_mode')->nullable();
            $table->string('burst_mode_fps')->nullable();
            $table->foreignId('self_timer_second_id')->nullable()->constrained('self_timer_seconds')->onDelete('cascade');
            $table->foreignId('white_balance_id')->nullable()->constrained('white_balances')->onDelete('cascade');
            $table->integer('temperature_low')->nullable();
            $table->integer('temperature_high')->nullable();
            $table->string('af_methods')->nullable();
            $table->integer('af_points')->nullable();
            $table->integer('buffer_memory_mb')->nullable();
            $table->integer('internal_memory_gb')->nullable();
            $table->foreignId('recording_media_id')->nullable()->constrained('recording_medias')->onDelete('cascade');
            $table->integer('card_slot_count')->nullable();
            $table->foreignId('photo_format_id')->nullable()->constrained('photo_formats')->onDelete('cascade');
            $table->integer('photo_size_l_mb')->nullable();
            $table->integer('photo_size_m_mb')->nullable();
            $table->integer('photo_size_s_mb')->nullable();
            $table->integer('photo_resolution_l')->nullable();
            $table->integer('photo_resolution_m')->nullable();
            $table->integer('photo_resolution_s')->nullable();
            $table->foreignId('video_format_id')->nullable()->constrained('video_formats')->onDelete('cascade');
            $table->foreignId('video_codec_id')->nullable()->constrained('video_codecs')->onDelete('cascade');
            $table->integer('video_resolution')->nullable();
            $table->string('audio_format')->nullable();
            $table->foreignId('interface_model_id')->nullable()->constrained('interface_models')->onDelete('cascade');
            $table->string('bluetooth')->nullable();
            $table->string('wifi', 500)->nullable();
            $table->string('microphone')->nullable();
            $table->string('speaker')->nullable();
            $table->string('tripod_mount')->nullable();
            $table->string('battery_type')->nullable();
            $table->integer('battery_capacity_mAh')->nullable();
            $table->decimal('battery_weight_g', 6, 2)->nullable();
            $table->integer('shots_per_charge')->nullable();
            $table->string('body_material')->nullable();
            $table->decimal('operating_temp_min_c', 4, 1)->nullable();
            $table->decimal('operating_temp_max_c', 4, 1)->nullable();
            $table->decimal('body_width')->nullable();
            $table->decimal('body_height')->nullable();
            $table->decimal('body_depth')->nullable();
            $table->decimal('body_weight_g', 5, 1)->nullable();
            $table->decimal('body_total_weight_g', 5, 1)->nullable();
            $table->foreignId('accessory_id')->nullable()->constrained('accessories')->onDelete('cascade');
            $table->foreignId('display_language_id')->nullable()->constrained('display_languages')->onDelete('cascade');
            $table->foreignId('feature_id')->nullable()->constrained('features')->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cameras');
    }
};
