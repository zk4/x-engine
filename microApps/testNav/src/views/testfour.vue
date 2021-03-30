<template>
  <div class="testtwo-class">
    <div>four page</div>
    <div style="margin: 20px">
      <van-button
        style="margin-top: 10px"
        round
        block
        type="primary"
        native-type="submit"
      >占位按钮</van-button>
      <van-button
        style="margin-top: 10px"
        round
        block
        type="primary"
        native-type="submit"
        @click="handlerH5Back"
      >H5 &lt;-- 返回</van-button>
      <van-button
        style="margin-top: 10px"
        round
        block
        type="info"
        native-type="submit"
      >占位按钮</van-button>
      <van-button
        style="margin-top: 10px"
        round
        block
        type="info"
        native-type="submit"
        @click="handlerNativeBack"
      >原生 &lt;-- 返回</van-button>

      <van-button
        style="margin-top: 10px"
        round
        block
        type="info"
        native-type="submit"
        @click="handlerNativeBakTwoPage"
      >原生 &lt;-- 返回 two page</van-button>
      <van-button
        style="margin-top: 10px"
        round
        block
        type="info"
        native-type="submit"
        @click="handlerNativeBakOnePage"
      >原生 &lt;-- 返回 one page</van-button>
    </div>
  </div>
</template>

<script>
import nativeNav from "@zkty-team/x-engine-module-nav"
export default {
  methods: {
    // 显示原生导航条
    handlerShowNav() {
      nativeNav.setNavBarHidden({
        isHidden: false,
        isAnimation: true,
      })
    },

    // 隐藏原生导航条
    handlerHiddenNav() {
      nativeNav.setNavBarHidden({
        isHidden: true,
        isAnimation: true,
      })
    },
    // h5返回上一页
    handlerH5Back() {
      this.$router.go(-1)
    },
    // 原生返回上一页
    handlerNativeBack() {
      nativeNav.navigatorBack({
        url:"/testthree",
        hideNavbar:true
      })
    },
    // 原生返回第二页
    handlerNativeBakTwoPage() {
      nativeNav.navigatorBack({
        url:'/testtwo',
      })
    },
    // 原生返回第一页
    handlerNativeBakOnePage() {
      nativeNav.navigatorBack({
        url:"0",
      })
    }
  },
}
</script>

<style>
.testtwo-class {
  margin-top: 100px;
}
</style>
