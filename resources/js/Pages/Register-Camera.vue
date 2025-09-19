<template>
    <Layout>
      <h1 class="text-2xl font-bold mb-4">カメラ登録フォーム</h1>
      <div class="max-w-2xl mx-auto p-4">
          <form @submit.prevent="submit" class="grid grid-cols-1 md:grid-cols-6 gap-4">
            
            <!-- メーカー選択 -->
            <div class="md:col-span-6">
              <label for="manufacturer_id" class="block">メーカー</label>
              <select v-model="form.manufacturer_id" id="manufacturer_id" class="border rounded w-full p-2 text-black">
                <option value="">選択してください</option>
                <option v-for="manufacturer in manufacturers" :key="manufacturer.id" :value="manufacturer.id">
                  {{ manufacturer.name_ja }}
                </option>
              </select>
            </div>
      
            <!-- 品名 -->
            <div class="mb-4 col-span-3">
              <label for="name" class="block">品名</label>
              <input v-model="form.camera_name" type="text" id="camera_name" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 型番 -->
            <div class="mb-4 col-span-3">
              <label for="model_number" class="block">型番</label>
              <input v-model="form.model_number" type="text" id="model_number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- カメラタイプ -->
            <div class="mb-4 md:col-span-3">
              <label class="block">カメラタイプ</label>
              <select v-model="form.camera_type_id" id="camera_type_id" class="border rounded w-full p-2 text-black">
                <option value="">選択してください</option>
                <option v-for="cameraType in cameraTypes" :key="cameraType.id" :value="cameraType.id">
                  {{ cameraType.name_ja }}
                </option>
              </select>
            </div>

            <!-- レンズマウント -->
            <div class="mb-4 md:col-span-3">
              <label class="block">レンズマウント</label>
              <select v-model="form.lens_mount_id" id="lens_mount_id" class="border rounded w-full p-2 text-black">
                <option value="">選択してください</option>
                <option v-for="lensMount in lensMounts" :key="lensMount.id" :value="lensMount.id">
                  {{ lensMount.name_ja }}
                </option>
              </select>
            </div>

            <!-- 発売開始年月 -->
            <div class="mb-4 md:col-span-3">
              <label class="block">発売開始年月</label>
              <input v-model="form.release_year" type="date" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 発売終了年月 -->
            <div class="mb-4 md:col-span-3">
              <label class="block">発売終了年月</label>
              <input v-model="form.discontinued_year" type="date" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 値段 -->
            <div class="mb-4 md:col-span-3">
              <label for="price" class="block">値段（円）</label>
              <input v-model="form.price" type="number" id="price" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 記録日 -->
            <div class="mb-4 md:col-span-3">
              <label class="block">記録日</label>
              <input v-model="form.price_data" type="date" class="border rounded w-full p-2 text-black">
            </div>

            <!-- カラー -->
            <div class="mb-4 md:col-span-6">
              <summary class="cursor-pointer font-semibold">カラー</summary>
              <div class="grid grid-cols-3 ">
                <label v-for="colorOption in colorOptions" :key="colorOption.id" class="inline-flex items-center">
                  <input type="checkbox" :value="colorOption.id" v-model="form.colorOptionIds" class="mr-2">
                  {{ colorOption.name_ja }}
                </label>
              </div>
            </div>

            <!-- 総画素数 -->
            <div class="mb-4 col-span-3">
              <label class="block">総画素数(万画素)</label>
              <input v-model="form.total_pixels" type="number" step="0.01" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 有効画素数 -->
            <div class="mb-4 col-span-3">
              <label class="block">有効画素数(万画素)</label>
              <input v-model="form.effective_pixels" type="number" step="0.01" class="border rounded w-full p-2 text-black">
            </div>

            <!-- センサータイプ -->
            <div class="mb-4 md:col-span-6">
              <label class="block">センサータイプ</label>
              <select v-model="form.sensor_type_id" id="sensor_type_id" class="border rounded w-full p-2 text-black">
                <option value="">選択してください</option>
                <option v-for="sensorType in sensorTypes" :key="sensorType.id" :value="sensorType.id">
                  {{ sensorType.name_ja }}
                </option>
              </select>
            </div>

            <!-- センサーサイズ横（mm）-->
            <div class="mb-4 md:col-span-3">
              <label class="block">センサーサイズ横（mm）</label>
              <input v-model="form.sensor_width_mm" type="number" step="0.01" class="border rounded w-full p-2 text-black">
            </div>

            <!-- センサーサイズ縦（mm）-->
            <div class="mb-4 md:col-span-3">
              <label class="block">センサーサイズ縦（mm）</label>
              <input v-model="form.sensor_height_mm" type="number" step="0.01" class="border rounded w-full p-2 text-black">
            </div>

            <!-- イメージセンサー名 -->
            <div class="mb-4 md:col-span-3">
              <label class="block">イメージセンサー名</label>
              <input v-model="form.image_sensor" type="text" 
                placeholder="CMOS、CCDなど"
                class="border rounded w-full p-2 text-black">
            </div>

            <!-- イメージプロセッサー名 -->
            <div class="mb-4 md:col-span-3">
              <label class="block">イメージプロセッサー名</label>
              <input v-model="form.image_processor" type="text" 
                placeholder="DIGIC,EXPEED,BIONZなど"
                class="border rounded w-full p-2 text-black">
            </div>

            <!-- ファインダータイプ -->
            <div class="mb-4 md:col-span-6">
              <label class="block">ファインダータイプ</label>
              <input v-model="form.viewfinder_type" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 視野角（%） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">視野角（%）</label>
              <input v-model="form.viewfinder_coverage" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 倍率 -->
            <div class="mb-4 md:col-span-3">
              <label class="block">倍率</label>
              <input v-model="form.viewfinder_magnification" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- モニタータイプ -->
            <div class="mb-4 md:col-span-6">
              <label class="block">モニタータイプ</label>
              <input v-model="form.lcd_type" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- モニターサイズ -->
            <div class="mb-4 md:col-span-3">
              <label class="block">モニターサイズ</label>
              <input v-model="form.lcd_size_inch" type="number" step="0.01" class="border rounded w-full p-2 text-black">
            </div>

            <!-- モニタードット -->
            <div class="mb-4 md:col-span-3">
              <label class="block">モニタードット</label>
              <input v-model="form.lcd_resolution_dots" type="number" 
              placeholder="1234567"class="border rounded w-full p-2 text-black">
            </div>


            <!-- 常用ISO感度（低） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">常用ISO感度（低）</label>
              <input v-model="form.iso_standard_min" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 常用ISO感度（高） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">常用ISO感度（高）</label>
              <input v-model="form.iso_standard_max" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 拡張ISO感度（低） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">拡張ISO感度（低）</label>
              <input v-model="form.iso_extended_min" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 拡張ISO感度（高） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">拡張ISO感度（高）</label>
              <input v-model="form.iso_extended_max" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 測光方式 -->
            <div class="mb-4 md:col-span-6">
              <label for="name" class="block">測光方式</label>
              <input v-model="form.metering_method" type="text" 
              placeholder="TTL測光,外光式測など" id="metering_method" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 測光モード -->
            <div class="mb-4 md:col-span-6">
              <label for="name" class="block">測光モード</label>
              <input v-model="form.metering_mode" type="text" 
              placeholder="マルチ測光、中央重点測光、" id="metering_mode" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 露出補正 -->
            <div class="mb-4 md:col-span-6">
              <label class="block">露出補正</label>
              <input v-model="form.exposure_value" type="text" 
              placeholder="±5.0EV" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 電子シャッター速度（低） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">電子シャッター速度（低）</label>
              <input v-model="form.shutter_electronic_min" type="text" inputmode="numeric" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 電子シャッター速度（高） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">電子シャッター速度（高）</label>
              <input v-model="form.shutter_electronic_max" type="text" inputmode="numeric" step="0.000000001" class="border rounded w-full p-2 text-black">
            </div>

            <!-- メカシャッター速度（低） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">メカシャッター速度（低）</label>
              <input v-model="form.shutter_mechanical_min" type="text" inputmode="numeric" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- メカシャッター速度（高） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">メカシャッター速度（高）</label>
              <input v-model="form.shutter_mechanical_max" type="text" inputmode="numeric" step="0.000000001" class="border rounded w-full p-2 text-black">
            </div>

            <!-- ドライブモード -->
            <div class="mb-4 md:col-span-6">
              <label for="name" class="block">ドライブモード</label>
              <input v-model="form.drive_mode" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 連続撮影速度 -->
            <div class="mb-4 md:col-span-6">
              <label class="block">連続撮影速度</label>
              <input v-model="form.burst_mode_fps" type="text" 
              placeholder="30fps" class="border rounded w-full p-2 text-black">
            </div>

            <!-- セルフタイマー -->
            <div class="mb-4 md:col-span-3">
              <summary class="cursor-pointer font-semibold">セルフタイマー</summary>
              <label class="block"></label>
              <div v-for="selfTimerSecond in selfTimerSeconds" :key="selfTimerSecond.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="selfTimerSecond.id" v-model="form.selfTimerSecondIds" class="mr-2">
                  {{ selfTimerSecond.name_ja }}
                </label>
              </div>
            </div>

            <!-- ホワイトバランス -->
            <div class="mb-4 md:col-span-6">
              <label for="name" class="block">ホワイトバランス</label>
              <input v-model="form.white_balance" type="text" 
              placeholder="オート / 太陽光 / 日陰 / 曇天 / 電球 /" id="white_balance" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 色温度（低） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">色温度（低）</label>
              <input v-model="form.temperature_low" type="number" 
              placeholder="2000" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 色温度（高） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">色温度（高）</label>
              <input v-model="form.temperature_high" type="number" 
              placeholder="10000" class="border rounded w-full p-2 text-black">
            </div>

            <!-- AF方式 -->
            <div class="mb-4 md:col-span-6">
              <label class="block">AF方式</label>
              <input v-model="form.af_methods" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- AF測距数 -->
            <div class="mb-4 md:col-span-6">
              <label class="block">AF測距数</label>
              <input v-model="form.af_points" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- バッファメモリ容量（MB） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">バッファメモリ容量（MB）</label>
              <input v-model="form.buffer_memory_mb" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 内蔵メモリ -->
            <div class="mb-4 md:col-span-3">
              <label class="block">内蔵メモリ容量（GB） </label>
              <input v-model="form.internal_memory_gb" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- カードスロット -->
            <div class="mb-4 md:col-span-6">
              <label class="block">カードスロット</label>
              <input v-model="form.card_slot_count" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 記録メディア -->
            <div class="mb-4 md:col-span-3">
              <summary class="cursor-pointer font-semibold">記録メディア</summary>
              <div v-for="recordingMedia in recordingMedias" :key="recordingMedia.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="recordingMedia.id" v-model="form.recordingMediaIds" class="mr-2">
                  {{ recordingMedia.name_ja }}
                </label>
              </div>
            </div>

            <!-- 静止画記録フォーマット -->
            <div class="mb-4 md:col-span-3">
              <summary class="cursor-pointer font-semibold">静止画記録フォーマット</summary>
              <div v-for="photoFormat in photoFormats" :key="photoFormat.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="photoFormat.id" v-model="form.photoFormat_ids" class="mr-2">
                  {{ photoFormat.name_ja }}
                </label>
              </div>
            </div>

            <!-- 静止画記録サイズ-L -->
            <div class="mb-4 md:col-span-2">
              <label class="block">静止画記録サイズ-L（MB） </label>
              <input v-model="form.photo_size_l_mb" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 静止画記録サイズ-M -->
            <div class="mb-4 md:col-span-2">
              <label class="block">静止画記録サイズ-M（MB） </label>
              <input v-model="form.photo_size_m_mb" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 静止画記録サイズ-S -->
            <div class="mb-4 md:col-span-2">
              <label class="block">静止画記録サイズ-S（MB） </label>
              <input v-model="form.photo_size_s_mb" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 静止画記録解像度-L -->
            <div class="mb-4 md:col-span-2">
              <label class="block">静止画記録解像度-L</label>
              <input v-model="form.photo_resolution_l" type="text" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 静止画記録解像度-M -->
            <div class="mb-4 md:col-span-2">
              <label class="block">静止画記録解像度-M</label>
              <input v-model="form.photo_resolution_m" type="text" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 静止画記録解像度-S -->
            <div class="mb-4 md:col-span-2">
              <label class="block">静止画記録解像度-S</label>
              <input v-model="form.photo_resolution_s" type="text" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 動画記録フォーマット -->
            
            <div class="mb-4 md:col-span-3">
              <summary class="cursor-pointer font-semibold">動画記録フォーマット</summary>
              <div v-for="videoFormat in videoFormats" :key="videoFormat.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="videoFormat.id" v-model="form.videoFormat_ids" class="mr-2">
                  {{ videoFormat.name_ja }}
                </label>
              </div>
            </div>

            <!-- 動画圧縮方式 -->
            
            <div class="mb-4 md:col-span-3">
              <summary class="cursor-pointer font-semibold">動画圧縮方式</summary>
              <div v-for="videoCodec in videoCodecs" :key="videoCodec.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="videoCodec.id" v-model="form.videoCodec_ids" class="mr-2">
                  {{ videoCodec.name_ja }}
                </label>
              </div>
            </div>

            <!-- 動画記録画素数 -->
            <div class="mb-4 md:col-span-6">
              <label class="block">動画記録画素数</label>
              <input v-model="form.video_resolution" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 音声記録フォーマット -->
            <div class="mb-4 md:col-span-6">
              <label class="block">音声記録フォーマット</label>
              <input v-model="form.audio_format" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- インターフェース -->
            
            <div class="mb-4 md:col-span-6">
              <summary class="cursor-pointer font-semibold">インターフェース</summary>
              <div v-for="interfaceModel in interfaceModels" :key="interfaceModel.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="interfaceModel.id" v-model="form.interfaceModel_ids" class="mr-2">
                  {{ interfaceModel.name_ja }}
                </label>
              </div>
            </div>

            <!-- Bluetooth -->
            <div class="mb-4 md:col-span-6">
              <label class="block">Bluetooth</label>
              <input v-model="form.bluetooth" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- Wi-Fi -->
            <div class="mb-4 md:col-span-6">
              <label class="block">Wi-Fi</label>
              <input v-model="form.wifi" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 内蔵マイク -->
            <div class="mb-4 md:col-span-6">
              <label class="block">内蔵マイク</label>
              <input v-model="form.microphone" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 内蔵スピーカー -->
            <div class="mb-4 md:col-span-6">
              <label class="block">内蔵スピーカー</label>
              <input v-model="form.speaker" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 三脚ネジ穴 -->
            <div class="mb-4 md:col-span-6">
              <label class="block">三脚ネジ穴</label>
              <input v-model="form.tripod_mount" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- バッテリータイプ -->
            <div class="mb-4 md:col-span-6">
              <label class="block">バッテリータイプ</label>
              <input v-model="form.battery_type" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- バッテリー容量（mAh） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">バッテリー容量（mAh）</label>
              <input v-model="form.battery_capacity_mAh" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- バッテリー重量（g） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">バッテリー重量（g）</label>
              <input v-model="form.battery_weight_g" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 撮影可能枚数 -->
            <div class="mb-4 md:col-span-6">
              <label class="block">撮影可能枚数</label>
              <input v-model="form.shots_per_charge" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 材質 -->
            <div class="mb-4 md:col-span-6">
              <label class="block">材質</label>
              <input v-model="form.body_material" type="text" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 動作可能温度（低） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">動作可能温度（低）</label>
              <input v-model="form.operating_temp_min_c" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 動作可能温度（高） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">動作可能温度（高）</label>
              <input v-model="form.operating_temp_max_c" type="number" class="border rounded w-full p-2 text-black">
            </div>

            <!-- ボディ幅（mm） -->
            <div class="mb-4 md:col-span-2">
              <label class="block">ボディ幅（mm）</label>
              <input v-model="form.body_width" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- ボディ高さ（mm） -->
            <div class="mb-4 md:col-span-2">
              <label class="block">ボディ高さ（mm）</label>
              <input v-model="form.body_height" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- ボディ奥行き（mm） -->
            <div class="mb-4 md:col-span-2">
              <label class="block">ボディ奥行き（mm）</label>
              <input v-model="form.body_depth" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 重量（本体のみ） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">重量（本体のみ・g）</label>
              <input v-model="form.body_weight_g" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 総重量（バッテリー含む） -->
            <div class="mb-4 md:col-span-3">
              <label class="block">総重量（バッテリー含む・g）</label>
              <input v-model="form.body_total_weight_g" type="number" step="0.1" class="border rounded w-full p-2 text-black">
            </div>

            <!-- 付属品 -->
            
            <div class="mb-4 md:col-span-2">
              <summary class="cursor-pointer font-semibold">付属品</summary>
              <div v-for="accessory in accessories" :key="accessory.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="accessory.id" v-model="form.accessory_ids" class="mr-2">
                  {{ accessory.name_ja }}
                </label>
              </div>
            </div>

            <!-- 表示言語 -->
            
            <div class="mb-4 md:col-span-2">
              <summary class="cursor-pointer font-semibold">表示言語</summary>
              <div v-for="displayLanguage in displayLanguages" :key="displayLanguage.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="displayLanguage.id" v-model="form.displayLanguageIds" class="mr-2">
                  {{ displayLanguage.name_ja }}
                </label>
              </div>
            </div>

            <!-- その他機能（複数選択） -->
            
            <div class="mb-4 md:col-span-2">
              <summary class="cursor-pointer font-semibold">その他機能</summary>
              <div v-for="feature in features" :key="feature.id">
                <label class="inline-flex items-center">
                  <input type="checkbox" :value="feature.id" v-model="form.feature_ids" class="mr-2">
                  {{ feature.name_ja }}
                </label>
              </div>
            </div>

 
      
            <!-- 登録ボタン -->
            <div class="mt-6">
              <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
                登録する
              </button>
            </div>

            <!-- 呼び出し -->
            <div class="mb-4 md:col-span-3">
              <select v-model="manufacturerInput" placeholder="メーカー名 (例: Leica)" class="border rounded w-full p-2 text-black">
                <option value="">選択してください</option>
                <option v-for="manufacturer in manufacturerOptions" :key="manufacturer.id" :value="manufacturer.id">
                  {{ manufacturer.name }}
                </option>
              </select>
              <!-- <input v-model="manufacturerInput" placeholder="メーカー名 (例: Leica)" class="border rounded w-full p-2 text-black"/> -->
              <input v-model="modelNumberInput" placeholder="型番 (例: 20212)" class="border rounded w-full p-2 text-black"/>
              <button @click="fetchFromSeeder" type="button">読み込み</button>
            </div>

            <!-- フォーム -->
            <!-- <CameraForm :form="form" :onSubmit="handleSubmit" :submitLabel="submitLabel" /> -->

            <!-- 更新ボタン（IDがあるとき） -->
            <div v-if="form.id" class="mt-4">
              <button @click="updateCamera" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                更新する
              </button>
            </div>

          </form>
        </div>
    </Layout>
