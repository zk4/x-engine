import Vue from 'vue'
import App from './App.vue'
import router from './router'
import './utils/rem.js'
import './assets/css/common.less'

import Vant from 'vant';
import 'vant/lib/index.css';
import infiniteScroll from 'vue-infinite-scroll'
import Toast from 'vant';
import VConsole from 'vconsole/dist/vconsole.min.js'
let vConsole = new VConsole()

Vue.use(Toast);
Vue.use(infiniteScroll)
Vue.use(Vant)

Vue.config.productionTip = false

new Vue({
	router,
	render: h => h(App),
}).$mount('#app')
