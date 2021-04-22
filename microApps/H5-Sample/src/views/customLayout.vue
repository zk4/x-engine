<template>
  <div>
    <div class="box-class">
      <div class="ok-class" :style="{marginTop:navigatorHeight+'px'}">
        <div>width:100px;</div>
        <div>height:200px;</div>
        <div>margin-top:{{navigatorHeight}}px;</div>
      </div>
    </div>
    <div style="color:#f82a41;">红色为正常的布局</div>
    <div style="color:#f82a41;">导航条距离顶部的距离为: {{navigatorHeight}} px</div>
    <div style="color:gray;">灰色的部分高度被导航条覆盖, 原因见下:</div>

    <div style="textAlign:left; margin:50px;">
      <span style="color:orange">Tip:</span>
      <br />1. 因为H5自定义的导航条需要固定在屏幕上方;
      <br />2. 当页面内容超出屏幕的高度时;
      <br />3. 不能随着内容的的上下滚动而滚动;
      <br />
      <span style="color:orange">4. 上方可见灰色div的的x轴和y轴会在手机的左上角原点, x=0 y=0</span>
      <br />5. HEADER用了postion:fiexd; top:0; 脱离了文档流; 所以被导航条覆盖;
      <br />6.为了适配iOS手机和安卓手机;
      <br />
      <span
        style="color:orange"
      >7. 需要调用@zkty-team/x-engine-core的getNavigationHeight()方法拿到导航条在不同手机上的高度给予div的margin-top; 如红色div。即可解决该问题</span>
      <br />8. 详见代码...
    </div>
  </div>
</template>

<script>
import XEngine from "@zkty-team/x-engine-core";
export default {
  data() {
    return {
      navigatorHeight: "",
      navTitle: "layout",
      navRightTitle: "屏幕高度",
    }
  },
  methods: {
    handlerHeaderBack() {
      this.$router.go(-1)
    },
    handlerHeaderRightBtn() {
      let screenHeight = XEngine.api(
        "com.zkty.jsi.device",
        "getScreenHeight"
      )
      alert("屏幕整体高度为: ==>" + screenHeight + "px");
    },
  },
}
</script>

<style>
.box-class {
  display: flex;
}
.error-class {
  width: 100px;
  height: 200px;
  background-color: gray;
  color: white;
}

.ok-class {
  width: 100px;
  height: 200px;
  background-color: red;
  color: white;
}
</style>