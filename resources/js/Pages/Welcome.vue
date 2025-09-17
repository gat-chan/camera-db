<!-- resources/Pages/Welcome.vue -->
<script setup>
import { ref, onMounted } from 'vue'
import { Head, Link, usePage } from '@inertiajs/vue3'
import Layout from '@/Shared/Layout.vue'
import { Swiper, SwiperSlide } from 'swiper/vue'
import 'swiper/css';
import 'swiper/css/autoplay';
import { Autoplay } from 'swiper/modules';
const { props } = usePage()
const manufacturers = ref(props.manufacturers || [])
const latestCameras = ref(props.latestCameras || [])

const modules = [Autoplay]

// console.log('📦 manufacturers props:', manufacturers.value)
// console.log('📦 latestCameras props:', latestCameras.value)

const cameraImagePath = (camera) => {
  const manufacturer = camera.manufacturer?.name_en || '不明'
  const model = camera.model_number?.replace('/', '_') || '不明'
  return `/img/${manufacturer}/${manufacturer}_${model}_1.webp`
}

onMounted(() => {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('animate-fade-in-float')
        observer.unobserve(entry.target) // 1回だけアニメーションさせたい場合
      }
    })
  }, { threshold: 0.2 })

  document.querySelectorAll('.fade-section').forEach(el => observer.observe(el))
})


// SwiperCore.use([Autoplay]);

const openModal = (camera) => {
  console.log('Open modal for', camera);
}

defineOptions({ layout: Layout })

console.log('Ziggy',Ziggy.namedRoutes);

</script>

<template>
  <Head title="Camera-DB" />
  <div class="bg-gray-50 dark:bg-black text-gray-900 dark:text-white pt-12">
    
    <!-- ロゴ -->
    <section class="min-h-[80vh] flex items-center justify-center bg-black">
      <img src="/img/logos/toppage_logo.webp" alt="Camera-DB"
        class="mx-auto w-11/12 sm:w-[48rem] max-w-[600px] rounded-lg shadow-2xl animate-fade-in-float">
    </section>

    <!-- メーカー一覧セクション -->
    <section class="min-h-[80vh] flex items-center justify-center bg-black container mx-auto my-12 p-6 rounded-lg fade-section opacity-0">
      <div class="container mx-auto p-6 bg-gray-900 rounded-xl">
        <h2 class="text-2xl font-bold text-white mb-6 text-center">
          取り扱いメーカー一覧
        </h2>

        <div class="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 lg:grid-cols-5 gap-4 justify-items-center">
          <Link
            v-for="manufacturer in manufacturers"
            :key="manufacturer.id"
            :href="route('search-camera', { manufacturer_ids: [manufacturer.id] })"
            class="flex flex-col items-center p-2 rounded hover:bg-gray-500 transition"
          >
            <img
              :src="`/img/maker_logos/${manufacturer.name_en}_logo.svg`"
              :alt="manufacturer.name_ja || '不明'"
              class="w-16 h-16 md:w-24 md:h-24 object-contain mb-2 shadow-lg"
            />
            <span class="text-white text-sm text-center">{{ manufacturer.name_ja }}</span>
          </Link>
        </div>
      </div>
    </section>

    <!-- 新着カメラ -->
    <section class="min-h-[80vh] flex items-center justify-center bg-black p-6">
      <div class="container mx-auto">
        <h2 class="text-2xl font-bold mb-6 text-center text-white">
          新着カメラ一覧
        </h2>

        <swiper
          :modules="modules"
          :space-between="20"
          :loop="true"
          :loop-additional-slides="7"
          :autoplay="{ delay: 0, disableOnInteraction: false }"
          :speed="8000"
          :grab-cursor="true"
          class="mySwiper"
          :breakpoints="{
            0: { slidesPerView: 1 },       // スマホ（~640px）
            640: { slidesPerView: 2 },     // タブレット（640px~）
            1024: { slidesPerView: 3 }     // PC（1024px~）
          }"
        >
        <swiper-slide
          v-for="camera in latestCameras"
          :key="camera.id"
          class="bg-white border rounded-lg p-4 flex flex-col items-center justify-center cursor-pointer"
          @click="openModal(camera)"
        >
          <Link
            :href="route('camera-detail', camera.id)"
            class="flex flex-col items-center w-full h-full"
          >
            <!-- メーカー + カメラ名 -->
            <div class="flex flex-col sm:flex-row items-center justify-center gap-2 mb-4">
              <!-- メーカーロゴ -->
              <img
                v-if="camera.manufacturer"
                :src="`/img/maker_logos/${camera.manufacturer.name_en}_logo.svg`"
                :alt="camera.manufacturer.name_ja || 'メーカー不明'"
                class="w-20 h-6 object-contain"
              />
              <!-- カメラ名 -->
              <span class="text-xl font-bold text-gray-700">
                {{ camera.camera_name || '不明' }}
              </span>
            </div>

            <!-- カメラ画像 -->
            <div class="w-full sm:w-1/2">
              <div class="aspect-[16/9] w-full flex items-center justify-center">
                <img
                  :src="cameraImagePath(camera)"
                  alt="カメラ画像"
                  class="w-full h-full object-contain rounded"
                  @error="camera.imageError = true"
                  v-if="!camera.imageError"
                />
                <div
                  v-else
                  class="w-full h-full bg-gray-200 flex items-center justify-center rounded text-gray-500"
                >
                  画像なし
                </div>
              </div>
            </div>
          </Link>
        </swiper-slide>

        </swiper>

        <p v-if="latestCameras.length === 0" class="text-white text-center">
          新着カメラはありません
        </p>
      </div>
    </section>
    
  </div>

        <!-- フラッシュメッセージ -->
        <!-- <div v-if="flash?.success" class="mt-6 px-4 py-2 bg-green-600 text-white rounded-lg shadow">
        {{ flash.success }}
        </div> -->

</template>
