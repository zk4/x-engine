<template>
  <div class="testtwo-class">
    <div style="marginTop:50px">第2页</div>
    <van-button
      type="primary"
      size="large"
      round
      @click="handlerPush"
    >下一页</van-button>
    <van-button
      type="info"
      size="large"
      round
      @click="handlerBack"
    >上一页</van-button>

    <div>id ==> {{id}}</div>
    <div>age ==> {{age}}</div>
    <div>name ==> {{name}}</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: "",
      age:'',
      name: ""
    }
  },
  mounted() {
    this.id = this.$route.query.id;
    this.age = this.$route.query.age;
    this.name = this.$route.query.name;
  },
  methods: {
    handlerPush() {
      this.$router.push({
        path: "/testthree",
      })
    },
    handlerBack() {
      this.$router.go(-1)
    },
  },
}
</script>

<style scoped>
.testtwo-class {
  margin: 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
