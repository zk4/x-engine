<template>
  <div class="testone-class">
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerInput"
    >input</van-button>
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerIntroduce"
    >Module Introduce</van-button>
    <van-button type="primary" size="large" round @click="handlerPushRouter">router跳转</van-button>
    <van-button type="danger" size="large" round @click="handlerHeader">重写HEADER</van-button>
    <!-- <van-button size="large" round color="#aaa0dd" @click="handlerCustomLayout">layout</van-button> -->
    <van-button color="#aaa0dd" size="large" round @click="handlerPhoto">拍照选择相册</van-button>
    <van-button type="warning" size="large" round @click="hanlderScan">扫码</van-button>
    <van-button
      color="linear-gradient(to right, #013656, #7e57c2)"
      size="large"
      round
      @click="handlerLocalStorage"
    >localstorage</van-button>
    <van-button color="linear-gradient(to right, #013656, #7e57c2)" @click="handlerRefreshData">刷新数据</van-button>
    <van-button type="danger" size="large" color="#7232dd" round @click="handlerSkeleton">骨架屏</van-button>
    <van-button type="warning" size="large" round @click="handlerGIF">GIF进入页面</van-button>
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerNetwork"
    >网络请求</van-button>
    <van-button
      color="linear-gradient(to right, #ef5350, #f44336)"
      size="large"
      round
      @click="handlerVueX"
    >VueX</van-button>
    <van-button type="danger" size="large" round @click="handlerSetNav">设置导航条</van-button>
  </div>
</template>

<script>
export default {
  data() {
    return {}
  },
  mounted() {
    console.log(this.$statusHeight)
  },
  methods: {
    handlerLocalStorage() {
      this.$router.push({
        path: "/localstorage",
      })
    },
    handlerInput() {
      this.$router.push({
        path: "/input",
      })
    },
    handlerPushRouter() {
      this.$router.push({
        path: "/testone",
      })
    },
    handlerSetNav() {
      this.$router.push({
        path: "/navigation",
      })
    },
    handlerSkeleton() {
      this.$router.push({
        path: "/skeleton",
      })
    },
    handlerGIF() {
      this.$router.push({
        path: "/gifView",
      })
    },
    handlerHeader() {
      this.$router.push({
        path: "/search",
      })
    },
    handlerCustomLayout() {
      this.$router.push({
        path: "/customLayout",
      })
    },
    handlerRefreshData() {
      this.$router.push({
        path: "/refreshData",
      })
    },
    handlerNetwork() {
      this.$router.push({
        path: "/network",
      })
    },
    handlerVueX() {
      this.$router.push({
        path: "/testVueX",
      })
    },
    handlerIntroduce() {
      this.$router.push({
        path: "/modulesIntroduce",
      })
    },
    handlerPhoto() {
      this.$router.push({
        path: "/photo",
      })
    },
    hanlderScan() {
      this.$router.push({
        path: "/scan",
      })
    },
  },
}
</script>

<style scoped>
.testone-class {
  margin: 0 20px 20px 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
