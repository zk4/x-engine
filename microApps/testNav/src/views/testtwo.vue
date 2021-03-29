<template>
  <div class="testtwo-class">
    <div>two page</div>
    <div style="margin: 20px;">
      <van-button
        round
        block
        type="primary"
        style="margin-top: 10px"
        native-type="submit"
        @click="handlerH5NextPage"
      >h5 --> three</van-button>

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
      >navive-->three</van-button>

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
    return {}
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
        path: "/testthree",
        // query: {
        //   id: 1,
        //   name: "name",
          // content: {
          //   title: "2级dict",
          // },
        // },
        // params: {
        //   id : 1,
        //   name : 'cwz',
        //   content: {
        //     title:'2级dict'
        //   }
        // }
        query: encodeURI(`id=1&name=cwz&height=18`),
      })
    },
    // native跳转下页
    handlerNaviteNextPage() {
      nativeNav.navigatorPush({
        url: "/testthree",
        hideNavbar: true,
        params: encodeURI(`id:100`),
      })
    },
    // h5返回
    handlerH5Back() {
      this.$router.go(-1)
    },
    // native返回
    handlerNativeBack() {
      nativeNav.navigatorBack({
        url: "/testone",
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
