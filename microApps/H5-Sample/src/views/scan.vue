<template>
  <div class="scan">
    <van-button
      class="btn-class"
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="hanlderScan"
    >扫码</van-button>
    {{result}}
  </div>
</template>

<script>
export default {
  data() {
    return {
      result: "",
    }
  },
  methods: {
    hanlderScan() {
      this.$engine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
        this.result = val
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