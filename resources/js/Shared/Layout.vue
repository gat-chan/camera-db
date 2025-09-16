<template>
    <Head>
        <link rel="icon" type="image/webp" href="/img/logos/logo_favicon.png" />
    </Head>
    <div class="bg-gray-50 text-black/50 dark:bg-black dark:text-white/50 min-h-screen">
        <div class="relative flex flex-col items-center selection:bg-[#FF2D20] selection:text-white z-10">
            <div class="relative w-full max-w-2xl px-6 lg:max-w-7xl">
                <!-- ヘッダー -->
                <header class="grid grid-cols-2 items-center gap-2 pt-2.5 pb-6 lg:grid-cols-3 
                               bg-white/70 dark:bg-black/70 backdrop-blur-md rounded-xl shadow-md">
                    
                    <!-- ロゴ -->
                    <div class="flex lg:col-start-1 lg:justify-center">
                        <img 
                            src="/img/logos/logo_icon.webp" 
                            alt="Logo Icon" 
                            class="h-12 w-auto lg:h-16"
                        />
                    </div>

                    <!-- 中央メニュー（PCのみ） -->
                    <nav class="hidden lg:flex lg:col-start-2 justify-center gap-6 text-sm font-semibold text-black dark:text-white">
                        <Link
                            :href="route('welcome')"
                            class="relative after:absolute after:bottom-0 after:left-0 after:h-0.5 after:w-0 after:bg-[#FF2D20] after:transition-all after:duration-300 hover:after:w-full"
                        >
                            ホーム
                        </Link>
                        <Link
                            :href="route('search-camera')"
                            class="relative after:absolute after:bottom-0 after:left-0 after:h-0.5 after:w-0 after:bg-[#FF2D20] after:transition-all after:duration-300 hover:after:w-full"
                        >
                            カメラを探す
                        </Link>
                        <Link
                            :href="$page.props.auth.user ? route('register-camera') : route('login')"
                            class="relative after:absolute after:bottom-0 after:left-0 after:h-0.5 after:w-0 after:bg-[#FF2D20] after:transition-all after:duration-300 hover:after:w-full"
                        >
                            カメラを登録
                        </Link>
                        <Link
                            :href="route('contact')"
                            class="relative after:absolute after:bottom-0 after:left-0 after:h-0.5 after:w-0 after:bg-[#FF2D20] after:transition-all after:duration-300 hover:after:w-full"
                        >
                            お問い合わせ
                        </Link>
                    </nav>

                    <!-- 右メニュー / ハンバーガー -->
                    <div class="flex justify-end items-center gap-2">
                        <!-- PC用ボタン -->
                        <nav v-if="$page.props.canLogin" class="hidden lg:flex gap-2">
                            <Link
                                v-if="$page.props.auth.user"
                                :href="route('dashboard')"
                                class="rounded-full px-4 py-2 bg-gradient-to-r from-[#FF6B6B] to-[#FF2D20] text-white font-semibold shadow-md hover:shadow-xl hover:scale-105 transition-transform duration-300"
                            >
                                Dashboard
                            </Link>

                            <template v-else>
                                <Link
                                    :href="route('login')"
                                    class="rounded-full px-4 py-2 bg-gradient-to-r from-[#FF6B6B] to-[#FF2D20] text-white font-semibold shadow-md hover:shadow-xl hover:scale-105 transition-transform duration-300"
                                >
                                    Log in
                                </Link>

                                <Link
                                    v-if="$page.props.canRegister"
                                    :href="route('register')"
                                    class="rounded-full px-4 py-2 bg-gradient-to-r from-[#FF6B6B] to-[#FF2D20] text-white font-semibold shadow-md hover:shadow-xl hover:scale-105 transition-transform duration-300"
                                >
                                    Register
                                </Link>
                            </template>
                        </nav>

                        <!-- モバイル用ハンバーガー -->
                        <button @click="mobileMenuOpen = !mobileMenuOpen" class="lg:hidden p-2 rounded-md hover:bg-gray-200 dark:hover:bg-gray-700 transition">
                            <svg v-if="!mobileMenuOpen" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
                            </svg>
                            <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                        </button>
                    </div>
                </header>

                <!-- モバイルメニュー -->
                <transition name="slide-fade">
                    <div
                            v-if="mobileMenuOpen"
                            ref="menuRef"
                            class="lg:hidden fixed top-0 left-0 right-0 mt-14 bg-black/90 backdrop-blur-sm z-50 flex flex-col items-center gap-4 text-white text-lg font-semibold rounded-b-xl p-4 shadow-lg"
                            @click.stop
                        >
                        <Link :href="route('welcome')" @click="mobileMenuOpen = false">ホーム</Link>
                        <Link :href="route('search-camera')" @click="mobileMenuOpen = false">カメラを探す</Link>
                        <Link :href="$page.props.auth.user ? route('register-camera') : route('login')" @click="mobileMenuOpen = false">カメラを登録</Link>
                        <Link :href="route('contact')" @click="mobileMenuOpen = false">お問い合わせ</Link>
                        <div class="flex flex-col gap-3 mt-4">
                            <Link v-if="$page.props.auth.user" :href="route('dashboard')" @click="mobileMenuOpen = false" class="rounded-full px-6 py-2 bg-gradient-to-r from-[#FF6B6B] to-[#FF2D20] text-white text-center font-semibold">Dashboard</Link>
                            <template v-else>
                                <Link :href="route('login')" @click="mobileMenuOpen = false" class="rounded-full px-6 py-2 bg-gradient-to-r from-[#FF6B6B] to-[#FF2D20] text-white text-center font-semibold">Log in</Link>
                                <Link v-if="$page.props.canRegister" :href="route('register')" @click="mobileMenuOpen = false" class="rounded-full px-6 py-2 bg-gradient-to-r from-[#FF6B6B] to-[#FF2D20] text-white text-center font-semibold">Register</Link>
                            </template>
                        </div>
                    </div>
                </transition>
            </div>
        </div>

        <main>
            <slot />
        </main>
    </div>
</template>

<script setup>
import { Link, Head, usePage } from '@inertiajs/vue3'
import { ref } from 'vue'
const page = usePage()
console.log(page.props)

const mobileMenuOpen = ref(false)

const menuRef = ref(null)

function onPageClick(event) {
  if (mobileMenuOpen.value && !menuRef.value.contains(event.target)) {
    mobileMenuOpen.value = false
  }
}

</script>

<style>
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: all 0.3s ease;
}
.slide-fade-enter-from,
.slide-fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}
</style>
