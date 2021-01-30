import Vue from 'vue'
import Vuex from 'vuex'
import * as actions from './actions'
import getters from './getters'
import state from './state'
import mutations from './mutations'
import user from './module/user';
import createLogger from 'vuex/dist/logger'

Vue.use(Vuex)
const debug = process.env.NODE_ENV !== 'production'

const store = new Vuex.Store({
  modules: {
    user,
  },
  getters,
  actions,
  state: state,
  mutations: mutations,
  strict: false,
  plugins: debug ? [createLogger()] : []
})
export default store
// export default new Vuex.Store({
//   user,
//   state: state,
//   mutations: mutations,
//   getters,
//   actions: actions,
//   strict: false,
//   plugins: debug ? [createLogger()] : []
// })