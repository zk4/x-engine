<template>
  <div class="testtwo-class">
    <van-button type="primary" size="large" round @click="handlerPush">下一页</van-button>
    <van-button type="info" size="large" round @click="handlerBack">上一页</van-button>

    <div>id ==> {{ id }}</div>
    <div>age ==> {{ age }}</div>
    <div>name ==> {{ name }}</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: "",
      age: "",
      name: "",
    }
  },

  beforeCreate() {
    console.log("two-beforeCreate")
  },
  created() {
    console.log("two-created")
  },
  beforeMount() {
    console.log("two-beforeMount")
  },
  mounted() {
    console.log("two-mounted")
    this.id = this.$route.query.id
    this.age = this.$route.query.age
    this.name = this.$route.query.name
  },
  beforeDestroy() {
    console.log("two-beforeDestroy")
  },
  destroyed() {
    console.log("two-destroyed")
  },
  activated() {
    console.log("one-activated")
  },
  deactivated() {
    console.log("two-activated")
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
  margin: 0 20px;
}
.van-button {
  margin-top: 10px;
}
</style>
