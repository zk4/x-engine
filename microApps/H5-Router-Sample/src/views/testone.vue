<template>
  <div class="testone-class">
    <div style="marginTop:50px">第1页</div>
    <van-button type="primary" size="large" round @click="handlerPush">下一页</van-button>
    <van-button type="info" size="large" round @click="handlerShowNav">显示导航条</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="danger" size="large" round @click="handlerHiddenNav">隐藏导航条</van-button>
    <van-button
      type="danger"
      size="large"
      round
      color="#7232dd"
      @click="handlerOpenMicroApp"
    >跳转其他微应用</van-button>
    <van-button type="danger" size="large" round color="#322144" @click="handlerOpenBaidu">百度</van-button>
    <van-button type="danger" size="large" round color="#dda0dd" @click="handlerSkeleton">骨架屏</van-button>
    <van-button type="danger" size="large" round color="#2695e3" @click="handlerNavigator">前端定制navigator</van-button>
    <van-button type="danger" size="large" round color="#dda0dd" @click="handlerGIF">GIF进入页面</van-button>
  </div>
</template>

<script>
import XEngine from "@zkty-team/x-engine-module-engine"
export default {
  data() {
    return {}
  },
  methods: {
    handlerPush() {
      this.$router.push({
        path: "/testtwo",
        query: {
          id: 1,
          age: 18,
        },
      })
    },
    handlerShowNav() {
      if (XEngine.isHybrid()) {
        XEngine.bridge.call(
          "com.zkty.jsi.ui.setNavBarHidden",
          {
            isHidden: false,
            isAnimation: true,
          },
          function (res) {
            console.log("res :>> ", res)
          }
        )
      } else {
        alert("请在app端测试该功能.")
      }
    },
    handlerChangeNavTitle() {
      if (XEngine.isHybrid()) {
        XEngine.bridge.call(
          "com.zkty.jsi.ui.setNavTitle",
          {
            title: "哦哦哦",
            titleColor: "#f21811",
            titleSize: 18,
          },
          function (res) {
            console.log("res :>> ", res)
          }
        )
      } else {
        alert("请在app端测试该功能.")
      }
    },
    handlerHiddenNav() {
      if (XEngine.isHybrid()) {
        XEngine.bridge.call(
          "com.zkty.jsi.ui.setNavBarHidden",
          {
            isHidden: true,
            isAnimation: true,
          },
          function (res) {
            console.log("res :>> ", res)
          }
        )
      } else {
        alert("请在app端测试该功能.")
      }
    },

    // scheme tip:
    // omp
    // http
    // https
    // microapp

    handlerOpenMicroApp() {
      if (XEngine.isHybrid()) {
        XEngine.bridge.call(
          "com.zkty.jsi.direct.push",
          {
            scheme: "microapp",
            host: "com.gm.microapp.mine",
            pathname: "",
            fragment:"",
            params: {
              hideNavbar: true,
            },
          },
          function (res) {
            console.log("res :>> ", res)
          }
        )
      } else {
        alert("请在app端测试该功能.")
      }
    },
    handlerOpenBaidu() {
      if (XEngine.isHybrid()) {
        XEngine.bridge.call(
          "com.zkty.jsi.direct.push",
          {
            scheme: "http",
            host: "www.baidu.com",
            fragment:"/",
            pathname: "",
            params: {
              hideNavbar: true,
            },
          },
          function (res) {
            console.log("res :>> ", res)
          }
        )
      } else {
        alert("请在app端测试该功能.")
      }
    },
    handlerGIF() {
      this.$router.push({
        path:"/gifView"
      })
    },

    handlerSkeleton () {
      this.$router.push({
        path:"/skeleton"
      })
    },

    handlerNavigator()  {
      this.$router.push({
        path:"/navHeader1"
      })
    }
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
