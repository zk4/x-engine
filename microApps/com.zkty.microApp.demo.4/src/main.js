import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

import { List } from "vant";
import { Cell, CellGroup } from "vant";
import { Card } from "vant";
import { Icon } from 'vant';
import { Loading } from 'vant';



Vue.use(Card);
Vue.use(List);
Vue.use(Cell);
Vue.use(CellGroup);
Vue.use(Loading);
Vue.use(Icon);


Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
