/*
 * @Author: sheng.wang
 * @Date: 2021-05-14 15:09:34
 * @LastEditTime: 2021-06-01 21:40:13
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/microApps/H5-Sample/src/store/index.js
 */
import Vue from 'vue'
import Vuex from '@zkty-team/vuex'

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
