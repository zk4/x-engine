import Vue from "vue";
import Vuex from "vuex";
import createNotice from './create-notice.js'

Vue.use(Vuex);

export default new Vuex.Store({
  modules:{
    createNotice,
  }
});
