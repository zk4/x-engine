import Vue from "vue";
import App from "./App.vue";
import router from './router'
import store from './store'
import lifeCycle from "@zkty-team/x-engine-lifecycle";
Vue.use(lifeCycle);
Vue.config.productionTip = false;

Vue.prototype.$store = store

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
