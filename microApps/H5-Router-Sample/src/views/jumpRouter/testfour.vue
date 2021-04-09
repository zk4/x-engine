<template>
  <div class="testfour-class">
    <div style="marginTop:50px">第4页</div>
    <van-button type="primary" size="large" round @click="handlerBack">上一页</van-button>
    <van-button type="info" size="large" round @click="handlerBackTwoPage">返回第二页</van-button>
    <van-button type="danger" size="large" round @click="handlerBackIndex">返回首页</van-button>
  </div>
</template>

<script>
export default {
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
  },
}
</script>

<style scoped>
.testfour-class {
  margin: 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
