import Vue from 'vue';
import Vuex from "@zkty-team/vuex";
Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    count: 0
  },
  mutations: {
    setCount(state) {
      state.count++;
    }
  },
  actions: {},
  modules: {}
})

export default store
