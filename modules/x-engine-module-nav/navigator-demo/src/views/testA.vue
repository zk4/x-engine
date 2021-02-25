<template>
  <div class="all">
      <div style="margin: 16px;">
        <div>current page: testA</div>
      </div>

      <div style="margin: 16px;">
        <div>原生跳转</div>
      </div>
      <div style="margin: 16px;">
        <van-button type="primary" round block @click="next">下一页</van-button>
      </div>

      <div style="margin: 16px;">
        <div>h5内部跳转</div>
      </div>
      <div style="margin: 16px;">
        <van-button type="primary" round block @click="h5next">下一页</van-button>
      </div>
  </div>
</template>

<script>
import xengine from "engine-zkty";
export default {
  name: "testA",
  components: {},
  data() {
    return {
      count: 0,
      isLoading: false,
    };
  },
  methods: {
    next() {
      xengine.nav.navigatorPush({
        url: "/testB",
        params: "000",
      });
    },

    h5next() {
      this.$router.push({
        path: "/testB",
        query: { qid: "110" },
      });
    }
  },
};
</script>

<style>
.all {
  height:100%;
}
</style>