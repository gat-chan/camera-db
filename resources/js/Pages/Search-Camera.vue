<template>
  <Layout class="min-h-screen bg-black text-white">
    <div class="container mx-auto p-4">
      <h1 class="text-2xl font-bold mb-4">登録済みのカメラ一覧</h1>

      <Disclosure>
        <DisclosureButton
          class="flex w-full justify-between rounded-lg bg-gray-800 px-4 py-2 text-left text-sm font-medium text-white hover:bg-gray-700 focus:outline-none"
        >
          <span>検索条件</span>
          <ChevronUpIcon
            class="h-5 w-5 text-gray-400 ui-open:rotate-180 transform transition"
          />
        </DisclosureButton>

        <TransitionRoot>
          <TransitionChild
            enter="transition duration-300 ease-out"
            enter-from="transform scale-95 opacity-0"
            enter-to="transform scale-100 opacity-100"
            leave="transition duration-200 ease-in"
            leave-from="transform scale-100 opacity-100"
            leave-to="transform scale-95 opacity-0"
          >
            <DisclosurePanel>
              <form
                @submit.prevent="searchCameras"
                class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 bg-gray-900 p-4 rounded-b-lg shadow"
              >
                <!-- メーカー -->
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-1">メーカー</label>
                  <div class="flex flex-wrap gap-2">
                    <RadixVue.Toggle
                      v-for="m in manufacturers"
                      :key="m.id"
                      :pressed="filters.manufacturer_ids.includes(m.id)"
                      @update:pressed="(val) => toggleFilter(filters.manufacturer_ids, m.id, val)"
                      class="px-3 py-1 rounded-full text-sm transition data-[state=on]:bg-blue-600 data-[state=on]:text-white bg-gray-700 text-gray-300 hover:bg-gray-600"
                    >
                      {{ m.name_ja }}
                    </RadixVue.Toggle>
                  </div>
                </div>

                <!-- カメラタイプ -->
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-1">カメラタイプ</label>
                  <div class="flex flex-wrap gap-2">
                    <RadixVue.Toggle
                      v-for="type in cameraTypes"
                      :key="type.id"
                      :pressed="filters.camera_type_ids.includes(type.id)"
                      @update:pressed="(val) => toggleFilter(filters.camera_type_ids, type.id, val)"
                      class="px-3 py-1 rounded-full text-sm transition 
                            data-[state=on]:bg-green-600 data-[state=on]:text-white 
                            bg-gray-700 text-gray-300 hover:bg-gray-600"
                    >
                      {{ type.name_ja }}
                    </RadixVue.Toggle>
                  </div>
                </div>

                <!-- センサータイプ -->
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-1">センサータイプ</label>
                  <div class="flex flex-wrap gap-2">
                    <RadixVue.Toggle
                      v-for="s in sensorTypes"
                      :key="s.id"
                      :pressed="filters.sensor_type_ids.includes(s.id)"
                      @update:pressed="(val) => toggleFilter(filters.sensor_type_ids, s.id, val)"
                      class="px-3 py-1 rounded-full text-sm transition 
                            data-[state=on]:bg-purple-600 data-[state=on]:text-white 
                            bg-gray-700 text-gray-300 hover:bg-gray-600"
                    >
                      {{ s.name_ja }}
                    </RadixVue.Toggle>
                  </div>
                </div>
                <!-- 価格範囲 -->
                <div class="mb-4">
                  <label class="block text-sm font-medium text-gray-300">価格帯</label>
                  <Slider
                    v-model="filters.price_range"
                    :min="0"
                    :max="2000000"
                    :step="1000"
                    range
                    class="w-full mt-2"
                  />
                  <div class="flex justify-between text-xs text-gray-400 mt-1">
                    <span>{{ filters.price_range[0].toLocaleString() }}円</span>
                    <span>{{ filters.price_range[1].toLocaleString() }}円</span>
                  </div>
                </div>
                <!-- 最大重量 -->
                <div class="mb-4">
                  <label class="block text-sm font-medium text-gray-300">最大重量</label>
                  <Slider v-model="filters.weight_range" :min="0" :max="1500" :step="10" :tooltip="'always'" class="my-4" />
                  <p class="text-gray-400"> {{ filters.weight_range[0].toLocaleString() }}g 〜 {{ filters.weight_range[1].toLocaleString() }}g </p>
                </div> 
                <!-- 発売年 --> 
                <div class="mb-4">
                  <label class="block text-sm font-medium text-gray-300">発売年</label>
                  <Slider v-model="filters.release_year" :min="1980" :max="2025" :step="1" :tooltip="'always'" class="my-4" />
                  <p class="text-gray-400"> {{ filters.release_year }}年 </p>
                </div>
               
                <!-- 最大画素数 --> 
                <div class="mb-4">
                  <label class="block text-sm font-medium text-gray-300">最大画素数</label>
                    <Slider v-model="filters.effective_pixels" :min="2000" :max="10000" :step="1" :tooltip="'always'" class="my-4" />
                    <p class="text-gray-400"> {{ filters.effective_pixels }}万画素 </p>
                </div>
                <!-- 動画フォーマット -->
                <div>
                  <label class="block text-sm font-medium text-gray-300 mb-1">動画フォーマット</label>
                  <div class="flex flex-wrap gap-2">
                    <RadixVue.Toggle
                      v-for="s in videoFormats"
                      :key="s.id"
                      :pressed="filters.video_format_ids.includes(s.id)"
                      @update:pressed="(val) => toggleFilter(filters.video_format_ids, s.id, val)"
                      class="px-3 py-1 rounded-full text-sm transition 
                            data-[state=on]:bg-purple-600 data-[state=on]:text-white 
                            bg-gray-700 text-gray-300 hover:bg-gray-600"
                    >
                      {{ s.name_ja }}
                    </RadixVue.Toggle>
                  </div>
                </div>
                <!-- キーワード -->
                <div class="sm:col-span-2 md:col-span-4">
                  <label class="block text-sm font-medium text-gray-300">キーワード検索</label>
                  <input v-model="filters.keyword"
                        type="text"
                        placeholder="モデル名・特徴など"
                        class="w-full border rounded px-2 py-1 bg-gray-800 text-white focus:ring-2 focus:ring-blue-500" />
                </div>

                <!-- 検索ボタン -->
                <button
                  type="submit"
                  class="px-6 py-2 rounded-lg bg-gradient-to-r from-blue-500 to-indigo-600 text-white font-medium shadow hover:from-blue-600 hover:to-indigo-700 transition-all"
                >
                  🔍 検索する
                </button>
              </form>
            </DisclosurePanel>
          </TransitionChild>
        </TransitionRoot>
      </Disclosure>

      <!-- カメラリスト -->
      <div v-if="loading" class="flex justify-center items-center h-60 text-gray-300 text-lg font-medium">
        読み込み中...
      </div>

      <div v-else>
        <div v-if="cameras.length === 0" class="flex justify-center items-center h-60 text-gray-300 text-lg italic">
          登録されたカメラはありません。
        </div>

        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          <div
            v-for="camera in cameras"
            :key="camera.id"
            class="border rounded-lg p-4 shadow-sm bg-white cursor-pointer"
            @click="openModal(camera)"
          >
            <!-- メーカー・品名表示 -->
            <div class="flex flex-col sm:flex-row items-center justify-center gap-2 mb-4">
              <span class="text-base text-gray-500">
                {{ camera.manufacturer?.name_ja || '不明' }}
              </span>
              <span class="text-2xl font-bold text-gray-700">
                {{ camera.camera_name || '不明' }}
              </span>
            </div>

            <div class="flex flex-col gap-4 items-center">
              <div class="sm:w-1/2 w-full">
                <img
                  :src="cameraImagePath(camera)"
                  alt="カメラ画像"
                  class="w-full h-auto object-contain rounded"
                  @error="camera.imageError = true"
                  v-if="!camera.imageError"
                />
                <div
                  v-else
                  class="w-full aspect-video bg-gray-200 flex items-center justify-center rounded text-gray-500"
                >
                  画像なし
                </div>
              </div>

              <!-- パネル スペック表示 -->
              <div class="sm:w-1/2 w-full">
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-2">
                  <p class="text-sm text-gray-500">
                    {{ camera.camera_type?.name_ja || '不明' }}
                  </p>
                  <p class="text-sm text-gray-500">
                    {{ camera.sensor_type?.name_ja || '不明' }}
                  </p>
                  <p class="text-sm text-gray-500">
                    {{ camera.price ? '¥' + camera.price.toLocaleString() : '価格不明' }}
                  </p>
                  <p class="text-sm text-gray-500">
                    型番: {{ camera.model_number || '不明' }}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>


      <!-- モーダル -->
      <div
        v-if="selectedCamera"
        class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 text-gray-600"
        @click.self="closeModal"
        >
        <div class="bg-white rounded-lg p-6 w-full max-w-3xl h-[50vh] shadow-lg flex flex-col md:flex-row gap-6 overflow-hidden">
          
          <!-- 左: 画像 -->
          <div class="md:w-1/2 w-full flex flex-col items-center justify-center h-full">
            <!-- メイン画像 -->
            <div class="w-full h-full flex items-center justify-center">
              <img
                :src="selectedImage"
                alt="カメラ画像"
                class="max-w-full max-h-full object-contain rounded"
                v-if="selectedImage"
              />
            </div>

            <!-- サムネイル -->
            <div v-if="cameraThumbnails.length" class="flex flex-wrap gap-2 justify-center mt-2">
              <img
                v-for="(thumb, index) in cameraThumbnails"
                :key="index"
                :src="thumb"
                @click="selectedImage = thumb"
                class="w-12 h-12 object-contain rounded cursor-pointer border hover:border-blue-500 flex-shrink-0"
                :class="{ 'border-2 border-blue-500': selectedImage === thumb }"
                @error="removeThumbnail(index)"
              />
            </div>
          </div>

          <!-- 右: 詳細情報 -->
          <div class="md:w-1/2 w-full h-full overflow-y-auto pr-2">
            <h2 class="text-2xl font-bold mb-3">{{ selectedCamera.camera_name || '不明' }}</h2>
            <p class="mb-2">メーカー: {{ selectedCamera.manufacturer?.name_ja || '不明' }}</p>
            <p class="mb-2">型番: {{ selectedCamera.model_number || '不明' }}</p>
            <p class="mb-2">価格: {{ selectedCamera.price ? '¥' + selectedCamera.price.toLocaleString() : '価格不明' }}</p>
            <p class="mb-2">カメラタイプ: {{ selectedCamera.camera_type?.name_ja || '不明' }}</p>
            <p class="mb-2">センサータイプ: {{ selectedCamera.sensor_type?.name_ja || '不明' }}</p>
            <p class="mb-2">有効画素数: {{ selectedCamera.effective_pixels ? selectedCamera.effective_pixels + ' 万画素' : '不明' }}</p>
            <p class="mb-2">ISO感度: {{ selectedCamera.iso_standard_min || '不明' }} ~ {{ selectedCamera.iso_standard_max || '不明' }}</p>
            <p class="mb-2">
              シャッタースピード:
              {{ formatShutter(selectedCamera.shutter_mechanical_min) }}
              ~
              {{ formatShutter(selectedCamera.shutter_mechanical_max) }}
            </p>
            <p class="mb-2">重量: {{ selectedCamera.body_weight_g ? selectedCamera.body_weight_g + ' g' : '不明' }}</p>

            <div v-if="selectedCamera.features?.length">
              <p class="font-semibold mt-4">特徴:</p>
              <ul class="grid grid-cols-2 gap-x-6 list-disc list-inside text-sm">
                <li v-for="f in selectedCamera.features" :key="f.id">{{ f.name_ja }}</li>
              </ul>
            </div>

            <!-- モーダル内のボタン部分 -->
            <div class="flex gap-4 mt-6">
              <!-- 閉じるボタン -->
              <button
                @click="closeModal"
                class="px-4 py-2 bg-gray-700 text-white rounded hover:bg-gray-800"
              >
                閉じる
              </button>

              <!-- 詳細ページボタン -->
              <Link
                :href="route('camera-detail', selectedCamera.id)"
                class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
              >
                詳細ページへ
              </Link>
            </div>

          </div>
        </div>
      </div>

    </div>
    
    <div
      class="fixed bottom-4 left-1/2 transform -translate-x-1/2 bg-black bg-opacity-70 text-white text-sm px-6 py-2 rounded shadow-lg z-50"
    >
      検索結果：{{ resultCount }} 件
    </div>

  </Layout>
