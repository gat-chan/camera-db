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
use App\Models\DisplayLanguage;
use App\Models\PhotoFormat;
use App\Models\VideoFormat;
use App\Models\VideoCodec;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;


use Inertia\Inertia;
class CameraController extends Controller
{
    public function index(Request $request)
    {
        // ベースのクエリ
        $query = Camera::with([
            'manufacturer',
            'cameraType',
            'sensorType',
            'prices',
            'colorOptions',
            'selfTimerSeconds',
            'recordingMedias',
            'photoFormats',
            'videoFormats',
            'videoCodecs',
            'interfaceModels',
            'accessories',
            'displayLanguages',
            'features',
        ]);

        // メーカー絞り込み
        if ($request->filled('manufacturer_ids')) {
            $query->whereIn('manufacturer_id', $request->manufacturer_ids);
        }

        // カメラタイプ絞り込み
        if ($request->filled('camera_type_ids')) {
            $query->whereIn('camera_type_id', $request->camera_type_ids);
        }

        // センサータイプ絞り込み
        if ($request->filled('sensor_type_ids')) {
            $query->whereIn('sensor_type_id', $request->sensor_type_ids);
        }

        // 動画フォーマット絞り込み
        $videoFormatIds = $request->input('video_format_ids', []);
        if (!empty($videoFormatIds)) {
            $query->whereHas('videoFormats', function($q) use ($videoFormatIds) {
                $q->whereIn('video_formats.id', $videoFormatIds);
            });
        }

        // 有効画素数で絞り込み
        if ($request->filled('effective_pixels')) {
            $query->where('effective_pixels', '<=', $request->effective_pixels);
        }

        // 価格範囲で絞り込み
        if ($request->filled('min_price')) {
            $query->where('price', '>=', $request->min_price);
        }
        if ($request->filled('max_price')) {
            $query->where('price', '<=', $request->max_price);
        }

        // キーワード（AND検索、大文字小文字区別なし）
        if ($request->filled('keyword')) {
            $normalizedKeyword = mb_convert_kana($request->keyword, 's'); // 全角スペース→半角スペース
            $keywords = preg_split('/\s+/', mb_strtolower($normalizedKeyword)); // AND検索用に分割
        
            $query->where(function ($q) use ($keywords) {
                foreach ($keywords as $word) {
                    $q->where(function ($sub) use ($word) {
                        $sub
                            ->orWhereHas('cameraName', function ($query) use ($word) {
                                $query->whereRaw('LOWER(camera_name_ja) LIKE ?', ["%{$word}%"])
                                      ->orWhereRaw('LOWER(camera_name_en) LIKE ?', ["%{$word}%"]);
                            })
                            ->orWhereRaw('LOWER(reference_number) LIKE ?', ["%{$word}%"])
                            ->orWhereHas('description', function ($query) use ($word) {
                                $query->whereRaw('LOWER(description_ja) LIKE ?', ["%{$word}%"])
                                      ->orWhereRaw('LOWER(description_en) LIKE ?', ["%{$word}%"]);
                            })
                            ->orWhereHas('features', function ($featureQuery) use ($word) {
                                $featureQuery->whereRaw('LOWER(feature_ja) LIKE ?', ["%{$word}%"])
                                             ->orWhereRaw('LOWER(feature_en) LIKE ?', ["%{$word}%"]);
                            });
                    });
                }
            });
        }
        
        // ページネーション
        $cameras = $query->paginate(12)->withQueryString();

        // ビューとデータを返す
        return Inertia::render('Search-Camera', [
            'cameras' => $cameras,
            'total' => $cameras->total(),
            'manufacturers' => Manufacturer::all(),
            'cameraTypes'   => CameraType::all(),
            'sensorTypes'   => SensorType::all(),
            'videoFormats'  => VideoFormat::all(),
            'filters' => [
                'manufacturer_ids'  => $request->input('manufacturer_ids', []),
                'camera_type_ids'   => $request->input('camera_type_ids', []),
                'sensor_type_ids'   => $request->input('sensor_type_ids', []),
                'video_format_ids'  => $request->input('video_format_ids', []),
                'price_range'       => $request->input('price_range', [50000, 2000000]),
                'weight_range'      => $request->input('weight_range', [100, 1500]),
                'release_year'      => $request->input('release_year', 1980),
                'effective_pixels'  => $request->input('effective_pixels', 10000),
                'iso_min'           => $request->input('iso_min'),
                'iso_max'           => $request->input('iso_max'),
                'keyword'           => $request->input('keyword', ''),
            ],
        ]);
    }
 
