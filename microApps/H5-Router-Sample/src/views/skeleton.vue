<template>
  <div>
    <HEADER
      @clickLeftButton="handlerHeaderBack"
      @clickRightButton="handlerHeaderRightBtn"
      :reviceNavTitle=navTitle
    />
    <div :style="{marginTop:navigatorHeight+'px'}">
      <div style="margin-top:30px;" v-show="skeletonShow">
        <van-skeleton title avatar round animate :row="3" />
      </div>
    </div>
  </div>
</template>

<script>
import HEADER from "../components/Header/index"
import device from "@zkty-team/x-engine-module-device"
export default {
  components: {
    HEADER,
  },
  data() {
    return {
      navTitle:'骨架屏',
      skeletonShow: true,
      navigatorHeight: "",
    }
  },
  mounted() {
    // 导航条高度
    device.getNavigationHeight({}).then((res) => {
      this.navigatorHeight = res.content
    })
    setTimeout(() => {
      this.skeletonShow = false
    }, 50000)
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