</template>

  
<script setup>
import { ref, onMounted, onBeforeUnmount, watch } from 'vue'
import { usePage, router, Link } from '@inertiajs/vue3'
import Layout from '@/Shared/Layout.vue'
import { Disclosure, DisclosureButton, DisclosurePanel, TransitionRoot, TransitionChild } from '@headlessui/vue'
import { ChevronUpIcon } from '@heroicons/vue/20/solid'
import Slider from '@vueform/slider'
import '@vueform/slider/themes/default.css'
import * as RadixVue from "radix-vue"

const { props } = usePage()

// モーダル用
const selectedCamera = ref(null)
const selectedImage = ref(null)
const cameraThumbnails = ref([])

const cameras = ref([])

if (props.cameras && props.cameras.data) {
  cameras.value = [...props.cameras.data]
}

console.log('📦 cameras props:', cameras.value)
// console.log(window.Ziggy.routes)

const currentPage = ref(props.cameras?.current_page || 1)
const lastPage = ref(props.cameras?.last_page || 1)
const loading = ref(false)

// 画像ファイルパス　ログ出力--------------------------------------------------------
const cameraImagePath = (camera) => {
  const path = `/img/${camera.manufacturer?.name_en || '不明'}/${camera.manufacturer?.name_en || '不明'}_${camera.model_number?.replace('/', '_') || '不明'}_1.webp`
  
  // 一覧の全カメラで毎回ログ出力
  // console.log(`📂 カメラID:${camera.id} 画像パス ->`, path)

  return path
}

