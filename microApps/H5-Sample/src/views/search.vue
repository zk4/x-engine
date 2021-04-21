<template>
  <div class="scan">
    <ZKTY-Header :bgColor="bgColor">
      <template v-slot:left>
        <div @click="handlerLeft">我是返回</div>
      </template>
      <template v-slot:center>
        <div @click="handlerCenter">我是搜索框</div>
      </template>
      <template v-slot:right>
        <div @click="hanlderRight">右边按钮</div>
      </template>
    </ZKTY-Header>
    <div>12341234</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      result: "",
      bgColor: "#ddd",
    }
  },
  methods: {
    hanlderScan() {
      this.$engine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
        this.result = val
      })
    },
    handlerLeft() {
      this.$router.go(-1)
    },
    handlerCenter() {
      alert("rapper天团")
    },
    hanlderRight() {
      alert("莫挨老子")
    },
  },
}
</script>

<style>
.scan-button {
  margin-top: 100px;
}
</style>