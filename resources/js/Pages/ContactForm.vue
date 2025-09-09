<script setup>
import { reactive, ref } from 'vue'
import { router } from '@inertiajs/vue3'   // ← これを使う！
import Layout from '@/Shared/Layout.vue'

const form = reactive({
  name: '',
  email: '',
  body: '',
})

const errors = reactive({
  email: '',
  body: '',
})

const showThanks = ref(false)

const validate = () => {
  let valid = true
  errors.email = ''
  errors.body = ''

  if (form.email && !/^[a-zA-Z0-9@._-]*$/.test(form.email)) {
    errors.email = '半角英数字のみ使用できます'
    valid = false
  }

  if (!form.body.trim()) {
    errors.body = '本文は必須です'
    valid = false
  }

  return valid
}

const submitForm = () => {
  if (!validate()) return

  // Inertia.post ではなく router.post を使う
  router.post('/contact', form, {
    onSuccess: () => {
      showThanks.value = true
      form.name = ''
      form.email = ''
      form.body = ''
    },
  })
}

defineOptions({ layout: Layout })

</script>

<template>
  <div class="min-h-[80vh] flex items-center justify-center">
    <div class="w-full max-w-2xl p-6 bg-gray-800 rounded-lg shadow-2xl animate-fade-in-float">
      <h2 class="text-2xl font-bold mb-4 text-center">お問い合わせフォーム</h2>

      <form @submit.prevent="submitForm" class="space-y-4">
        <!-- 名前 -->
        <div>
          <label class="block mb-1 font-medium">名前</label>
          <input
            v-model="form.name"
            type="text"
            placeholder="名前（任意）"
            class="w-full border rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-400 text-black"
          />
        </div>

        <!-- メールアドレス -->
        <div>
          <label class="block mb-1 font-medium">メールアドレス</label>
          <input
            v-model="form.email"
            type="text"
            placeholder="メールアドレス（任意）"
            class="w-full border rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-400 text-black"
          />
          <p v-if="errors.email" class="text-red-500 text-sm mt-1">{{ errors.email }}</p>
        </div>

        <!-- 本文 -->
        <div>
          <label class="block mb-1 font-medium">本文</label>
          <textarea
            v-model="form.body"
            placeholder="本文を入力してください"
            class="w-full border rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-400 text-black"
            rows="5"
          ></textarea>
          <p v-if="errors.body" class="text-red-500 text-sm mt-1">{{ errors.body }}</p>
        </div>

        <!-- 送信ボタン -->
        <button
          type="submit"
          class="w-full bg-indigo-500 text-white font-bold py-2 px-4 rounded hover:bg-indigo-600 transition"
        >
          送信
        </button>
      </form>

      <!-- お礼ポップアップ -->
      <div
        v-if="showThanks"
        class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50"
      >
        <div class="bg-white p-6 rounded shadow-md text-center max-w-sm mx-2">
          <p class="mb-4 text-lg font-medium text-black">送信ありがとうございました！</p>
          <button
            @click="showThanks = false"
            class="bg-indigo-500 text-white px-4 py-2 rounded hover:bg-indigo-600 transition"
          >
            閉じる
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