</template>
  
<script setup>
import { ref, onMounted } from 'vue'
import { router, usePage } from '@inertiajs/vue3'
import Layout from '@/Shared/Layout.vue'
import axios from 'axios'

// テーブルからデータを取得
const {
  manufacturers,
  cameraTypes,
  features,
  lensMounts,
  sensorTypes,
  colorOptions,
  selfTimerSeconds,
  recordingMedias,
  photoFormats,
  videoFormats,
  videoCodecs,
  interfaceModels,
  accessories,
  displayLanguages,
  camera, // 編集時に渡されるカメラデータ（オプション）
} = usePage().props

const isEdit = ref(false)

onMounted(() => {
  if (camera) {
    isEdit.value = true
    Object.assign(form.value, {
      ...camera,
      price: camera.price_history?.price || '',
      price_data: camera.price_history?.price_data?.slice(0, 7) || '',
    })
  }
})

// シャッタースピード入力変換
// "1/8000" → 0.000125
const parseShutterSpeed = (value) => {
  if (!value) return null
  if (typeof value === "string" && value.includes("/")) {
    const [num, den] = value.split("/").map(Number)
    return den ? num / den : null
  }
  return Number(value) || null
}

const submit = () => {
  const manufacturer = manufacturers.find(m => m.id === form.value.manufacturer_id)
  const cameraType = cameraTypes.find(c => c.id === form.value.camera_type_id)
  const lensMount = lensMounts.find(l => l.id === form.value.lens_mount_id)
  const sensorType = sensorTypes.find(s => s.id === form.value.sensor_type_id)

  form.value.shutter_electronic_min = parseShutterSpeed(form.value.shutter_electronic_min)
  form.value.shutter_electronic_max = parseShutterSpeed(form.value.shutter_electronic_max)
  form.value.shutter_mechanical_min = parseShutterSpeed(form.value.shutter_mechanical_min)
  form.value.shutter_mechanical_max = parseShutterSpeed(form.value.shutter_mechanical_max)

  const mapIdsToNames = (ids, source) => ids.map(id => {
    const item = source.find(i => Number(i.id) === Number(id))
    return item ? item.name_ja || item.feature_ja : '不明'
  })

  const payload = {
    ...form.value,
    manufacturer_name: manufacturer?.name_en || '',
    camera_type_name: cameraType?.name_ja || '',
    lens_mount_name: lensMount?.name_ja || '',
    sensor_type_name: sensorType?.name_ja || '',

    colorOptions:     mapIdsToNames(form.value.colorOptionIds, colorOptions),
    selfTimerSeconds: mapIdsToNames(form.value.selfTimerSecondIds, selfTimerSeconds),
    recordingMedias:  mapIdsToNames(form.value.recordingMediaIds, recordingMedias),
    photoFormats:     mapIdsToNames(form.value.photoFormat_ids, photoFormats),
    videoFormats:     mapIdsToNames(form.value.videoFormat_ids, videoFormats),
    videoCodecs:      mapIdsToNames(form.value.videoCodec_ids, videoCodecs),
    interfaceModels:  mapIdsToNames(form.value.interfaceModel_ids, interfaceModels),
    accessories:      mapIdsToNames(form.value.accessory_ids, accessories),
    displayLanguages: mapIdsToNames(form.value.displayLanguageIds, displayLanguages),
    features:         mapIdsToNames(form.value.feature_ids, features),

    battery_data: {
      battery_type: form.value.battery_type,
      battery_capacity_mAh: form.value.battery_capacity_mAh,
      battery_weight_g: form.value.battery_weight_g,
    },

    price_history: {
      price: form.value.price,
      price_data: form.value.price_data,
    },
  }

  // console.log(data.manufacturer_name)

  // 不要キー削除
  const removeKeys = [
    'manufacturer_id', 'camera_type_id', 'lens_mount_id', 'price', 'price_data', 
    'sensor_type_id', 'colorOptionIds', 'selfTimerSecondIds', 'recordingMediaIds', 
    'photoFormat_ids', 'videoFormat_ids', 'videoCodec_ids', 'interfaceModel_ids', 
    'accessory_ids', 'displayLanguageIds', 'feature_ids',
  ]
  removeKeys.forEach(k => delete payload[k])

  if (isEdit.value) {
    router.put(`/cameras/${camera.id}`, payload, {
      onSuccess: () => alert('更新完了'),
      onError: errors => console.error('更新エラー:', errors),
    })
  } else {
    router.post('/cameras', payload, {
      onSuccess: () => alert('登録完了！'),
      onError: errors => console.error('バリデーションエラー', errors),
    })
  }
}

