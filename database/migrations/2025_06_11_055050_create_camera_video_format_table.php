<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('camera_video_format', function (Blueprint $table) {
            $table->id();
            $table->foreignId('camera_id')->constrained()->cascadeOnDelete();
            $table->foreignId('video_format_id')->constrained()->cascadeOnDelete();
            $table->unique(['camera_id', 'video_format_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('camera_video_format');
    }
};
