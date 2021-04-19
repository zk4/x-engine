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
import store from './store'

Vue.use(PullRefresh);
Vue.use(Loading);
Vue.use(Cell);
Vue.use(CellGroup);
Vue.use(List);
Vue.use(Skeleton);
Vue.use(Button);
Vue.config.productionTip = false


Vue.prototype.$store = store
new Vue({
  router,
  store,
  render: h => h(App),
}).$mount('#app')
