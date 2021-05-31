<!--
 * @Author: sheng.wang
 * @Date: 2021-05-20 14:20:45
 * @LastEditTime: 2021-05-28 19:24:10
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/microApps/H5-Sample/src/App.vue
-->
<template>
  <div id="app">
    <Header  />
    <router-view :style="style" />
  </div>
</template>

<script>
export default {
  name: "App",
  data() {
    return {}
  },
  created() {
    console.log('this', this.$engine)
  },
  computed: {
    style() {
      return this.$engine.platform.isPc
        ? `margin-top:${64}px;`
        : `margin-top:${
            Number(this.$navigatorHeight) + Number(this.$statusHeight)
          }px;`
    },
  },
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
