<?php

use App\Models\Camera;

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\WelcomeController;
use App\Http\Controllers\CameraController;
use App\Http\Controllers\ContactController;

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;

use Inertia\Inertia;

// TOPページ（最新7件のカメラを表示）
Route::get('/', [WelcomeController::class, 'index'])->name('welcome');

Route::get('/search-camera', [CameraController::class, 'index'])->name('search-camera');

Route::get('/cameras', [CameraController::class, 'index'])->name('cameras.index');

Route::get('/register-camera', [CameraController::class, 'create'])->name('register-camera');
Route::get('/cameras/{camera}/edit', [CameraController::class, 'edit'])->name('cameras.edit');
Route::post('/cameras', [CameraController::class, 'store'])->name('cameras.store');// 登録
Route::get('/camera-seed', [CameraController::class, 'show'])->name('camera-seed');
Route::put('/cameras/{camera}', [CameraController::class, 'update']); // 更新


Route::get('/contact', function () {
    return Inertia::render('ContactForm'); // ← 修正
});

Route::post('/contact', [ContactController::class, 'submit']);

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
