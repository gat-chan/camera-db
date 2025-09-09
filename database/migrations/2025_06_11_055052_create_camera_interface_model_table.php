<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('camera_interface_model', function (Blueprint $table) {
            $table->id();
            $table->foreignId('camera_id')->constrained()->cascadeOnDelete();
            $table->foreignId('interface_model_id')
                  ->constrained('interface_models')
                  ->cascadeOnDelete();
            $table->unique(['camera_id', 'interface_model_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('camera_interface_model');
    }
};
