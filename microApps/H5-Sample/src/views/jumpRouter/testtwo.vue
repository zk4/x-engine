<!--
 * @Author: sheng.wang
 * @Date: 2021-05-10 16:44:39
 * @LastEditTime: 2021-06-02 13:59:32
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/microApps/H5-Sample/src/views/jumpRouter/testtwo.vue
-->
<template>
  <div class="testtwo-class">
    <van-button type="primary" size="large" round @click="handlerPush">下一页</van-button>
    <van-button type="primary" size="large" round @click="handlerPushNative">下一页原生native://foo/bar</van-button>
    <van-button type="info" size="large" round @click="handlerBack">上一页</van-button>

    <div>id ==> {{ id }}</div>
    <div>age ==> {{ age }}</div>
    <div>name ==> {{ name }}</div>
    <div>other ==> {{ other }}</div>
    <div>other[0] ==> {{ other[0] }}</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      id: "",
      age: "",
      name: "",
      other: "",
    }
  },

  mounted() {
    console.log(this.$route.params)
    this.id = this.$route.params.id
    this.age = this.$route.params.age
    this.name = this.$route.params.name
    this.other = JSON.parse(this.$route.query.other)
  },

  methods: {
  handlerPushNative(){
      this.$engine.api(
        "com.zkty.jsi.direct",
        "push",
        {
          scheme: "native",
          host: "foo",
          pathname: "/bar",
          fragment: "",
          params: {
            hideNavbar: true,
          },
        },
        function (res) {
          // console.log("res :>> ", res)
        }
      )

  },
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
