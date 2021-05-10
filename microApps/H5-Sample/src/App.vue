<template>
  <div id="app">
    <ZKTY-Header />
    <router-view :style="style" />
  </div>
</template>

<script>
export default {
  name: "App",
  data() {
    return {}
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
