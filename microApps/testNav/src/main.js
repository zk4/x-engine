import Vue from 'vue'
import App from './App.vue'
import router from './router'
import 'vant/lib/index.less';


import { Collapse, CollapseItem } from 'vant';
import { Button } from 'vant'
Vue.use(Button);
Vue.use(Collapse);
Vue.use(CollapseItem);


Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