// モーダルが開いた時にサムネイルリストを生成
watch(selectedCamera, (val) => {
  if (val) {
    const basePath = `/img/${val.manufacturer?.name_en || '不明'}/${val.manufacturer?.name_en || '不明'}_${val.model_number?.replace('/', '_') || '不明'}`

    // とりあえず _1〜_10 まで作っておく
    cameraThumbnails.value = Array.from({ length: 10 }, (_, i) => `${basePath}_${i+1}.webp`)

    // 最初は _1.webp をメインに
    selectedImage.value = cameraThumbnails.value[0]
  } else {
    cameraThumbnails.value = []
    selectedImage.value = null
  }
})


// サムネイルがエラーなら除外
const removeThumbnail = (index) => {
  if (cameraThumbnails.value[index] === selectedImage.value) {
    // 表示中の画像が消えたら次の画像に切り替え
    selectedImage.value = cameraThumbnails.value.find((_, i) => i !== index) || null
  }
  cameraThumbnails.value.splice(index, 1)
}

// シャッタスピード変換
function formatShutter(speed) {
  if (!speed) return '不明'

  // 61秒以上 → 分表記（小数も可）
  if (speed > 60) {
    // ちょうど分割り切れるなら整数で表示
    const minutes = speed / 60
    return minutes % 1 === 0
      ? `${minutes} 分`
      : `${minutes.toFixed(1)} 分`
  }

  // 1秒以上（60秒以下）はそのまま秒
  if (speed >= 1) {
    return `${speed} 秒`
  }

  // 1秒未満は 1/xxx 形式
  return `1/${Math.round(1 / speed)} 秒`
}

