<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('camera_recording_media', function (Blueprint $table) {
            $table->id();
            $table->foreignId('camera_id')
                  ->constrained()
                  ->cascadeOnDelete();
            $table->foreignId('recording_media_id')
                  ->constrained('recording_medias')
                  ->cascadeOnDelete();
            $table->unique(['camera_id', 'recording_media_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('camera_recording_media');
    }
};
