<template>
  <div class="testone-class">
    <div style="marginTop:50px">设置导航条</div>
    <van-button type="info" size="large" round @click="handlerShowNav">显示导航条</van-button>
    <van-button type="warning" size="large" round @click="handlerChangeNavTitle">修改导航条文字</van-button>
    <van-button type="danger" size="large" round @click="handlerHiddenNav">隐藏导航条</van-button>
  </div>
</template>

<script>
import XEngine from "@zkty-team/x-engine-core"
export default {
  data() {
    return {}
  },
  methods: {
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
