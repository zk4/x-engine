<template>
  <div>
    <div style="margin: 16px;">
      <div>current page: testE</div>
    </div>
    <div style="margin: 16px;">
      <div>原生跳转</div>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="back">上一页</van-button>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="backToB">返回testB页面</van-button>
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
    <div style="margin: 16px;">携带参数为: {{this.params}}</div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
export default {
  name: "testE",
  data() {
    return {
      params: "",
    };
  },
  mounted() {
    this.params = this.$route.query.qid;
  },
  methods: {
    back() {
      nav.navigatorBack();
    },

    backToB() {
      nav.navigatorBack({
        url: "/testB",
      });
    },

    backRoot() {
      nav.navigatorBack({
        path: "0",
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
