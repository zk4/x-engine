<template>
  <div class="testfour-class" :style="{marginTop:navigatorHeight+'px'}">
    <van-button type="primary" size="large" round @click="handlerBack">上一页 -1</van-button>
    <van-button type="info" size="large" round @click="handlerBackTwoPage">返回第二页 -2</van-button>
    <van-button type="warning" size="large" round @click="handlerBackIndex">返回微应用首页 /</van-button>
    <van-button type="info" size="large" round @click="handlerPATH">返回指定path /testtwo</van-button>
    <van-button type="danger" size="large" round @click="handlerAPPHOME">返回原生App首页 0</van-button>
  </div>
</template>

<script>
import XEngine from "@zkty-team/x-engine-core"
export default {
  data() {
    return {
      navHeader: "123",
      navigatorHeight: "",
    }
  },
  created() {
    let navheight = XEngine.api("com.zkty.jsi.device", "getNavigationHeight")
    this.navigatorHeight = navheight
  },
  methods: {
    handlerBack() {
      this.$router.go(-1)
    },
    handlerBackTwoPage() {
      this.$router.go(-2)
    },
    handlerBackIndex() {
      this.$router.go("/")
    },
    handlerPATH() {
      this.$router.go("/testtwo")
    },
    handlerAPPHOME() {
      this.$router.go(0)
    },
  },
}
</script>

<style scoped>
.testfour-class {
  margin: 0 20px 20px 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
