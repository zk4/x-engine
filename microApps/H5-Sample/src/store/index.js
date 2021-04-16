import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
    state: {
        count: 0
    },
    mutations: {
        jia(state) {
            state.count++
        },
        jian(state) {
            state.count--
        }
    },
    actions: {
    }
})

export default store