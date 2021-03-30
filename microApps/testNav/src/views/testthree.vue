<template>
  <div class="testtwo-class">
    <div>three page</div>
    <div>{{pushInfo}}</div>
    <div style="margin: 20px">
      <van-button
        round
        block
        type="primary"
        style="margin-top: 10px"
        native-type="submit"
        @click="handlerH5NextPage"
      >h5 --> four</van-button>
      <van-button
        style="margin-top:10px"
        round
        block
        type="primary"
        native-type="submit"
        @click="handlerH5Back"
      >h5 &lt;-- 返回</van-button>

      <van-button
        round
        block
        type="info"
        style="margin-top: 10px"
        native-type="submit"
        @click="handlerNaviteNextPage"
      >navive-->four</van-button>
      <van-button
        style="margin-top:10px"
        round
        block
        type="info"
        native-type="submit"
        @click="handlerNativeBack"
      >原生 &lt;-- 返回</van-button>
    </div>
  </div>
</template>

<script>
import nativeNav from "@zkty-team/x-engine-module-nav"
export default {
  data() {
    return {
      pushInfo: "",
    }
  },
  mounted() {
    this.pushInfo = this.$route.query;
  },
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
    // h5跳转下一页
    handlerH5NextPage() {
      this.$router.push({
        path: "/testfour",
      })
    },
    // 原生跳转下一页
    handlerNaviteNextPage() {
      nativeNav.navigatorPush({
        url: "/testfour",
        hideNavbar: true,
        params: encodeURI(`id:100`),
      })
    },
    // h5返回
    handlerH5Back() {
      this.$router.go(-1)
    },
    // h5 返回
    handlerNativeBack() {
      nativeNav.navigatorBack({
        url: "/testtwo",
        hideNavBar: true,
      })
    },
  },
}
</script>

<style>
.testtwo-class {
  margin-top: 100px;
}
</style>
