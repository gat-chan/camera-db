<!-- resources/js/Pages/Camera-Detail.vue -->
<template>
  <Layout class="min-h-screen bg-black text-white">
    <div class="container mx-auto p-4">

      <!-- タイトル -->
      <h1 class="text-3xl font-bold mb-6">{{ camera.camera_name || '不明' }}</h1>

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
            class="flex flex-row gap-2 justify-center mt-2 overflow-x-auto"
          >
            <img
              v-for="(thumb, index) in cameraThumbnails"
              :key="index"
              :src="thumb"
              @click="selectedImage = thumb"
              class="w-12 h-12 object-contain rounded cursor-pointer bg-white flex-shrink-0 border hover:border-blue-500"
              :class="{ 'border-2 border-blue-500': selectedImage === thumb }"
              @error="removeThumbnail(index)"
            />
          </div>
        </div>

        <!-- 右: 基本情報 -->
        <div class="bg-gray-900 p-4 rounded-lg shadow">
          <div class="grid grid-cols-1 gap-4">
            <p><span class="font-semibold">型番:</span> {{ camera.model_number || '不明' }}</p>
            <p><span class="font-semibold">カメラタイプ:</span> {{ camera.camera_type?.name_ja || '不明' }}</p>
            <p><span class="font-semibold">レンズマウント:</span> {{ camera.lens_mount?.name_ja || '不明' }}</p>
            <p><span class="font-semibold">発売日:</span> {{ camera.release_year || '不明' }}</p>
            
            <div>
              <!-- 管理者だけインライン編集 -->
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.price"
                :id="camera.id"
                field="price"
                label="値段"
                :is-admin="auth?.user?.is_admin"
              />
              <p v-else><span class="font-semibold">値段:</span> {{ camera.price || '不明' }}</p>

              <p><span class="font-semibold">有効画素数:</span> {{ camera.effective_pixels || '不明' }} 万画素</p>
              <p><span class="font-semibold">センサータイプ:</span> {{ camera.sensor_type?.name_ja || '不明' }}</p>
              <p>
                <span class="font-semibold">常用ISO:</span>
                {{ camera.iso_standard_min || '不明' }} ~ {{ camera.iso_standard_max || '不明' }}
              </p>
              <p>
                <span class="font-semibold">ボディサイズ:</span>
                {{ camera.body_width || '不明' }} × {{ camera.body_height || '不明' }} × {{ camera.body_depth || '不明' }} mm
              </p>

              <!-- 管理者だけインライン編集 -->
              <EditableField
                v-if="auth?.user?.is_admin"
                v-model="camera.body_total_weight_g"
                :id="camera.id"
                field="body_total_weight_g"
                label="総重量"
                :is-admin="true"
              />
              <p v-else><span class="font-semibold">総重量:</span> {{ camera.body_total_weight_g || '不明' }} g</p>
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
                  <p>フォーマット: {{ camera.photo_format?.name_ja || '不明' }}</p>
                  <p>Lサイズ: {{ camera.photo_size_l_mb || '不明' }} MB</p>
                  <p>Mサイズ: {{ camera.photo_size_m_mb || '不明' }} MB</p>
                  <p>Sサイズ: {{ camera.photo_size_s_mb || '不明' }} MB</p>
                  <p>解像度(L): {{ camera.photo_resolution_l || '不明' }}</p>
                </div>

                <!-- 動画関連 -->
                <div>
                  <h3 class="font-semibold mb-2">動画</h3>
                  <p>フォーマット: {{ camera.video_format?.name_ja || '不明' }}</p>
                  <p>コーデック: {{ camera.video_codec?.name_ja || '不明' }}</p>
                  <p>解像度: {{ camera.video_resolution || '不明' }}</p>
                  <p>音声: {{ camera.audio_format || '不明' }}</p>
                </div>

                <!-- バッテリー -->
                <div>
                  <h3 class="font-semibold mb-2">バッテリー</h3>
                  <p>タイプ: {{ camera.battery_type || '不明' }}</p>
                  <p>容量: {{ camera.battery_capacity_mAh || '不明' }} mAh</p>
                  <p>重量: {{ camera.battery_weight_g || '不明' }} g</p>
                  <p>撮影可能枚数: {{ camera.shots_per_charge || '不明' }}</p>
                </div>

                <!-- インターフェイス -->
                <div>
                  <h3 class="font-semibold mb-2">インターフェイス</h3>
                  <p>インターフェイス: {{ camera.interface_model?.name_ja || '不明' }}</p>
                  <p>Bluetooth: {{ camera.bluetooth || '不明' }}</p>
                  <p>Wi-Fi: {{ camera.wifi || '不明' }}</p>
                  <p>マイク: {{ camera.microphone || '不明' }}</p>
                  <p>スピーカー: {{ camera.speaker || '不明' }}</p>
                  <p>三脚穴: {{ camera.tripod_mount || '不明' }}</p>
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
</script>
