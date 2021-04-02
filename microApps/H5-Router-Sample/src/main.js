import Vue from 'vue';
import App from './App.vue';
import router from './router';
import 'vant/lib/button/style';
import Button from 'vant/lib/button';
import { Skeleton } from 'vant';

Vue.use(Skeleton);
Vue.use(Button);
Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
