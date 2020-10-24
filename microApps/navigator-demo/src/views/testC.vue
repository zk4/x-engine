<template>
  <div>
    <div style="margin: 16px;">
      <div>current page: testC</div>
    </div>
    <div style="margin: 16px;">
      <div>原生跳转</div>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="next">下一页</van-button>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="back">上一页</van-button>
    </div>
    <div style="margin: 16px;">原生跳转携带参数为: {{this.params}}</div>
    <div style="margin: 16px;">
      <div>h5内部跳转</div>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="h5back">上一页</van-button>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="h5next">下一页</van-button>
    </div>
    <div style="margin: 16px;">携带参数为: {{this.params}}</div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
export default {
  name: "testC",
  data() {
    return {
      params: "",
    };
  },
  mounted() {
    this.params = this.$route.query.qid;
  },
  methods: {
    next() {
      nav.navigatorPush({
        url: "/testD",
      });
    },
    back() {
      nav.navigatorBack();
    },

    h5next() {
      this.$router.push({
        path: "/testD",
        query: { qid: "112" },
      });
    },

    h5back() {
      this.$router.go(-1);
    },
  },
};
</script>

<style>
</style>
