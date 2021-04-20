<template>
  <div class="testthree-class" :style="{marginTop:navigatorHeight+'px'}">
    <van-button type="primary" size="large" round @click="handlerPush">下一页</van-button>
    <van-button type="info" size="large" round @click="handlerBack">上一页</van-button>
  </div>
</template>

<script>
import XEngine from "@zkty-team/x-engine-core"
export default {
  data() {
    return {
      navigatorHeight: "",
    }
  },
  created() {
    let navheight = XEngine.api("com.zkty.jsi.device", "getNavigationHeight")
    this.navigatorHeight = navheight
  },
  methods: {
    handlerPush() {
      this.$router.push({
        path: "/testfour",
      })
    },
    handlerBack() {
      this.$router.go(-1)
    },
  },
}
</script>

<style scoped>
.testthree-class {
  margin: 0 20px 20px 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
