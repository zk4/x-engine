<template>
  <div class="scan">
    <van-button
      class="scan-button"
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="hanlderScan"
    >扫码</van-button>
    <div>扫码结果为:{{result}}</div>
  </div>
</template>

<script>
import xengine from "@zkty-team/x-engine-core"
export default {
  data() {
    return {
      result:''
    }
  },
  methods: {
    hanlderScan() {
      xengine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
        this.result = val;
      })
    },
  },
}
</script>

<style>
.scan-button {
  margin-top: 100px;
}
</style>