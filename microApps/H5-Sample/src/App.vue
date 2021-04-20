<template>
  <div id="app">
    <HEADER
      v-if="!isShowHeader"
      :title="navTitle"
      :bgImage="bgImg"
      :bgColor="bgColor"
      @leftButton="handlerBack"
    ></HEADER>
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

  watch: {
    $route(to) {
      // 文字
      if (to.meta.title) {
        if (to.query.changeNavTitle) {
          this.navTitle = to.query.changeNavTitle
        } else {
          this.navTitle = to.meta.title
        }
      } else {
        this.navTitle = ""
      }

      // 图片
      if (to.meta.customBgcImg) {
        this.bgImg = to.meta.customBgcImg
      } else {
        this.bgImg = ""
      }

      // 背景色
      if (to.meta.bgColor) {
        this.bgColor = to.meta.bgColor
      } else {
        this.bgColor = ""
      }

      // 是否显示header
      if (to.meta.isShowHeader == undefined) {
        this.isShowHeader = false
      } else {
        this.isShowHeader = to.meta.isShowHeader
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
