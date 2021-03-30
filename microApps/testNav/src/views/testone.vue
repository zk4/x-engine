<template>
  <div class="testone-class">
    <div>one</div>
    <div style="margin: 20px">
      <van-button
        round
        block
        type="primary"
        style="margin-top: 10px"
        native-type="submit"
        @click="handlerH5NextPage"
      >h5 --> two</van-button>

    <div style="margin: 16px;">
      <van-button type="primary" round block @click="triggerbroad">broadcast</van-button>
    </div>

      <van-button
        type="info"
        round
        block
        style="margin-top: 10px"
        native-type="submit"
        @click="handlerNaviteNextPage"
      >nati-->two</van-button>

      <van-button
        type="warning"
        round
        block
        style="margin-top: 10px"
        native-type="submit"
        @click="handlerShowNav"
      >显示导航条</van-button>

      <van-button
        type="warning"
        round
        block
        style="margin-top: 10px"
        native-type="submit"
        @click="handlerSetNavTitle"
      >设置导航条文字</van-button>

      <van-button
        type="warning"
        round
        block
        style="margin-top: 10px"
        native-type="submit"
        @click="handlerHiddenNav"
      >隐藏导航条</van-button>
    </div>
  </div>
</template>

<script>
import nativeNav from "@zkty-team/x-engine-module-nav"
/*import nativeRouter from "@zkty-team/x-engine-module-router"*/
import engine from "@zkty-team/x-engine-module-engine"
export default {
  data() {
    return {
    }
  },
  mounted() { },
  methods: {
  triggerbroad(){

      engine.bridge.call('com.zkty.jsi.broadcast.trigger',{
      source: '2',
      },function(){
      })
  
  },
    // h5跳转
    handlerH5NextPage() {
      this.$router.push({
        path: "/testtwo"
      })
    },
    // 原生跳转
    handlerNaviteNextPage() {
      engine.bridge.call('com.zkty.jsi.direct.push',{
        scheme: "microapp",
        uri: "com.gm.microapp.mine",
        pathname: "/testtwo",
        hideNavbar: true,
      },function(){})
      /*nativeRouter.openTargetRouter({*/
        /*type: "microapp",*/
        /*uri: "com.gm.microapp.mine",*/
        /*path: encodeURI(`/testtwo`),*/
        /*hideNavbar: true,*/
      /*})*/
    },
    // 显示原生导航条
    handlerShowNav() {
      nativeNav.setNavBarHidden({
        isHidden: false,
        isAnimation: true,
      })
    },
    // 设置导航条文字
    handlerSetNavTitle() {
      nativeNav.setNavTitle({
        title: "测试文字",
        titleColor: "#DB7093", // 默认黑色
        titleSize: 16, // 默认16
      })
    },
    // 隐藏原生导航条
    handlerHiddenNav() {
      nativeNav.setNavBarHidden({
        isHidden: true,
        isAnimation: true,
      })
    },
  },
}
</script>

<style scoped>
.testone-class {
  margin-top: 100px;
}
.request-class1 {
  width: 100%;
  height: 44px;
  background-color: blue;
  line-height: 44px;
  color: white;
  font-weight: 600;
}
.request-class {
  width: 100%;
  height: 44px;
  background-color: pink;
  line-height: 44px;
  color: white;
  font-weight: 600;
}
</style>
