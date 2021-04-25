<template>
  <div :style="{marginTop:navigatorHeight+'px'}">
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerSet"
    >set</van-button>
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerGet"
    >get</van-button>

    <div>{{content}}</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      content: "",
    }
  },
  methods: {
      handlerSet() {
          this.$engine.api("com.zkty.jsi.localstorage", "set", {
              key: "hahaha",
              val: "wocao"
          })
      },
      handlerGet() {
          this.content = this.$engine.api("com.zkty.jsi.localstorage", "get", "hahaha")
      }
  },
}
</script>

<style>
.mainText {
  text-align: left;
  margin: 0 20px;
  font-size: 25px;
  font-weight: 600;
}

.fuText {
  text-align: left;
  margin: 0 30px;
  font-size: 16px;
  color: orangered;
}
</style>