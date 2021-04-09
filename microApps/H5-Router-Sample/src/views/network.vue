<template>
  <div style="marginTop:100px">
    <van-button type="primary" size="large" round @click="handlerNetwork">requestData</van-button>
    <div>result:</div>
    <div>{{content}}</div>
  </div>
  
</template>

<script>
import server from "../utils/ajax"
export default {
  data() {
    return {
        content:''
    }
  },
  mounted() {
  },
  methods: {
    handlerNetwork() {
      server
        .get("/mock/871b3e736e653b99374b7713e4011f9f/boss/user/list")
        .then((res) => {
          if (res.code == "0000") {
            this.content = res.data
          } else {
            this.$message.error(res.msg)
          }
        })
    },
  },
}
</script>

<style>
.navHeader1-class {
  margin-top: 200px;
}
</style>