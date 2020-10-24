import Vue from 'vue'
import App from './App.vue'
import router from './router/index'
import Vconsole from 'vconsole'

import { Form } from 'vant'
import { Button } from 'vant'
import { Field } from 'vant';
import { PullRefresh } from 'vant';

Vue.use(PullRefresh);
Vue.use(Form);
Vue.use(Button);
Vue.use(Field);

let vConsole = new Vconsole()
Vue.use(vConsole)

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
