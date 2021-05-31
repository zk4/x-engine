# Vuex

## 支持所有vuex的功能(包括辅助函数)

> 安装方式

```
npm install @zkty-team/vuex
```
> 使用 例:
```javascript
// 在store/index.js
import Vue from 'vue';
import Vuex from '@zkty-team/vuex'
import user from './modules/user'

Vue.use(Vuex)

const store = new Vuex.Store({
  modules: {
    user
  }
})


export default store


// module/user.js
const api_func = function () {
  return new Promise(resolve => {
    // setTimeout(() => {

    resolve({
      name: 'capricorn',
      address: '望京'
    })
    // }, 1000)
  })
}
const state = {
  user: {
    name: 'ws',
    address: '天通苑'
  }
}
const mutations = {
  CHANGE_USER (state, user) {
    state.user = user
  }
}
const actions = {
  changeUser ({ commit }) {
    api_func().then((user) => {
      if (this.state.user.user.name === 'capricorn') {
        commit('CHANGE_USER', {
          name: 'ws',
          address: '天通苑'
        })
      } else {
        commit('CHANGE_USER', {
          name: 'capricorn',
          address: '望京'
        })
      }
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions,
}

```
```vue
<template>
  <div>
    <div>{{userInfo.name}}</div>
    <div>{{userInfo.address}}</div>
    <button @click='changeUser'>修改name</button>
  </div>
</template>

<script>
// user.vue
import { mapState, mapActions } from "@zkty-team/vuex";
export default {
  computed: mapState({
    userInfo: (state) => {
      console.log();
      return state.user.user;
    },
  }),
  mounted() {
    console.log(this.$store);
  },
  methods: {
    ...mapActions("user", ["changeUser"]),
    changeUser() {
      this.$store.dispatch("user/changeUser", { id: 1 });
    },
  },
};
</script>

<style>
</style>
```