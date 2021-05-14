import Vue from "vue";
import App from "./App.vue";
import router from "./router";
// 本地package
// import Header from "../package/header/index";
// lib包中
import Header from "../lib/Header.common.js";
// import "../lib/Header.css";
Vue.use(Header);
Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
}).$mount("#app");
