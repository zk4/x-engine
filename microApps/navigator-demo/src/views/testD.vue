<template>
  <div>
    <div style="margin: 16px;">
      <div>current page: testD</div>
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
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="backToMicroHome">返回微应用首页</van-button>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="backRoot">返回原生页面</van-button>
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
  name: "testD",
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
        url: "/testE",
        hideNavbar: true
      });
    },
    back() {
      nav.navigatorBack();
    },
    backToMicroHome() {
      nav.navigatorBack({
        url: "/index",
        hideNavbar: true
      });
    },
    backRoot() {
      nav.navigatorBack({
        url: "0",
        hideNavbar: true
      });
    },

    h5next() {
      this.$router.push({
        path: "/testE",
        query: { qid: "113" },
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
