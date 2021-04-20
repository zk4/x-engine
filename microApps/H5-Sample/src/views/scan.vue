<template>
  <div class="scan">
   12341234
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
      this.engine.api("com.zkty.jsi.scan", "openScanView", {}, (val) => {
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