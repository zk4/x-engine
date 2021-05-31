<!--
 * @Author: sheng.wang
 * @Date: 2021-05-10 16:44:39
 * @LastEditTime: 2021-05-26 16:28:47
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/microApps/H5-Sample/src/views/jumpRouter/testtwo.vue
-->
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

  // beforeCreate() {
  //   console.log("pagetwo-beforeCreate")
  // },
  // created() {
  //   console.log("pagetwo-created")
  // },
  // beforeMount() {
  //   console.log("beforeMount")
  // },
  mounted() {
    // console.log("two mounted")
    console.log(this.$route)
    this.id = this.$route.params.id
    this.age = this.$route.params.age
    this.name = this.$route.params.name
  },
  // beforeDestroy() {
  //   console.log("beforeDestroy")
  // },
  // destroyed() {
  //   console.log("destroyed")
  // },

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
