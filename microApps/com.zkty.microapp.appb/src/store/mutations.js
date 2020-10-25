import * as types from './mutation-types'

const mutations = {
    [types.SET_U](state, n) {
        state.user = n
    },
    [types.SET_TOPICCOUNT](state, n) {
        state.topiccount = n
    },
    [types.SET_USERTOPIC](state, n) {
        state.usertopic = n
    },
    [types.SET_USERCOLLECT](state, n) {
        state.usercollect = n
    },
    [types.SET_USERREPLY](state, n) {
        state.userreply = n
    },
    [types.SET_USERREPLYFABULOUS](state, n) {
        state.userreplyfabulous = n
    },
    [types.SET_ACTIVE](state, n) {
        state.active = n
    },
}
export default mutations