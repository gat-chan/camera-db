<?php
// route/web.php
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\WelcomeController;
use App\Http\Controllers\CameraController;
use App\Http\Controllers\ContactController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

// TOPページ（最新7件のカメラを表示）
Route::get('/', [WelcomeController::class, 'index'])->name('welcome');

// 検索ページ
Route::get('/search-camera', [CameraController::class, 'index'])->name('search-camera');
// 登録ページ
Route::get('/register-camera', [CameraController::class, 'create'])->name('register-camera');
// 登録ページ(編集)
Route::get('/camera-seed', [CameraController::class, 'fetch'])->name('camera-seed');
// 一般ユーザー（閲覧のみ）
Route::get('/cameras', [CameraController::class, 'index'])->name('cameras.index');
Route::get('/cameras/{camera}', [CameraController::class, 'detail'])->name('camera-detail');

// 管理者専用（登録・編集・削除）
Route::middleware(['auth'])->group(function () {
    Route::get('/cameras/{camera}/edit', [CameraController::class, 'edit'])->name('cameras.edit');
    Route::post('/cameras', [CameraController::class, 'store'])->name('cameras.store');
    Route::put('/cameras/{camera}', [CameraController::class, 'update'])->name('cameras.update');
    Route::delete('/cameras/{camera}', [CameraController::class, 'destroy'])->name('cameras.destroy');
});

// 問い合わせフォーム
Route::get('/contact', fn() => Inertia::render('ContactForm'))->name('contact');
Route::post('/contact', [ContactController::class, 'submit'])->name('contact.submit');

// 認証関係
Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('/dashboard', fn() => Inertia::render('Dashboard'))->name('dashboard');

    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';

