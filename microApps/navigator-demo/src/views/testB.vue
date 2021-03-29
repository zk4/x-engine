<template>
  <div>
    <div style="margin: 16px;">
      <div>current page: testB</div>
    </div>
    <div style="margin: 16px;">
      <div>原生跳转</div>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="openmp">打开新的microapp</van-button>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="next">下一页</van-button>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="back">上一页</van-button>
    </div>

    <div style="margin: 16px;">原生跳转携带参数为: {{nativeStr}}</div>
    <div style="margin: 16px;">
      <div>h5内部跳转</div>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="h5back">上一页</van-button>
    </div>
    <div style="margin: 16px;">
      <van-button type="primary" round block @click="h5next">下一页</van-button>
    </div>

    <div style="margin: 16px;">携带参数为: {{params}}</div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
import engine from "@zkty-team/x-engine-module-engine";
export default {
  name: "testB",
  data() {
    return {
      params: "",
      nativeStr: "",
    };
  },
  created() {},
  mounted() {
    this.nativeStr = this.$route.query.params;
    this.params = this.$route.query.qid;
  },
  methods: {
    openmp(){
      engine.bridge.call('com.zkty.jsi.direct.push',{
      scheme: 'microapp',
      host:'com.gm.microapp.mine',
      path:'/',
      hideNavbar:true,
      },function(res){})

    },
    next() {
      nav.navigatorPush({
        url: "/testC",
        hideNavbar: true
      });
    },
    back() {
      nav.navigatorBack();
    },

    h5next() {
      this.$router.push({
        path: "/testC",
        query: { qid: "111" },
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
