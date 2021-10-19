<template>
  <div class="testthree-class">
    <van-button type="primary" size="large" round @click="handlerPush">下一页</van-button>
    <van-button type="primary" size="large" round @click="pushAndDelete">下一页（删除当前页）</van-button>
    <van-button type="info" size="large" round @click="handlerBack">上一页</van-button>
  </div>
</template>

<script>
export default {
  data() {
    return {
    }
  },
  methods: {
      onNativeShow() {
      console.log("three: three-->onNativeShow")
      this.$engine.api("com.zkty.jsi.dev", "log", "three-onNativeShow")
    },
    onWebviewShow(){
      console.log("three: onWebviewShow")
      this.$engine.api("com.zkty.jsi.dev", "log", "onWebviewShow")

    },
    onNativeHide() {
      console.log("three: three-->onNativeHide")
      this.$engine.api(
        "com.zkty.jsi.dev",
        "log",
        "three-->onNativeHide"
      )
    },
    onNativeDestroyed() {
      console.log("three: three-->onNativeDestroyed")
      this.$engine.api(
        "com.zkty.jsi.dev",
        "log",
        "three-->onNativeDestroyed"
      )
    },

  pushAndDelete(){
      this.$router.push({
        path: "/testfour",
        params:{
          '__deleteHistory__': 1
        }
      })
  },
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
  margin: 0 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
