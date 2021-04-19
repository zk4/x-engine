<template>
  <div class="testone-class" :style="{marginTop:navigatorHeight+'px'}">
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
import XEngine from "@zkty-team/x-engine-core"
export default {
  data() {
    return {
      navTitle: "第一页",
      navigatorHeight: "",
    }
  },
  created() {
    let navheight = XEngine.api("com.zkty.jsi.device", "getNavigationHeight")
    this.navigatorHeight = navheight
  },
  methods: {
    handlerPush() {
      this.$router.push({
        path: "/testtwo",
        query: {
          id: 1,
          age: 18,
          name: "中文",
        },
      })
    },
    handlerBack() {
      this.$router.go(-1)
    },

    // scheme tip:
    // file
    // omp
    // http
    // https
    // microapp
    handlerOpenMicroApp() {
      // if (XEngine.isHybrid()) {
      XEngine.api(
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
          console.log("res :>> ", res)
        }
      )
      // } else {
      //   alert("请在app端测试该功能.")
      // }
    },
    handlerOpenBaidu() {
      // if (XEngine.isHybrid()) {
      XEngine.api(
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
          console.log("res :>> ", res)
        }
      )
      // } else {
      //   alert("请在app端测试该功能.")
      // }
    },
    // https
    handlerOpenYoutube() {
      // if (XEngine.isHybrid()) {
      XEngine.api(
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
          console.log("res :>> ", res)
        }
      )
      // } else {
      //   alert("请在app端测试该功能.")
      // }
    },
  },
}
</script>

<style scoped>
.testone-class {
  margin: 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
