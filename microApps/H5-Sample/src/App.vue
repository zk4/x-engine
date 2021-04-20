<template>
  <div id="app">
    <ZKTY-Header v-if="!isShowHeader" @leftButton="handlerBack"></ZKTY-Header>
    <router-view :style="style" />
  </div>
</template>

<script>
export default {
  name: "App",
  data() {
    return {
      navTitle: "app",
      bgImg: "",
      bgColor: "",
      isShowHeader: false,
      navigatorHeight: this.headerHeight,
    }
  },
  computed: {
    style() {
      var style = `margin-top:${this.navigatorHeight}px;`
      return style
    },
  },
  methods: {
    // 返回
    handlerBack() {
      // 返回指定页面
      if (this.$route.meta.backPath != undefined) {
        var path = this.$route.meta.backPath
        this.$router.go(path)
      } else {
        // 返回上一页
        this.$router.go(-1)
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
.bounce-enter-active {
  animation: bounce-in 0.5s;
}
.bounce-leave-active {
  animation: bounce-in 0.5s reverse;
}
@keyframes bounce-in {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
  }
}
</style>
