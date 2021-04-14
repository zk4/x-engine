<template>
  <div>
    <HEADER
      @clickLeftButton="handlerHeaderBack"
      @clickRightButton="handlerHeaderRightBtn"
      :reviceNavTitle="navTitle"
    />
    <div :style="{marginTop:navigatorHeight+'px'}">
      <div style="margin-top:30px;" v-show="skeletonShow">
        <van-skeleton title avatar round animate :row="3" />
      </div>

      <div style="margin-top:50px;" v-show="!skeletonShow">
        <div>老子出现了</div>
      </div>
    </div>

    <div class="content">store中的count为:{{$store.state.count}}</div>
  </div>
</template>

<script>
import HEADER from "../components/Header/index"
import XEngine from "@zkty-team/x-engine-core"
export default {
  components: {
    HEADER,
  },
  data() {
    return {
      navTitle: "骨架屏",
      skeletonShow: true,
      navigatorHeight: "",
    }
  },
  mounted() {
    let navHeight = XEngine.api("com.zkty.jsi.device", "getNavigationHeight")
    this.navigatorHeight = navHeight
    setTimeout(() => {
      this.skeletonShow = false
    }, 3000)
  },
  methods: {
    handlerHeaderBack() {
      this.$router.go(-1)
    },
    handlerHeaderRightBtn() {
      alert("点击的了右上角按钮")
    },
    handlerNextpage() {
      this.$router.push({
        path: "/navHeader",
      })
    },
  },
}
</script>

<style>
.skeleton-class {
  margin-top: 20px;
}
</style>