// カメラデータ呼び出し
const manufacturerInput = ref('')
const modelNumberInput = ref('')
const form = ref({
  manufacturer_id: null,
  camera_name: '',
  model_number: '',
  camera_type_id: null,
  lens_mount_id: null,
  release_year: '',
  discontinued_year: '',
  price: '',
  price_data: '',
  color_option_id: null,
  total_pixels: '',
  effective_pixels: '',
  sensor_type_id: null,
  sensor_width_mm: '',
  sensor_height_mm: '',
  image_sensor: '',
  image_processor: '',
  viewfinder_type: '',
  viewfinder_coverage: '',
  viewfinder_magnification: '',
  lcd_type: '',
  lcd_size_inch: '',
  lcd_resolution_dots: '',
  iso_standard_min: '',
  iso_standard_max: '',
  iso_extended_min: '',
  iso_extended_max: '',
  metering_method: '',
  metering_mode: '',
  exposure_value: '',
  shutter_electronic_min: '',
  shutter_electronic_max: '',
  shutter_mechanical_min: '',
  shutter_mechanical_max: '',
  drive_mode: '',
  burst_mode_fps: '',
  self_timer_second_id: null,
  white_balance: '',
  temperature_low: '',
  temperature_high: '',
  af_methods: '',
  af_points: '',
  buffer_memory_mb: '',
  internal_memory_gb: '',
  recording_media_id: null,
  card_slot_count: '',
  photo_format_id: null,
  photo_size_l_mb: '',
  photo_size_m_mb: '',
  photo_size_s_mb: '',
  photo_resolution_l: '',
  photo_resolution_m: '',
  photo_resolution_s: '',
  video_format_id: null,
  video_codec_id: null,
  video_resolution: '',
  audio_format: '',
  interface_model_id: null,
  bluetooth: '',
  wifi: '',
  microphone: '',
  speaker: '',
  tripod_mount: '',
  battery_type: '',
  battery_capacity_mAh: '',
  battery_weight_g: '',
  shots_per_charge: '',
  body_material: '',
  operating_temp_min_c: '',
  operating_temp_max_c: '',
  body_width: '',
  body_height: '',
  body_depth: '',
  body_weight_g: '',
  body_total_weight_g: '',
  accessory_id: null,
  display_language_id: null,

  // 多対多フィールド（必要に応じて）
  feature_ids: [],
  colorOptionIds: [],
  meteringMode_ids: [],
  selfTimerSecondIds: [],
  whiteBalanceIds: [],
  recordingMediaIds: [],
  photoFormat_ids: [],
  videoFormat_ids: [],
  videoCodec_ids: [],
  interfaceModel_ids: [],
  accessory_ids: [],
  displayLanguageIds: [],
})


