// resources/js/bootstrap.js
import axios from 'axios';

axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

// .env の VITE_API_URL を優先
axios.defaults.baseURL = import.meta.env.VITE_API_URL || '/';

const token = document.head.querySelector('meta[name="csrf-token"]');
if (token) {
    axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content;
} else {
    console.error('CSRF token not found!');
}

window.axios = axios;
