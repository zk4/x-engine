<template>
  <div class="testone-class">
    <div style="height:100px;"></div>
    <van-button type="primary" size="large" round @click="handlerPush">下一页</van-button>
    <van-button type="info" size="large" round @click="handlerBack">上一页</van-button>
    <van-button
      type="danger"
      size="large"
      round
      color="#7232dd"
      @click="handlerOpenMicroApp"
    >跳转其他微应用</van-button>
    <van-button type="danger" size="large" round color="#322144" @click="handlerOpenBaidu">跳转http 百度</van-button>
    <van-button size="large" round color="#dda0dd" @click="handlerOpenYoutube">跳转https youtube 需翻墙</van-button>
  </div>
</template>

<script>
export default {
  data() {
    return {}
  },
  mounted() {
    /* console.log('windowwindowwindow._dswk', window._dswk) */
    // console.log("testOnePage-->mounted")
    // this.$engine.api("com.zkty.jsi.dev", "log", "onepage-mounted")
  },
  destroyed() {
    // console.log("testOnePage-->destroyed")
    // this.$engine.api("com.zkty.jsi.dev", "log", "onepage-destroyed")
  },
  methods: {
    onWebviewShow(){
      alert("testone-->onWebviewShow")
      this.$engine.api("com.zkty.jsi.dev", "log", "testone-ononWebviewShow")
    },
    onNativeShow() {
      alert("testone-->onNativeShow")
      this.$engine.api("com.zkty.jsi.dev", "log", "testone-onNativeShow")
    },
    onNativeShow() {
      alert("testone-->onNativeShow")
      this.$engine.api("com.zkty.jsi.dev", "log", "testone-onNativeShow")
    },
    onNativeHide() {
      console.log("testone-->onNativeHide")
      this.$engine.api(
        "com.zkty.jsi.dev",
        "log",
        "testone-->onNativeHide"
      )
    },
    onNativeDestroyed() {
      console.log("testone-->onNativeDestroyed")
      this.$engine.api(
        "com.zkty.jsi.dev",
        "log",
        "testone-->onNativeDestroyed"
      )
    },
    handlerPush() {
      this.$router.push({
        name: "testtwo",
        query: {
          changeNavTitle: "第二页"
        },
        params: {
          id: 1,
          age: 18,
          name: "中文",
        },
      })
    },
    handlerBack() {
      this.$router.go(-1)
    },
    handlerOpenMicroApp() {
      this.$engine.api(
        "com.zkty.jsi.direct",
        "push",
        {
          scheme: "microapp",
          host: "com.gm.microapp.home",
          pathname: "",
          fragment: "",
          params: {
            hideNavbar: true,
          },
        },
        function (res) {
          // console.log("res :>> ", res)
        }
      )
    },
    handlerOpenBaidu() {
      this.$engine.api(
        "com.zkty.jsi.direct",
        "push",
        {
          scheme: "http",
          host: "www.baidu.com",
          pathname: "",
          fragment: "",
          params: {
            hideNavbar: true,
          },
        },
        function (res) {
          // console.log("res :>> ", res)
        }
      )
    },
    // https
    handlerOpenYoutube() {
      this.$engine.api(
        "com.zkty.jsi.direct",
        "push",
        {
          scheme: "https",
          host: "www.youtube.com",
          pathname: "",
          fragment: "",
          params: {
            hideNavbar: true,
          },
        },
        function (res) {
          // console.log("res :>> ", res)
        }
      )
    },
  },
}
</script>

<style scoped>
.testone-class {
  margin: 0 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