// 選択肢の一覧（nameとidのマッピング）※IDは仮
const manufacturerOptions = ref([
  { id: 1, name: 'キヤノン', name_en: 'Canon' },
  { id: 2, name: 'ニコン', name_en: 'Nikon' },
  { id: 3, name: 'ソニー', name_en: 'Sony' },
  { id: 4, name: '富士フイルム', name_en: 'Fujifilm' },
  { id: 5, name: 'オリンパス', name_en: 'Olympus' },
  { id: 6, name: 'ライカ', name_en: 'Leica'},
  { id: 7, name: 'パナソニック', name_en: 'Panasonic' },
  { id: 8, name: 'ペンタックス', name_en: 'Pentax' },
  { id: 9, name: 'ハッセルブラッド', name_en: 'Hasselblad' },
])

const cameraTypeOptions = ref([
  { id: 1, name: '一眼レフ' },
  { id: 2, name: 'ミラーレス' },
  { id: 3, name: 'レンジファインダー' },
  { id: 4, name: 'コンパクト' },
  { id: 5, name: '中判カメラ' },
  { id: 6, name: 'フィルムカメラ' },
])

const lensMountOptions = ref([
  { id: 1,  name: 'キヤノンEFマウント' },
  { id: 2,  name: 'キヤノンRFマウント' },
  { id: 3,  name: 'ニコンFマウント' },
  { id: 4,  name: 'ニコンZマウント' },
  { id: 5,  name: 'ソニーEマウント' },
  { id: 6,  name: 'ソニーAマウント' },
  { id: 7,  name: '富士フイルムXマウント' },
  { id: 8,  name: 'マイクロフォーサーズマウント' },
  { id: 9,  name: 'ライカMバヨネットマウント' },
  { id: 10, name: 'ライカLバヨネットマウント' },
  { id: 11, name: 'ライカL39マウント' },
  { id: 12, name: 'ペンタックスKマウント' },
  { id: 13, name: 'ハッセルブラッド Xマウント (XCD)' },
])