    // 新規登録フォーム表示
    public function create()
    {
        // フォーム用の外部テーブルデータ取得
        return Inertia::render('Register-Camera', [
            'manufacturers'    => Manufacturer::all(),
            'cameraTypes'      => CameraType::all(),
            'lensMounts'       => LensMount::all(),
            'sensorTypes'      => SensorType::all(),
            'features'         => Feature::all(),
            'colorOptions'     => ColorOption::all(),
            'selfTimerSeconds' => SelfTimerSecond::all(),
            'recordingMedias'  => RecordingMedia::all(),
            'photoFormats'     => PhotoFormat::all(),
            'videoFormats'     => VideoFormat::all(),
            'videoCodecs'      => VideoCodec::all(),
            'interfaceModels'  => InterfaceModel::all(),
            'accessories'      => Accessory::all(),
            'displayLanguages' => DisplayLanguage::all(),
        ]);
    }

    //array to []変換関数
    private function varExportShort(array $data): string
    {
        $export = var_export($data, true);
        // array( をすべて [ に置換
        $export = preg_replace('/\barray\s*\(/', '[', $export);
        // ), をすべて ], に置換
        $export = preg_replace('/\),/', '],', $export);

        return $export;
    }
    // 登録フォーム
    public function store(Request $request)
    {
        $data = $request->all();

        // "0" または null を除外
        $data = array_filter($data, function ($value) {
            return !($value === '0' || is_null($value));
        });

        // 保存ディレクトリのパス（database/data/cameras）
        $dir = database_path('data/cameras');

        // ディレクトリがなければ作成（パーミッション0755）
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }

        // 保存ファイル名を登録データのmanufacturer_nameから作成
        // ファイル名として使えない文字は除去 or 置換（例: 空白やスラッシュなど）
        $manufacturerName = $data['manufacturer_name'] ?? 'unknown_manufacturer';
        $filenameSafe = preg_replace('/[^A-Za-z0-9_-]/', '_', $manufacturerName) . '.php';

        $file = $dir . '/' . $filenameSafe;

        // 既存データを読み込む
        $existing = file_exists($file) ? include $file : [];

        // 新しいデータを追加
        $existing[] = $data;

        // // キーを連番に振り直す（0,1,2...）
        // $existing = array_values($existing);

        // PHP形式で保存
        $export = "<?php\nreturn " . $this->varExportShort($existing) . ";\n";
        // ); をすべて ]; に置換
        $export = preg_replace('/\)\s*;/', '];', $export);
        file_put_contents($file, $export);

