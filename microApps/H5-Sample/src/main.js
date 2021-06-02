/*
 * @Author: sheng.wang
 * @Date: 2021-05-21 11:58:55
 * @LastEditTime: 2021-06-02 13:01:41
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/microApps/H5-Sample/src/main.js
 */

import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import "vant/lib/button/style";
import Button from "vant/lib/button";
import {
  Skeleton,
  List,
  Cell,
  CellGroup,
  Loading,
  PullRefresh,
  Form,
  Field,
} from "vant";

Vue.use(Cell);
Vue.use(Form);
Vue.use(List);
Vue.use(Field);
Vue.use(Button);
Vue.use(Loading);
Vue.use(Skeleton);
Vue.use(CellGroup);
Vue.use(PullRefresh);
Vue.config.productionTip = false;

import VConsole from "vconsole";
new VConsole();

import './utils/test'
import VueEngine from '@zkty-team/x-engine-vue-transfer-native-way'

import Header from "@zkty-team/x-engine-ui";
import "@zkty-team/x-engine-ui/lib/Header.css";
import lifeCycle from "@zkty-team/x-engine-lifecycle";
Vue.use(Header);
Vue.use(lifeCycle);
Vue.use(VueEngine)


// import compatiable from "./compatiable";
// Vue.use(compatiable);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");

export default Vue;