const colorOptionOptions = ref([
  { id: 1, name: 'ブラック' },
  { id: 2, name: 'シルバー' },
  { id: 3, name: 'ホワイト' },
  { id: 4, name: 'グレー' },
  { id: 5, name: 'レッド' },
  { id: 6, name: 'ブルー' },
  { id: 7, name: 'ブラウン' },
  { id: 8, name: 'グリーン' },
  { id: 9, name: 'シャンパンゴールド' },
  { id: 10, name: 'チタン' },
  { id: 11, name: 'ベージュ' },
  { id: 12, name: 'ピンク' },
  { id: 13, name: 'オレンジ' },
  { id: 14, name: 'ネイビー' },
  { id: 15, name: 'オリーブ' },
  { id: 16, name: 'グラファイト' },
  { id: 17, name: 'ガンメタリック' },
  { id: 18, name: '限定カラー' },
])

const sensorTypeOptions = ref([
  { id: 1, name: 'フルサイズ' },
  { id: 2, name: 'APS-C' },
  { id: 3, name: 'APS-H' },
  { id: 4, name: 'マイクロフォーサーズ' },
  { id: 5, name: '1型' },
  { id: 6, name: '中判' },
  { id: 7, name: '1/1.7型' },
  { id: 8, name: '1/2.3型' },
  { id: 9, name: 'フォーサーズ' },
  { id: 10, name: 'CX（ニコン1型）' },
])

