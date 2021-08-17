/*
 * @Author: sheng.wang
 * @Date: 2021-05-21 11:58:55
 * @LastEditTime: 2021-06-03 14:40:18
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
  Tabs,
  Tab
} from "vant";
Vue.use(Tabs);
Vue.use(Tab);
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

import Header from "@zkty-team/x-engine-ui";
import "@zkty-team/x-engine-ui/lib/Header.css";
import lifeCycle from "@zkty-team/x-engine-lifecycle";
Vue.use(Header);
Vue.use(lifeCycle);
import engine from '@zkty-team/x-engine-core'

Vue.prototype.$engine = engine;
// 原生手机状态栏高度
Vue.prototype.$statusHeight = engine.api('com.zkty.jsi.device', 'getStatusBarHeight') || 0;
// 原生手机导航条高度
Vue.prototype.$navigatorHeight = engine.api('com.zkty.jsi.device', 'getNavigationHeight') || 64;
// 原生手机屏幕整体高度（物理像素）
Vue.prototype.$screenHeight = engine.api('com.zkty.jsi.device', 'getScreenHeight') || 0;
// 原生手机底部tabbar高度
Vue.prototype.$tabbarHeight = engine.api('com.zkty.jsi.device', 'getTabbarHeight') || 60;
// 顶部（状态栏+导航栏）高度
Vue.prototype.$topHeight = Number(Vue.prototype.$statusHeight) + Number(Vue.prototype.$navigatorHeight);
// 屏幕整体高度（css像素）
Vue.prototype.$clientHeight = document.documentElement.clientHeight;
// 内容可视区域高度(不含状态栏和导航条高度)
Vue.prototype.$scrollHeight = Vue.prototype.$clientHeight - Number(Vue.prototype.$statusHeight) - Number(Vue.prototype.$navigatorHeight);
// Vue.prototype.$isHybrid = engine.isHybrid();
// 原生手机相关信息
engine.api('com.zkty.jsi.device', 'getDeviceInfo', {}, (val) => {
  // this.$tabbarHeight.type          // iOS / android
  // this.$tabbarHeight.systemVersion // 14.4
  // this.$tabbarHeight.language      // en
  // this.$tabbarHeight.UUID          // UUID number
  Vue.prototype.$deviceInfo = val;
});

// import compatiable from "./compatiable";
// Vue.use(compatiable);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");

export default Vue;
