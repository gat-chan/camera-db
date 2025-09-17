<!-- resources/js/Pages/Camera-Detail.vue -->
<template>
  <Layout class="min-h-screen bg-black text-white">
    <div class="container mx-auto p-4">

      <!-- タイトル + メーカーロゴ -->
      <div class="flex items-center mb-6 gap-3">
        <h1 class="text-3xl font-bold text-white">
          {{ camera.manufacturer.name_en || '不明' }} {{ camera.camera_name || '不明' }}
        </h1>
      </div>


      <!-- 左右2分割 -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">

        <!-- 左: 画像ギャラリー -->
        <div class="flex flex-col items-center bg-gray-900">
          <!-- メイン画像 -->
          <div class="w-full h-80 md:h-[500px] flex items-center justify-center mb-4 bg-white rounded">
            <img
              v-if="selectedImage"
              :src="selectedImage"
              alt="カメラ画像"
              class="max-w-full max-h-full object-contain rounded"
            />
          </div>

          <!-- サムネイル -->
          <div
            v-if="cameraThumbnails.length"
            class="flex flex-row gap-2 overflow-x-auto w-full"
            style="scroll-snap-type: x mandatory;"
          >
            <img
              v-for="(thumb, index) in cameraThumbnails"
              :key="index"
              :src="thumb"
              @click="selectedImage = thumb"
              class="w-12 h-12 object-contain rounded cursor-pointer bg-white flex-shrink-0 border hover:border-blue-500"
              :class="{ 'border-2 border-blue-500': selectedImage === thumb }"
              @error="removeThumbnail(index)"
              style="scroll-snap-align: start;"
            />
          </div>
        </div>
        <!-- 右: 基本情報 -->
        <div class="bg-gray-900 p-4 rounded-lg shadow">
          <div class="grid grid-cols-1 gap-4">

            <!-- 型番 -->
            <EditableField
              v-if="auth?.user?.is_admin"
              v-model="camera.model_number"
              :id="camera.id"
              field="model_number"
              label="型番"
              :is-admin="auth?.user?.is_admin"
            />
            <p v-else><span class="font-semibold">型番:</span> {{ camera.model_number || '不明' }}</p>

            <!-- カメラタイプ・レンズマウント -->
            <div>
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.camera_type_id"
                :id="camera.id"
                field="camera_type_id"
                label="カメラタイプ"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else><span class="font-semibold">カメラタイプ:</span> {{ camera.camera_type?.name_ja || '不明' }}</p>
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.lens_mount_id"
                :id="camera.id"
                field="lens_mount_id"
                label="レンズマウント"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else><span class="font-semibold">レンズマウント:</span> {{ camera.lens_mount?.name_ja || '不明' }}</p>
            </div>

            <!-- 発売日 -->
            <div>
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.release_year"
                :id="camera.id"
                field="release_year"
                label="発売年"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else><span class="font-semibold">発売年:</span> {{ camera.release_year || '不明' }}</p>
              <!-- 値段 -->
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.price"
                :id="camera.id"
                field="price"
                label="値段"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else><span class="font-semibold">値段:</span> {{ camera.price || '不明' }}{{ priceSuffix }}</p>
            </div>

            <!-- センサー・有効画素数 -->
            <div>
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.sensor_type_id"
                :id="camera.id"
                field="sensor_type_id"
                label="センサータイプ"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else><span class="font-semibold">センサータイプ:</span> {{ camera.sensor_type?.name_ja || '不明' }}</p>
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.effective_pixels"
                :id="camera.id"
                field="effective_pixels"
                label="有効画素数"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else><span class="font-semibold">有効画素数:</span> {{ camera.effective_pixels || '不明' }} 万画素</p>
            </div>

            <!-- 常用ISO -->
            <div>
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.iso_standard_min"
                :id="camera.id"
                field="iso_standard_min"
                label="常用ISO(最小)"
                :is-admin="auth?.user?.is_admin"
              />
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.iso_standard_max"
                :id="camera.id"
                field="iso_standard_max"
                label="常用ISO(最大)"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else>
                <span class="font-semibold">常用ISO:</span>
                {{ camera.iso_standard_min || '不明' }} ~ {{ camera.iso_standard_max || '不明' }}
              </p>
              <!-- 電子シャッター -->
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.shutter_electronic_min"
                :id="camera.id"
                field="shutter_electronic_min"
                label="電子シャッター(最小)"
                :is-admin="auth?.user?.is_admin"
              />
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.shutter_electronic_max"
                :id="camera.id"
                field="shutter_electronic_max"
                label="電子シャッター(最大)"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else>
                <span class="font-semibold">電子シャッター:</span>
                {{ formatShutter(camera.shutter_electronic_min) }} ~ {{ formatShutter(camera.shutter_electronic_max) }}
              </p>
              <!-- メカニカルシャッター -->
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.shutter_mechanical_min"
                :id="camera.id"
                field="shutter_mechanical_min"
                label="メカシャッター(最小)"
                :is-admin="auth?.user?.is_admin"
              />
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.shutter_mechanical_max"
                :id="camera.id"
                field="shutter_mechanical_max"
                label="メカシャッター(最大)"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else>
                <span class="font-semibold">メカニカルシャッター:</span>
                {{ formatShutter(camera.shutter_mechanical_min) }} ~ {{ formatShutter(camera.shutter_mechanical_max) }}
              </p>
            </div>

            <!-- ボディサイズ -->
            <div>
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.body_width"
                :id="camera.id"
                field="body_width"
                label="幅"
                :is-admin="auth?.user?.is_admin"
              />
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.body_height"
                :id="camera.id"
                field="body_height"
                label="高さ"
                :is-admin="auth?.user?.is_admin"
              />
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.body_depth"
                :id="camera.id"
                field="body_depth"
                label="奥行"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else>
                <span class="font-semibold">ボディサイズ:</span>
                {{ camera.body_width || '不明' }} × {{ camera.body_height || '不明' }} × {{ camera.body_depth || '不明' }} mm
              </p>
              <!-- 総重量 -->
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.body_total_weight_g"
                :id="camera.id"
                field="body_total_weight_g"
                label="総重量"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else><span class="font-semibold">総重量:</span> {{ camera.body_total_weight_g || '不明' }}{{ weightSuffix }}</p>
              <!-- 動作温度 -->
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.operating_temp_min_c"
                :id="camera.id"
                field="operating_temp_min_c"
                label="動作温度(最小)"
                :is-admin="auth?.user?.is_admin"
              />
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.operating_temp_max_c"
                :id="camera.id"
                field="operating_temp_max_c"
                label="動作温度(最大)"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else>
                <span class="font-semibold">動作温度:</span>
                {{ camera.operating_temp_min_c || '不明' }} ~ {{ camera.operating_temp_max_c || '不明' }} ℃
              </p>
            </div>

          </div>
        </div>


        <!-- 詳細情報: 左右2列分全幅 -->
        <div class="md:col-span-2">
          <Disclosure as="div" class="mb-6">
            <DisclosureButton
              class="flex justify-between w-full bg-gray-800 px-4 py-2 text-left font-medium rounded-lg hover:bg-gray-700"
            >
              <span>詳細情報</span>
              <ChevronUpIcon class="w-5 h-5 text-gray-400 ui-open:rotate-180 transform transition" />
            </DisclosureButton>
            <DisclosurePanel class="mt-4 bg-gray-900 p-4 rounded-lg shadow">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

                <!-- 静止画関連 -->
                <div>
                  <h3 class="font-semibold mb-2">静止画</h3>
                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.photo_formats"
                    :id="camera.id"
                    field="photo_formats"
                    label="フォーマット"
                    :is-admin="auth?.user?.is_admin"
                    type="multi-select"
                  />
                  <p v-else>
                    フォーマット: {{ camera.photo_formats?.length ? camera.photo_formats.map(f => f.name_ja).join(', ') : '不明' }}
                  </p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.photo_size_l_mb"
                    :id="camera.id"
                    field="photo_size_l_mb"
                    label="ファイルサイズL"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>ファイルサイズL: {{ camera.photo_size_l_mb ? '約' + camera.photo_size_l_mb + 'MB': '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.photo_size_m_mb"
                    :id="camera.id"
                    field="photo_size_m_mb"
                    label="ファイルサイズM"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>ファイルサイズM: {{ camera.photo_size_m_mb ? '約' + camera.photo_size_m_mb + 'MB': '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.photo_size_s_mb"
                    :id="camera.id"
                    field="photo_size_s_mb"
                    label="ファイルサイズS"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>ファイルサイズS: {{ camera.photo_size_s_mb ? '約' + camera.photo_size_s_mb + 'MB': '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.photo_resolution_l"
                    :id="camera.id"
                    field="photo_resolution_l"
                    label="解像度(L)"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>解像度(L): {{ camera.photo_resolution_l || '不明' }}</p>
                </div>

                <!-- 動画関連 -->
                <div>
                  <h3 class="font-semibold mb-2">動画</h3>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.video_formats"
                    :id="camera.id"
                    field="video_formats"
                    label="フォーマット"
                    :is-admin="auth?.user?.is_admin"
                    type="multi-select"
                  />
                  <p v-else>
                    フォーマット: {{ camera.video_formats?.length ? camera.video_formats.map(f => f.name_ja).join(', ') : '不明' }}
                  </p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.video_codecs"
                    :id="camera.id"
                    field="video_codecs"
                    label="コーデック"
                    :is-admin="auth?.user?.is_admin"
                    type="multi-select"
                  />
                  <p v-else>
                    コーデック: {{ camera.video_codecs?.length ? camera.video_codecs.map(f => f.name_ja).join(', ') : '不明' }}
                  </p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.video_resolution"
                    :id="camera.id"
                    field="video_resolution"
                    label="解像度"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>解像度: {{ camera.video_resolution || '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.audio_format"
                    :id="camera.id"
                    field="audio_format"
                    label="音声フォーマット"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>音声フォーマット: {{ camera.audio_format || '不明' }}</p>
                </div>

                <!-- バッテリー -->
                <div>
                  <h3 class="font-semibold mb-2">バッテリー</h3>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.battery_type"
                    :id="camera.id"
                    field="battery_type"
                    label="タイプ"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>タイプ: {{ camera.battery_type || '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.battery_capacity_mAh"
                    :id="camera.id"
                    field="battery_capacity_mAh"
                    label="容量(mAh)"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>容量: {{ camera.battery_capacity_mAh || '不明' }} mAh</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.battery_weight_g"
                    :id="camera.id"
                    field="battery_weight_g"
                    label="バッテリー重量"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>バッテリー重量: {{ camera.battery_weight_g ? camera.battery_weight_g + 'g' : '不明' }}</p>
                </div>

                <!-- 記録関連 -->
                <div>
                  <h3 class="font-semibold mb-2">記録関連</h3>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.recording_medias"
                    :id="camera.id"
                    field="recording_medias"
                    label="記録メディア"
                    :is-admin="auth?.user?.is_admin"
                    type="multi-select"
                  />
                  <p v-else>
                    記録メディア: {{ camera.recording_medias?.length ? camera.recording_medias.map(f => f.name_ja).join(', ') : '不明' }}
                  </p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.card_slot_count"
                    :id="camera.id"
                    field="card_slot_count"
                    label="カードスロット数"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>カードスロット数: {{ camera.card_slot_count || '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.internal_memory_gb"
                    :id="camera.id"
                    field="internal_memory_gb"
                    label="内蔵メモリ(GB)"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>内蔵メモリ: {{ camera.internal_memory_gb ? camera.internal_memory_gb + ' GB' : '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.shots_per_charge"
                    :id="camera.id"
                    field="shots_per_charge"
                    label="撮影可能枚数"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>撮影可能枚数: {{ camera.shots_per_charge ? '約' + camera.shots_per_charge + '枚' : '不明' }}</p>
                </div>

                <!-- インターフェイス -->
                <div>
                  <h3 class="font-semibold mb-2">インターフェイス</h3>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.interface_models"
                    :id="camera.id"
                    field="interface_models"
                    label="インターフェイス"
                    :is-admin="auth?.user?.is_admin"
                    type="multi-select"
                  />
                  <p v-else>
                    インターフェイス: {{ camera.interface_models?.length ? camera.interface_models.map(i => i.name_ja).join(', ') : '不明' }}
                  </p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.bluetooth"
                    :id="camera.id"
                    field="bluetooth"
                    label="Bluetooth"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>Bluetooth: {{ camera.bluetooth || '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.wifi"
                    :id="camera.id"
                    field="wifi"
                    label="Wi-Fi"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>Wi-Fi: {{ camera.wifi || '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.microphone"
                    :id="camera.id"
                    field="microphone"
                    label="内蔵マイク"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>内蔵マイク: {{ camera.microphone || '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.speaker"
                    :id="camera.id"
                    field="speaker"
                    label="内蔵スピーカー"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>内蔵スピーカー: {{ camera.speaker || '不明' }}</p>

                  <EditableField
                    v-if="auth?.user?.is_admin"
                    v-model="camera.tripod_mount"
                    :id="camera.id"
                    field="tripod_mount"
                    label="三脚穴"
                    :is-admin="auth?.user?.is_admin"
                  />
                  <p v-else>三脚穴: {{ camera.tripod_mount || '1/4インチ-20 UNC' }}</p>
                </div>

              </div>
            </DisclosurePanel>
          </Disclosure>
        </div>


      </div>
    </div>
  </Layout>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { usePage } from '@inertiajs/vue3'
import Layout from '@/Shared/Layout.vue'
import { Disclosure, DisclosureButton, DisclosurePanel } from '@headlessui/vue'
import { ChevronUpIcon } from '@heroicons/vue/20/solid'
import EditableField from '@/Components/EditableField.vue'

const props = defineProps({
  camera: { type: Object, required: true },
})

// Inertiaの共有propsからauthを取得
const { props: pageProps } = usePage()
const auth = pageProps.auth

// サムネイル切替用
const selectedImage = ref(null)
const cameraThumbnails = ref([])

onMounted(() => {
  const cam = props.camera
  const basePath = `/img/${cam.manufacturer?.name_en || 'unknown'}/${cam.manufacturer?.name_en || 'unknown'}_${cam.model_number?.replace('/', '_') || 'unknown'}`
  
  // とりあえず _1〜_10 のサムネイルを生成
  cameraThumbnails.value = Array.from({ length: 10 }, (_, i) => `${basePath}_${i+1}.webp`)
  
  // 最初の画像をメインに
  selectedImage.value = cameraThumbnails.value[0]
})

// サムネイルがエラーなら除外
const removeThumbnail = (index) => {
  if (cameraThumbnails.value[index] === selectedImage.value) {
    selectedImage.value = cameraThumbnails.value.find((_, i) => i !== index) || null
  }
  cameraThumbnails.value.splice(index, 1)
}

// シャッタースピード変換
function formatShutter(speed) {
  if (!speed) return '不明'

  // 61秒以上 → 分表記
  if (speed > 60) {
    const minutes = speed / 60
    return minutes % 1 === 0
      ? `${minutes} 分`
      : `${minutes.toFixed(1)} 分`
  }

  // 1秒以上（60秒以下）は秒
  if (speed >= 1) {
    return `${speed} 秒`
  }

  // 1秒未満は 1/xxx 形式
  return `1/${Math.round(1 / speed)} 秒`
}


// Suffix定義
const priceSuffix = '円'
const weightSuffix = 'g'
</script>
