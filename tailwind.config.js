import defaultTheme from 'tailwindcss/defaultTheme';
import forms from '@tailwindcss/forms';

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',
        './storage/framework/views/*.php',
        './resources/views/**/*.blade.php',
        './resources/js/**/*.vue',
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ['Figtree', ...defaultTheme.fontFamily.sans],
            },
            keyframes: {
                fadeInFloat: {
                    '0%': { opacity: '0', transform: 'translateY(20px) scale(0.95)', filter: 'blur(8px)' },
                    '100%': { opacity: '1', transform: 'translateY(0) scale(1)', filter: 'blur(0)' },
                },
            },
            animation: {
                'fade-in-float': 'fadeInFloat 1s ease-out forwards',
                'fade-in-up': 'fade-in-up 1s ease-out forwards',
            },
        },
    },

    plugins: [forms],
};