        return redirect()->back()->with('success', '保存完了（PHP形式）');
    }

    // シーダーからの編集
    public function fetch(Request $request)
    {
        $manufacturer  = $request->query('manufacturer', '');
        $modelNumber   = $request->query('model_number', '');
    
        if (!$manufacturer || !$modelNumber) {
            return response()->json(['message' => 'Manufacturer and model number are required'], 400);
        }
    
        // ファイルパスを作成（空白や特殊文字は避けるためサニタイズ）
        $fileName = database_path('data/cameras/' . preg_replace('/[^a-zA-Z0-9_-]/', '', $manufacturer) . '.php');

        \Log::info('読み込むファイル: ' . $fileName);
    
        if (!file_exists($fileName)) {
            return response()->json(['message' => 'Manufacturer file not found'], 404);
        }
    
        // Seeder データを読み込む
        $allCameras = include $fileName;
        \Log::info('Requested manufacturer: ' . $manufacturer);
        \Log::info('Requested model_number: ' . $modelNumber);
        \Log::info('Seeder配列の型: ' . gettype($allCameras));
        \Log::info('Seederの件数: ' . count($allCameras));
    
        if (!is_array($allCameras)) {
            return response()->json(['message' => 'Seeder data invalid'], 500);
        }
    
        // 該当のカメラを探す
        $camera = collect($allCameras)->first(function ($item) use ($manufacturer, $modelNumber) {
            return ($item['manufacturer_name'] ?? '') === $manufacturer
                && ($item['model_number'] ?? '') === $modelNumber;
        });      
    
        if (!$camera) {
            return response()->json(['message' => 'Camera not found'], 404);
        }
    
        return response()->json($camera);
    }
    

    // 編集フォーム表示
    public function edit(Camera $camera)
    {
        $camera->load([
            'features',
            'colorOptions',
            'driveModes',
            'selfTimerSeconds',
            'recordingMedias',
            'photoFormats',
            'videoFormats',
            'videoCodecs',
            'interfaceModels',
            'accessories',
            'displayLanguages'
        ]);

        return Inertia::render('Camera/Edit', array_merge($this->sharedProps(), [
            'camera' => $camera,
        ]));
    }

    use \Illuminate\Foundation\Auth\Access\AuthorizesRequests;

    // 更新処理
    public function update(Request $request, Camera $camera)
    {
        // $this->authorize('update', $camera); // 管理者のみ許可
    
        \Log::debug('Update function called');
        \Log::debug('User info: ' . json_encode(auth()->user()));

        // ポリシーを通す
        $this->authorize('update', $camera);
        
        $data = $request->validate([
            'body_total_weight_g' => 'nullable|numeric',
            'price'               => 'nullable|numeric',
            // 他の更新項目をここに追加
        ]);
    
        $camera->update($data);

        \Log::debug('Camera updated', ['camera_id' => $camera->id, 'data' => $data]);
    
        return back()->with('success', '更新完了');
    }
    

    // 削除（オプション）
    public function destroy(Camera $camera)
    {
        $camera->delete();
        return redirect()->route('cameras.index')->with('message', '削除完了');
    }

    // 🔄 共通のバリデーション
    private function validateData(Request $request): array
    {
        return $request->validate([
            'camera_name' => 'required|string|max:255',
            'model_number' => 'required|string|max:255',
            'release_start' => 'nullable|string',
            'manufacturer_name' => 'nullable|string',
            'camera_type_name' => 'nullable|string',
            'lens_mount_name' => 'nullable|string',
            'sensor_type_name' => 'nullable|string',
            'metering_method_name' => 'nullable|string',
            'price_history.price' => 'nullable|numeric',
            'price_history.recorded_at' => 'nullable|date',
            // 必要に応じて追加の項目
        ]);
    }

    // 🔄 多対多のリレーション同期
    private function syncRelations(Camera $camera, Request $request): void
    {
        $camera->colorOptions()->sync($request->input('colorOptionIds', []));      
        $camera->selfTimerSeconds()->sync($request->input('selfTimerSecondIds', []));
        $camera->recordingMedias()->sync($request->input('recordingMediaIds', []));
        $camera->photoFormats()->sync($request->input('photoFormatIds', []));
        $camera->videoFormats()->sync($request->input('videoFormatIds', []));
        $camera->videoCodecs()->sync($request->input('videoCodecIds', []));
        $camera->interfaceModels()->sync($request->input('interfaceModelIds', []));
        $camera->accessories()->sync($request->input('accessoryIds', []));
        $camera->displayLanguages()->sync($request->input('displayLanguageIds', []));
        $camera->features()->sync($request->input('feature_ids', []));
    }

    // 📦 各選択肢データの共有
    private function sharedProps(): array
    {
        return [
            'manufacturers'    => Manufacturer::all(),
            'cameraTypes'      => CameraType::all(),   
            'lensMounts'       => LensMount::all(),
            'sensorTypes'      => SensorType::all(),
            'colorOptions'     => ColorOption::all(),
            'selfTimerSeconds' => SelfTimerSecond::all(),
            'recordingMedias'  => RecordingMedia::all(),
            'photoFormats'     => PhotoFormat::all(),
            'videoFormats'     => VideoFormat::all(),
            'videoCodecs'     => VideoCodec::all(),
            'interfaceModels'  => InterfaceModel::all(),
            'accessories'      => Accessory::all(),
            'displayLanguages' => DisplayLanguage::all(),
            'features'         => Feature::all(),
        ];
    }

    public function detail(Camera $camera)
    {
        $camera->load([
            'manufacturer',       // belongsTo
            'cameraType',         // belongsTo
            'lensMount',          // belongsTo
            'sensorType',         // belongsTo
            'features',           // belongsToMany
            'colorOptions',       // belongsToMany
            'selfTimerSeconds',   // belongsToMany
            'recordingMedias',    // belongsToMany
            'photoFormats',       // belongsToMany
            'videoFormats',       // belongsToMany
            'videoCodecs',        // belongsToMany
            'interfaceModels',    // belongsToMany
            'accessories',        // belongsToMany
            'displayLanguages',   // belongsToMany
        ]);
    
        return Inertia::render('Camera-Detail', [
            'camera' => $camera
        ]);
    }
    
}
