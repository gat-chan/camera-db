<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('camera_self_timer_second', function (Blueprint $table) {
            $table->id();
            $table->foreignId('camera_id')->constrained()->cascadeOnDelete();
            $table->foreignId('self_timer_second_id')->constrained()->cascadeOnDelete();
            $table->unique(['camera_id', 'self_timer_second_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('camera_self_timer_second');
    }
};
