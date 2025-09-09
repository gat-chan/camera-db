<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('camera_color_option', function (Blueprint $table) {
            $table->id();
            $table->foreignId('camera_id')->constrained()->cascadeOnDelete();
            $table->foreignId('color_option_id')->constrained()->cascadeOnDelete();
            $table->unique(['camera_id', 'color_option_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('camera_color_option');
    }
};
