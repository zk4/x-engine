<template>
  <div>
    <HEADER
      :reviceNavTitle="navTitle"
      @clickLeftButton="handlerHeaderBack"
    />

    <div style="margin: 100px 0 50px 0">
        <div class="mainText">x-engine-core</div>
        <div class="fuText">- isHybrid (判断平台)</div>
        <div class="fuText">- api (通过传入模块名称和方法名称来调用原生的方法)</div>
        <div class="mainText">x-engine-jsi-ui</div>
        <div class="fuText">- setNavTitle (设置原生导航条文字)</div>
        <div class="fuText">- setNavBarHidden (是否隐藏原生导航条)</div>
        <div class="mainText">x-engine-jsi-direct</div>
        <div class="fuText">- push (根据scheme来判断跳转的位置)</div>
        <div class="fuText">- go   (根据scheme来判断返回的位置)</div>
        <div class="fuText">- 为了方便前端开发,开发人员只需要调用</div>
        <div class="fuText">- this.$router.push</div>
        <div class="fuText">- this.$router.go</div>
        <div class="mainText">x-engine-jsi-deveice</div>
        <div class="fuText">- callPhone (打电话)</div>
        <div class="fuText">- sendMessage (发信息)</div>
        <div class="fuText">- getDeviceInfo (获取设备信息)</div>
        <div class="fuText">- getStatusBarHeight (获取原生状态栏高度)</div>
        <div class="fuText">- getNavigationHeight (获取原生导航条高度)</div>
        <div class="fuText">- getScreenHeight (获取原生屏幕高度)</div>
        <div class="fuText">- getTabbarHeight (获取原生tabbar高度)</div>
        <div class="fuText">- setNavTitle (设置原生导航条文字)</div>
        <div class="fuText">- setNavBarHidden (是否隐藏原生导航条)</div>
        <div class="fuText">- setNavTitle (设置原生导航条文字)</div>
        <div class="fuText">- setNavBarHidden (是否隐藏原生导航条)</div>
        <div class="mainText">x-engine-jsi-store</div>
        <div class="fuText">- set (全局任一位置存数据) </div>
        <div class="fuText">- get (全局任一位置取数据)</div>
    </div>
  </div>
</template>

<script>
import HEADER from "@/components/Header/index"
export default {
  components: {
    HEADER,
  },
  data() {
    return {
      navTitle: "模块介绍",
      marginTop :0
    }
  },
  methods: {
    handlerHeaderBack() {
        this.$router.go(-1)
    },
  },
}
</script>

<style>
.mainText{
  text-align: left;
  margin: 0 20px;
  font-size: 25px;
  font-weight: 600;
}

.fuText {
  text-align: left;
  margin: 0 30px;
  font-size: 16px;
  color: orangered;
}
</style>