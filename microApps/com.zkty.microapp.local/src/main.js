import Vue from 'vue'
import App from './App.vue'
import router from './router'
import './utils/rem.js'
import store from './store/index.js'
import Vant from 'vant';
import { Toast } from "vant";

import 'vant/lib/index.css';
import infiniteScroll from 'vue-infinite-scroll'

Vue.use(Vant)
Vue.use(Toast)
Vue.use(infiniteScroll)

Vue.config.productionTip = false

new Vue({
	router,
	store,
	render: h => h(App),
}).$mount('#app')