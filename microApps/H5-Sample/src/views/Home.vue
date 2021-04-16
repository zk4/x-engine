<template>
  <div class="testone-class">
    <div style="marginTop:50px">Home</div>
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerIntroduce"
    >Module Introduce</van-button>
    <van-button type="primary" size="large" round @click="handlerPushRouter">router跳转</van-button>
    <van-button type="info" size="large" round @click="handlerSetNav">设置导航条</van-button>
    <van-button type="danger" size="large" color="#7232dd" round @click="handlerSkeleton">骨架屏</van-button>
    <van-button type="warning" size="large" round @click="handlerGIF">GIF进入页面</van-button>
    <van-button type="danger" size="large" round @click="handlerNavigator">前端定制navigator</van-button>
    <van-button size="large" round color="#aaa0dd" @click="handlerCustomLayout">layout</van-button>
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerRefreshData"
    >刷新数据</van-button>
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerNetwork"
    >网络请求</van-button>
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerVueX"
    >VueX</van-button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      navHeader: "123",
    }
  },
  methods: {
    handlerPushRouter() {
      this.$router.push({
        path: "/testone",
        query: {
          id: 1,
          age: 18,
        },
      })
    },
    handlerSetNav() {
      this.$router.push({
        path: "/navigation",
        query: {
          id: 1,
          age: 18,
        },
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
    handlerNavigator() {
      this.$router.push({
        path: "/navHeader1",
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
  },
}
</script>

<style scoped>
.testone-class {
  margin: 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
