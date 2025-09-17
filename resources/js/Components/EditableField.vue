<!-- resources/js/Components/EditableField.vue -->
<script setup>
import { ref, watch } from 'vue'
import { useForm } from '@inertiajs/vue3'
import { PencilIcon, CheckIcon, XMarkIcon } from '@heroicons/vue/20/solid'

const props = defineProps({
  modelValue: [String, Number, Boolean, Date],
  field: { type: String, required: true },    // API に送るキー
  id: { type: Number, required: true },       // レコードID
  label: { type: String, required: true },    // 表示用ラベル
  suffix: { type: String, default: '' },      // 単位
  isAdmin: { type: Boolean, default: false }, // 管理者かどうか
  type: { type: String, default: 'text' },    // 'text' | 'number' | 'date' | 'textarea' | 'boolean'
  step: { type: [String, Number], default: 1 }, // 数値用 step
})

const emit = defineEmits(['update:modelValue'])

const editing = ref(false)
const localValue = ref(props.modelValue)

// フォーム初期化
const form = useForm({ [props.field]: localValue.value })

// props.modelValue が変わったら localValue も更新
watch(() => props.modelValue, (val) => {
  localValue.value = val
})

// 保存処理
const save = () => {
  if (!props.isAdmin) {
    alert('編集権限がありません。')
    editing.value = false
    return
  }

  // フォームの値を更新
  form[props.field] = localValue.value

  form.put(route('cameras.update', props.id), {
    preserveScroll: true,
    onSuccess: () => {
      emit('update:modelValue', localValue.value)
      editing.value = false
    },
    onError: (errors) => {
      console.error(errors)
      alert('保存に失敗しました。管理者権限を確認してください。')
      editing.value = false
    },
  })
}

// キャンセル
const cancel = () => {
  localValue.value = props.modelValue
  editing.value = false
}
</script>

<template>
  <div class="flex items-center gap-2">
    <span class="font-semibold">{{ label }}:</span>

    <!-- 表示モード -->
    <span v-if="!editing">
      <template v-if="type === 'boolean'">
        {{ modelValue ? 'Yes' : 'No' }}{{ suffix }}
      </template>
      <template v-else>
        {{ modelValue || '不明' }}{{ suffix }}
      </template>
    </span>

    <!-- 編集モード -->
    <input
      v-if="editing && (type === 'text' || type === 'number' || type === 'date')"
      :type="type"
      v-model="localValue"
      v-bind="type === 'number' ? { step } : {}"
      class="px-2 py-1 rounded text-black"
    />
    <span v-if="editing && suffix">{{ suffix }}</span>

    <textarea
      v-else-if="editing && type === 'textarea'"
      v-model="localValue"
      class="px-2 py-1 rounded text-black"
    ></textarea>

    <input
      v-else-if="editing && type === 'boolean'"
      type="checkbox"
      v-model="localValue"
      class="w-4 h-4"
    />

    <!-- 管理者だけアイコン表示 -->
    <div v-if="isAdmin" class="flex items-center gap-1">
      <!-- 表示モードの鉛筆アイコン -->
      <button
          v-if="!editing"
          @click="editing = true"
          class="p-1 rounded-full hover:bg-gray-700 transition-colors"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="1.5"
            stroke="currentColor"
            class="w-5 h-5 text-yellow-400 hover:text-yellow-300"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L6.832 19.82a4.5 4.5 0 0 1-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 0 1 1.13-1.897L16.863 4.487Zm0 0L19.5 7.125"
            />
          </svg>
        </button>

      <div v-else class="flex gap-1">
        <button @click="save" class="text-green-500 hover:text-green-700">
          <CheckIcon class="w-4 h-4" />
        </button>
        <button @click="cancel" class="text-red-500 hover:text-red-700">
          <XMarkIcon class="w-4 h-4" />
        </button>
      </div>
    </div>

    <!-- 非管理者の場合は編集アイコン非表示 -->
    <span v-else class="text-gray-400 italic text-sm">管理者のみ編集可能</span>
  </div>
</template>
