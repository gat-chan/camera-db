<?php

namespace App\Http\Controllers;

use App\Models\Camera;
use App\Models\Manufacturer;
use App\Models\CameraType;
use App\Models\LensMount;
use App\Models\SensorType;
use App\Models\Feature;
use App\Models\ColorOption;
use App\Models\SelfTimerSecond;
use App\Models\RecordingMedia;
use App\Models\InterfaceModel;
use App\Models\Accessory;
use App\Models\AfMethod;
use App\Models\MeteringMethod;
use App\Models\MeteringMode;
use App\Models\WhiteBalance;
use App\Models\DisplayLanguage;
use App\Models\PhotoFormat;
use App\Models\VideoFormat;
use App\Models\VideoCodec;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\File;

use Inertia\Inertia;

class WelcomeController extends Controller
{
    public function index(Request $request)
    {
        // 最新10件のカメラを取得
        $latestCameras = Camera::with('manufacturer')
        ->orderBy('created_at', 'desc')
        ->take(10)
        ->get();

        // dump($latestCameras);

        // 条件フォーム用に全メーカー一覧を取得
        $manufacturers = Manufacturer::all();

        // フィルター用入力値
        $filters = [
            'manufacturer_id' => $request->input('manufacturer_id'),
            'max_price' => $request->input('max_price'),
            'keyword' => $request->input('keyword'),
        ];

        // Inertia に渡す
        return Inertia::render('Welcome', [
            'latestCameras' => $latestCameras,
            'manufacturers' => $manufacturers,
            'filters' => $filters,
        ]);

    }

    
}