// 検索結果　トースト通知--------------------------------------------------------
const resultCount = ref(props.cameras.total)

function openModal(camera) { selectedCamera.value = camera }
function closeModal() { selectedCamera.value = null }

// 無限スクロール編------------------------------------------------------------
const loadMore = async () => {
  if (currentPage.value >= lastPage.value || loading.value) return
  loading.value = true

  await router.get(route('search-camera'), {
    ...filters.value,
    page: currentPage.value + 1,
  }, {
    preserveState: true,
    preserveScroll: true,
    only: ['cameras', 'filters'],
    onSuccess: (page) => {
      cameras.value.push(...page.props.cameras.data)
      currentPage.value = page.props.cameras.current_page
      lastPage.value = page.props.cameras.last_page
      resultCount.value = page.props.cameras.total || 0
      loading.value = false
    },
    onError: () => {
      loading.value = false
    }
  })
}

const onScroll = () => {
  if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 200) {
    loadMore()
  }
}

onMounted(() => {
  window.addEventListener('scroll', onScroll)
  console.log('初期props:', props.cameras)
})
onBeforeUnmount(() => {
  window.removeEventListener('scroll', onScroll)
})

// 検索ロジック--------------------------------------------------------------------------
const manufacturers = ref(props.manufacturers   || []) // propsから取得（後述のLaravel側で渡す）
const cameraTypes   = ref(props.cameraTypes     || [])
const sensorTypes   = ref(props.sensorTypes     || [])
const videoFormats  = ref(props.videoFormats    || [])

const toggleFilter = (arr, value, pressed) => {
  if (pressed && !arr.includes(value)) arr.push(value)
  else if (!pressed) arr.splice(arr.indexOf(value), 1)
}

const filters = ref({
  manufacturer_ids: props.filters?.manufacturer_ids || [],
  camera_type_ids:  props.filters?.camera_type_ids  || [],
  sensor_type_ids:  props.filters?.sensor_type_ids  || [],
  video_format_ids: props.filters?.video_format_ids || [],
  price_range:      props.filters?.price_range || [50000, 2000000],
  weight_range:     props.filters?.weight_range || [100, 1200],
  release_year:     props.filters?.release_year || 2000,
  effective_pixels: props.filters?.effective_pixels || 8000,
  iso_min:          props.filters?.iso_min || null,
  iso_max:          props.filters?.iso_max || null,
  keyword:          props.filters?.keyword || '',
})

const searchCameras = () => {
  console.log('検索条件:', filters.value)
  loading.value = true
  currentPage.value = 1
  cameras.value = []

  // price_range から min_price / max_price をセット
  if (filters.value.price_range) {
    filters.value.min_price = filters.value.price_range[0]
    filters.value.max_price = filters.value.price_range[1]
  }

  router.get(route('search-camera'), filters.value, {
    preserveState: true,   // ページ遷移時に Vue 状態を保持
    preserveScroll: true,
    only: ['cameras', 'filters'],
    replace: true,
    onSuccess: (page) => {
      cameras.value = [...page.props.cameras.data]
      currentPage.value = page.props.cameras.current_page
      lastPage.value = page.props.cameras.last_page
      resultCount.value = page.props.cameras.total || 0
      loading.value = false
    },
    onError: () => {
      loading.value = false
    }
  })
}

console.log(videoFormats)

// 総件数ログ
// console.log(props.cameras.total)         


</script>