const selfTimerSecondOptions = ref([
  { id: 1, name: '2秒' },
  { id: 2, name: '3秒' },
  { id: 3, name: '5秒' },
  { id: 4, name: '6秒' },
  { id: 5, name: '10秒' },
  { id: 6, name: '12秒' },
  { id: 7, name: '20秒' },
  { id: 8, name: '30秒' },
])

const recordingMediaOptions = ref([
  { id: 1, name: 'SD', name_en: 'SD' },
  { id: 2, name: 'SDHC', name_en: 'SDHC' },
  { id: 3, name: 'SDXC', name_en: 'SDXC' },
  { id: 5, name: 'CFexpress card type A', name_en: 'CFexpress card type A' },
  { id: 6, name: 'CFexpress card type B', name_en: 'CFexpress card type B' },
  { id: 7, name: 'UHS-I対応', name_en: 'UHS-I' },
  { id: 8, name: 'UHS-II対応', name_en: 'UHS-II' },
])

const photoFormatOptions = ref([
  { id: 1, name: 'JPEG' },
  { id: 2, name: 'HEIF' },
  { id: 3, name: 'RAW' },
  { id: 4, name: 'DPRAW' },
  { id: 5, name: 'C-RAW' },
  { id: 6, name: '3FR RAW' },
  { id: 7, name: 'DNG' },
  { id: 8, name: 'NEF（RAW）' },
  { id: 9, name: 'TIFF' },
])

const videoFormatOptions = ref([
  { id: 1, name: 'MP4' },
  { id: 2, name: 'MOV' },
  { id: 3, name: 'AVCHD' },
  { id: 4, name: 'XAVC S' },
  { id: 5, name: 'XAVC HS' },
  { id: 6, name: 'XAVC S-I' },
  { id: 7, name: 'MOV All-I/IPB' },
])

const videoCodecOptions = ref([
  { id: 1, name: 'H.264 (MPEG-4 Part 10/AVC)' },
  { id: 2, name: 'H.265 (MPEG-H Part 2/HEVC)' },
  { id: 3, name: 'ProRes (422/HQ/LT)' },
  { id: 4, name: 'ProRes RAW(Apple)' },
  { id: 5, name: 'BRAW（Blackmagic RAW）' },
  { id: 6, name: 'Canon RAW/CRM（Cinema RAW Light）' },
  { id: 7, name: 'N-RAW' },
  { id: 8, name: 'Long GOP' },
])

const interfaceModelOptions = ref([
  { id: 1, name: 'アクセサリーシュー（電子接点無）' },
  { id: 2, name: 'ホットシュー（電子接点有）' },
  { id: 3, name: 'シンクロターミナル/タイムコード端子' },
  { id: 4, name: 'リモコン端子（タイプN3）' },
  { id: 5, name: 'USB 3.1 Gen1 Type C' },
  { id: 6, name: 'HDMI端子 2.1 Type A' },
  { id: 7, name: 'HDMIマイクロ端子（タイプD）' },
  { id: 8, name: 'オーディオ アウト3.5 mm' },
  { id: 9, name: 'オーディオ イン3.5 mm' },
  { id: 10, name: 'LAN端子' },
  { id: 11, name: '通信インターフェース' },
])

