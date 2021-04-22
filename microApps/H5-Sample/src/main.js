import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import 'vant/lib/button/style';
import Button from 'vant/lib/button';
import {
  Skeleton
} from 'vant';
import {
  List
} from 'vant';
import {
  Cell,
  CellGroup
} from 'vant';
import {
  Loading
} from 'vant';
import {
  PullRefresh
} from 'vant';
import {
  Form
} from 'vant';
import {
  Field
} from 'vant';

Vue.use(Form);
Vue.use(Field);

Vue.use(PullRefresh);
Vue.use(Loading);
Vue.use(Cell);
Vue.use(CellGroup);
Vue.use(List);
Vue.use(Skeleton);
Vue.use(Button);
Vue.config.productionTip = false

import engine from "@zkty-team/x-engine-core"
Vue.prototype.$engine = engine;
// 原生手机状态栏高度
Vue.prototype.$statusHeight = engine.api("com.zkty.jsi.device", "getStatusBarHeight");
// 原生手机导航条高度
Vue.prototype.$navigatorHeight = engine.api("com.zkty.jsi.device", "getNavigationHeight")
// 原生手机屏幕整体高度
Vue.prototype.$screenHeight = engine.api("com.zkty.jsi.device", "getScreenHeight")
// 原生手机底部tabbar高度
Vue.prototype.$tabbarHeight = engine.api("com.zkty.jsi.device", "getTabbarHeight")
// 原生手机相关信息
engine.api("com.zkty.jsi.device", "getDeviceInfo", {}, (val) => {
  // this.$tabbarHeight.type          // iOS / android
  // this.$tabbarHeight.systemVersion // 14.4
  // this.$tabbarHeight.language      // en
  // this.$tabbarHeight.UUID          // UUID number
  Vue.prototype.$tabbarHeight = val
});

import ZKTYHeader from '@zkty-team/x-engine-ui';
import "@zkty-team/x-engine-ui/lib/ZKTYHeader.css"
Vue.use(ZKTYHeader);


Vue.prototype.$store = store
new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')