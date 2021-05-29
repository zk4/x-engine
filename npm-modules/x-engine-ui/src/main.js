/*
 * @Author: sheng.wang
 * @Date: 2021-05-20 10:50:41
 * @LastEditTime: 2021-05-29 11:57:37
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/npm-modules/x-engine-ui/src/main.js
 */
import Vue from "vue";
import App from "./App.vue";
import router from "./router";
// 本地package
import Header from "../package/header/index";
// lib包中
// import Header from "../lib/Header.common.js";
// import "../lib/Header.css";
import xengine from '@zkty-team/x-engine-core'
console.log(xengine)
Vue.use(xengine)

Vue.use(Header);
Vue.config.productionTip = false;

new Vue({
  router,
  render: (h) => h(App),
}).$mount("#app");