const accessoryOptions = ref([
  { id: 1, name: 'バッテリー' },
  { id: 2, name: 'バッテリーチャージャー' },
  { id: 3, name: '電源コード' },
  { id: 4, name: 'ストラップ' },
  { id: 5, name: 'ボディキャップ' },
  { id: 6, name: 'ホットシューカバー' },
  { id: 7, name: 'USBケーブル' },
  { id: 8, name: 'ケーブルプロテクター' },
  { id: 9, name: 'アイピースカップ' },
])

const displayLanguageOptions = ref([
  { id: 1, name: '英語' },
  { id: 2, name: 'ドイツ語' },
  { id: 3, name: 'フランス語' },
  { id: 4, name: 'イタリア語' },
  { id: 5, name: 'スペイン語' },
  { id: 6, name: 'ポルトガル語' },
  { id: 7, name: 'ロシア語' },
  { id: 8, name: '日本語' },
  { id: 9, name: '繁体中国語' },
  { id: 10, name: '簡体中国語' },
  { id: 11, name: '韓国語' },
  { id: 12, name: 'アラビア語' },
  { id: 13, name: 'ペルシャ語' },
  { id: 14, name: 'タイ語' },
  { id: 15, name: 'マレー語' },
])

const featureOptions = ref([
  { id: 1, name: '防塵・防滴' },
  { id: 2, name: '手ブレ補正機構' },
  { id: 3, name: '5軸手ブレ補正' },
  { id: 4, name: '自分撮り機能' },
  { id: 5, name: 'タッチパネル' },
  { id: 6, name: 'ゴミ取り機構' },
  { id: 7, name: '内蔵フラッシュ' },
  { id: 8, name: 'タイムラプス' },
  { id: 9, name: 'ライブビュー' },
  { id: 10, name: 'GPS' },
  { id: 11, name: 'UBS充電' },
  { id: 12, name: 'RAW+JPEG同時記録' },
  { id: 13, name: 'バルブ' },
  { id: 14, name: 'Wi-Fi' },
  { id: 15, name: 'NFC' },
  { id: 16, name: 'ピーキング表示' },
])

// 名前からIDに変換するユーティリティ関数
const resolveIdFromName = (options, targetName) => {
  const match = options.find(
    (opt) => opt.name === targetName || opt.name_en === targetName
  )
  return match ? match.id : null
}

