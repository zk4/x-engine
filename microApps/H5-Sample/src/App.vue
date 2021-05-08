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
      let style
      if (this.$engine.platform.isPhone) {
        style = `margin-top:${this.$navigatorHeight}px;`
      } else if (this.$engine.platform.isAndroid) {
        let height = Number(this.$navigatorHeight) + Number(this.$statusHeight)
        style = `margin-top:${height}px;`
      } else if (this.$engine.platform.isPc) {
        style = `margin-top:${64}px;`
      }
      return style
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
