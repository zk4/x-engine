import Vue from "vue";
import App from "./App.vue";
import router from "./router";
// 本地package
import HEADER from "../package/header/index";
// lib包中
// import HEADER from "../lib/HEADER.common.js";
import "../lib/HEADER.css";
Vue.use(HEADER);
Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
}).$mount("#app");
