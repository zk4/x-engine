import Vue from 'vue';
import App from './App.vue';
import router from './router';
import 'vant/lib/button/style';
import Button from 'vant/lib/button';
import { Skeleton } from 'vant';
import { List } from 'vant';
import { Cell, CellGroup } from 'vant';
import { Loading } from 'vant';
import { PullRefresh } from 'vant';
import store from './store';

Vue.use(PullRefresh);
Vue.use(Loading);
Vue.use(Cell);
Vue.use(CellGroup);
Vue.use(List);
Vue.use(Skeleton);
Vue.use(Button);
Vue.config.productionTip = false


import engine from "@zkty-team/x-engine-core"
Vue.prototype.engine = engine;
Vue.prototype.headerHeight = engine.api("com.zkty.jsi.device", "getNavigationHeight")

import ZKTYHeader from '@zkty-team/x-engine-header';
import "@zkty-team/x-engine-header/lib/ZKTYHeader.css"
Vue.use(ZKTYHeader);


Vue.prototype.$store = store
new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')
