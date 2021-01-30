import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

import { Form } from 'vant';
import { List } from "vant";
import { Card } from "vant";
import { Field } from 'vant';
import { Popup } from 'vant';
import { Picker } from 'vant';
import { Switch } from 'vant';
import { Uploader } from 'vant';
import { Tab, Tabs } from 'vant';
import { Cell, CellGroup } from "vant";
import { RadioGroup, Radio } from 'vant';
import { DropdownMenu, DropdownItem } from 'vant';
import { Toast } from 'vant';


Vue.use(Tab);
Vue.use(Form);
Vue.use(Card);
Vue.use(List);
Vue.use(Cell);
Vue.use(Tabs);
Vue.use(Popup);
Vue.use(Toast);
Vue.use(Radio);
Vue.use(Field);
Vue.use(Picker);
Vue.use(Switch);
Vue.use(Uploader);
Vue.use(CellGroup);
Vue.use(RadioGroup);
Vue.use(DropdownMenu);
Vue.use(DropdownItem);

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount("#app");
