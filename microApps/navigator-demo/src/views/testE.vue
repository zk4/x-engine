<template>
  <div>
    <div style="margin: 16px;">
      <div>current page: testE</div>
    </div>
    <div style="margin: 16px;">
      <div>原生跳转</div>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="goback">上一页</van-button>
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
import engine from "@zkty-team/x-engine-module-engine";
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
    back(url) {
      engine.bridge.call('com.zkty.module.nav.navigatorBack',{url},function(res){})
    },
    backToB() {
      nav.navigatorBack({
        url: "/testB",
      });
    },

    goback(){
          nav.navigatorBack({url:'-1'});

    },
    backRoot() {
      /*nav.navigatorBack({*/
        /*url: "0",*/
      /*});*/
      this.$options.methods.back('0');

    },

    h5back() {
      this.$router.go(-1);
    },
  },
};
</script>

<style>
</style>
