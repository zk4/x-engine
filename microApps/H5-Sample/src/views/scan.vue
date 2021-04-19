<template>
  <div class="scan">
    <van-button
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="hanlderScan"
    >扫码</van-button>
  </div>
</template>

<script>
export default {
    methods: {
        hanlderScan() {
            alert('scanalert');
        }
    },}
</script>

<style>
</style>