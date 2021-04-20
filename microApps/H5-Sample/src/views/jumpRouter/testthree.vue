<template>
  <div class="testthree-class">
    <van-button type="primary" size="large" round @click="handlerPush">下一页</van-button>
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