// Seederから取得してフォームに反映
const fetchFromSeeder = async () => {
  try {
    console.log('🟢 fetchFromSeeder 開始')
    const selectedManufacturer = manufacturerOptions.value.find(
      (m) => m.id === manufacturerInput.value
    )
    const manufacturerNameEn = selectedManufacturer?.name_en || ''
    console.log('🟢 選択されたメーカー (英語):', manufacturerNameEn)

    const { data } = await axios.get('/camera-seed', {
      params: {
        manufacturer: manufacturerNameEn,
        model_number: modelNumberInput.value,
      },
    })
    console.log('🟢 Axios レスポンス取得:', data)

    // console.log('Seederからの色オプション:', data.colorOptions)
    // console.log('Seederからの表示言語:', data.displayLanguages)

    // 直接反映できる項目
    form.value.manufacturer_id          = resolveIdFromName(manufacturerOptions.value,    data.manufacturer_name)
    form.value.camera_type_id           = resolveIdFromName(cameraTypeOptions.value,      data.camera_type_name)
    form.value.lens_mount_id            = resolveIdFromName(lensMountOptions.value,       data.lens_mount_name)
    form.value.camera_name              = data.camera_name
    form.value.model_number             = data.model_number
    form.value.sensor_type_id           = resolveIdFromName(sensorTypeOptions.value,      data.sensor_type_name)
    form.value.release_year             = data.release_year ?? ''
    form.value.discontinued_year        = data.discontinued_year ?? ''
    form.value.effective_pixels         = data.effective_pixels
    form.value.total_pixels             = data.total_pixels ?? ''
    form.value.sensor_width_mm          = data.sensor_width_mm ?? ''
    form.value.sensor_height_mm         = data.sensor_height_mm ?? ''
    form.value.image_sensor             = data.image_sensor ?? ''
    form.value.image_processor          = data.image_processor ?? ''
    form.value.viewfinder_type          = data.viewfinder_type ?? ''
    form.value.viewfinder_coverage      = data.viewfinder_coverage ?? ''
    form.value.viewfinder_magnification = data.viewfinder_magnification ?? ''
    form.value.lcd_type                 = data.lcd_type ?? ''
    form.value.lcd_size_inch            = data.lcd_size_inch ?? ''
    form.value.lcd_resolution_dots      = data.lcd_resolution_dots ?? ''
    form.value.iso_standard_min         = data.iso_standard_min ?? ''
    form.value.iso_standard_max         = data.iso_standard_max ?? ''
    form.value.iso_extended_min         = data.iso_extended_min ?? ''
    form.value.iso_extended_max         = data.iso_extended_max ?? ''
    form.value.metering_method          = data.metering_method ?? ''
    form.value.metering_mode            = data.metering_mode ?? ''
    form.value.exposure_value           = data.exposure_value ?? ''
    form.value.shutter_electronic_min   = data.shutter_electronic_min ?? ''
    form.value.shutter_electronic_max   = data.shutter_electronic_max ?? ''
    form.value.shutter_mechanical_min   = data.shutter_mechanical_min ?? ''
    form.value.shutter_mechanical_max   = data.shutter_mechanical_max ?? ''
    form.value.drive_mode               = data.drive_mode ?? ''
    form.value.burst_mode_fps           = data.burst_mode_fps ?? ''
    form.value.white_balance            = data.white_balance ?? ''
    form.value.temperature_low          = data.temperature_low ?? ''
    form.value.temperature_high         = data.temperature_high ?? ''
    form.value.af_methods               = data.af_methods ?? ''
    form.value.af_points                = data.af_points ?? ''
    form.value.buffer_memory_mb         = data.buffer_memory_mb ?? ''
    form.value.internal_memory_gb       = data.internal_memory_gb ?? ''
    form.value.card_slot_count          = data.card_slot_count ?? ''
    form.value.photo_size_l_mb          = data.photo_size_l_mb ?? ''
    form.value.photo_size_m_mb          = data.photo_size_m_mb ?? ''
    form.value.photo_size_s_mb          = data.photo_size_s_mb ?? ''
    form.value.photo_resolution_l       = data.photo_resolution_l ?? ''
    form.value.photo_resolution_m       = data.photo_resolution_m ?? ''
    form.value.photo_resolution_s       = data.photo_resolution_s ?? ''
    form.value.video_resolution         = data.video_resolution ?? ''
    form.value.audio_format             = data.audio_format ?? ''
    form.value.bluetooth                = data.bluetooth ?? ''
    form.value.wifi                     = data.wifi ?? ''
    form.value.microphone               = data.microphone ?? ''
    form.value.speaker                  = data.speaker ?? ''
    form.value.tripod_mount             = data.tripod_mount ?? ''
    form.value.shots_per_charge         = data.shots_per_charge ?? ''
    form.value.body_material            = data.body_material ?? ''
    form.value.operating_temp_min_c     = data.operating_temp_min_c ?? ''
    form.value.operating_temp_max_c     = data.operating_temp_max_c ?? ''
    form.value.body_width               = data.body_width ?? ''
    form.value.body_height              = data.body_height ?? ''
    form.value.body_depth               = data.body_depth ?? ''
    form.value.body_weight_g            = data.body_weight_g ?? ''
    form.value.body_total_weight_g      = data.body_total_weight_g ?? ''

    // 名前 → ID 変換で反映する項目（nameしか来ない）
    form.value.color_option_id      = resolveIdFromName(colorOptionOptions.value,     data.color_option_name)
    form.value.self_timer_second_id = resolveIdFromName(selfTimerSecondOptions.value, data.self_timer_second_name)
    form.value.recording_media_id   = resolveIdFromName(recordingMediaOptions.value,  data.recording_media_name)
    form.value.photo_format_id      = resolveIdFromName(photoFormatOptions.value,     data.photo_format_name)
    form.value.video_format_id      = resolveIdFromName(videoFormatOptions.value,     data.video_format_name)
    form.value.video_codec_id       = resolveIdFromName(videoCodecOptions.value,      data.video_codec_name)
    form.value.interface_model_id   = resolveIdFromName(interfaceModelOptions.value,  data.interface_model_name)
    form.value.accessory_id         = resolveIdFromName(accessoryOptions.value,       data.accessory_name)
    form.value.display_language_id  = resolveIdFromName(displayLanguageOptions.value, data.display_language_name)
    form.value.feature_ids          = resolveIdFromName(featureOptions.value,         data.feature_name)

    //多対多の反映
    // 文字列の名前の配列 → ID配列に変換するヘルパー関数
    const resolveIdsFromNames = (names, options) => {
      // console.log('🛠 名前配列:', names)
      // console.log('🛠 選択肢:', options)
      return names.map(name => {
        const match = options.find(opt => opt.name === name || opt.name_ja === name || opt.name_en === name)
        console.log(`🔍 '${name}' に一致するID:`, match?.id ?? 'なし')
        return match ? match.id : null
      }).filter(id => id !== null)
    }

    // 多対多項目のID配列に変換して反映
    form.value.colorOptionIds     = resolveIdsFromNames(data.colorOptions || [],     colorOptionOptions.value)
    form.value.selfTimerSecondIds = resolveIdsFromNames(data.selfTimerSeconds || [], selfTimerSecondOptions.value)
    form.value.recordingMediaIds  = resolveIdsFromNames(data.recordingMedias || [],  recordingMediaOptions.value) 
    form.value.photoFormat_ids    = resolveIdsFromNames(data.photoFormats || [],     photoFormatOptions.value)
    form.value.videoFormat_ids    = resolveIdsFromNames(data.videoFormats || [],     videoFormatOptions.value)
    form.value.videoCodec_ids     = resolveIdsFromNames(data.videoCodecs || [],      videoCodecOptions.value)
    form.value.interfaceModel_ids = resolveIdsFromNames(data.interfaceModels || [],  interfaceModelOptions.value)
    form.value.accessory_ids      = resolveIdsFromNames(data.accessories || [],      accessoryOptions.value)
    form.value.displayLanguageIds = resolveIdsFromNames(data.displayLanguages || [], displayLanguageOptions.value)
    form.value.feature_ids        = resolveIdsFromNames(data.features || [],         featureOptions.value)

    // console.log('変換後のID配列(colorOptionIds):', form.value.colorOptionIds)
    // console.log('変換後のID配列(displayLanguageIds):', form.value.displayLanguageIds)

    // ネストされた price 情報など
    form.value.battery_type         = data.battery_data?.battery_type ?? ''
    form.value.battery_capacity_mAh = data.battery_data?.battery_capacity_mAh ?? ''
    form.value.battery_weight_g     = data.battery_data?.battery_weight_g ?? ''

    form.value.price      = data.price_history?.price ?? ''
    form.value.price_data = data.price_history?.price_data?.slice(0, 10) ?? ''
    console.log('📊 price_data:', form.value.price_data)

    alert('読み込みました！')

  } catch (err) {
    alert('読み込みに失敗しました')
    console.error(err)
  }
}
</script>
