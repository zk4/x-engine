<template>
  <div>
    <HEADER :reviceNavTitle="navTitle" @clickLeftButton="handlerHeaderBack" />
    <div class="content">store中的count为:{{$store.state.count}}</div>
    <div class="operating">
      <van-button
        color="linear-gradient(to right, #4bb0ff, #6149f6)"
        size="large"
        round
        @click="handlerSyncJIA"
      >sync加</van-button>
      <van-button
        color="linear-gradient(to right, #ff6034, #ee0a24)"
        size="large"
        round
        @click="handlerSyncJIAN"
      >async减</van-button>
    </div>

    <van-button style="marginTop:50px;" type="warning" size="large" round @click="handlerNextPage">下一页</van-button>
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
      navTitle: "TEST VUEX",
    }
  },
  methods: {
    handlerHeaderBack() {
      this.$router.go(-1)
    },
    handlerSyncJIA() {
      this.$store.commit("jia")
    },
    handlerSyncJIAN() {
      this.$store.commit("jian")
    },
    handlerNextPage() {
      this.$router.push({
        path: "/skeleton",
      })
    },
  },
}
</script>

<style>
.content {
  background: gray;
  border-radius: 20px;
  margin-top: 200px;
  margin: 200px 50px 50px 50px;
  height: 200px;
  color: white;
  line-height: 200px;
}

.operating {
  display: flex;
}
</style>