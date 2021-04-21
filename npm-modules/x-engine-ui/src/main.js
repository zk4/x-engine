import Vue from 'vue'
import App from './App.vue'
// 本地package
// import ZKTYHeader from '../package/header/index'      
// lib包中
import ZKTYHeader from "../lib/ZKTYHeader.common.js"
import "../lib/ZKTYHeader.css"
Vue.use(ZKTYHeader)
Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')
