<template>
  <div id="app">
    <HEADER ref="globalHeader" @leftButton="handlerBack" :title="navTitle" :bgImage="bgImg"></HEADER>
    <router-view :style="style" />
  </div>
</template>

<script>
import HEADER from "@/components/Header/index"
export default {
  name: "App",
  components: {
    HEADER,
  },
  data() {
    return {
      navigatorHeight: this.headerHeight,
      navTitle: "app",
      bgImg: "",
    }
  },
  computed: {
    style() {
      var style = `margin-top:${this.navigatorHeight}px;`
      return style
    },
  },
  methods: {
    handlerBack() {
      if (this.$route.meta.type) {
        this.$router.go(this.$route.meta.type)
      } else {
        this.$router.go(-1)
      }
    },
  },
  watch: {
    $route(to) {
      this.navTitle = to.meta.title
      if (to.meta.customBgcImg) {
        this.bgImg = to.meta.customBgcImg
      } else {
        this.bgImg = ""
      }
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
.content {
}
</style>
