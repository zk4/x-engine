<template>
  <div class="account-secure">
    <div class="content">
      <van-cell class="account-cell" title="更换手机号" is-link :value="phone.substr(0, 4) + '****' + phone.substr(8, 3)" @click="turnChangePhone" />
      <van-cell class="account-cell" title="业主认证" is-link :value="isShowRealName === 0 ? '去认证' : cardNo" @click="turnOwenerCert" />
      <van-cell class="account-cell" title="注销账户" is-link @click="turnCancelUser" />
    </div>
  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";
import router from "@zkty-team/x-engine-module-router";


export default {
  name:"AccountSecure",
  components: {

  },
  data () {
    return {
      cardNo: "",
      phone: "",
      isShowRealName: ""
    }
  },
  created() {
    nav.setNavLeftBtn({ title: "账号与安全", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    this.getUserQuery();
  },
  methods: {
    getUserQuery() {
      api.getUserQuery().then(res => {
        if (res.code === 200) {
          this.cardNo = res.data.cardNo;
          this.isShowRealName = res.data.isShowRealName;
          this.phone = res.data.phone;
        }
      }).finally(() => {
      });
    },
    turnChangePhone() {
      router.openTargetRouter({
        type: "microapp",
        uri: "com.times.microapp.AppcMine",
        path: "/changePhonenum?phone=" + this.phone
      });
      // this.$router.push({ path: "/changePhonenum",query: { phone: this.phone } });
    },
    turnCancelUser() {
      nav.navigatorPush({
        url: "/cancelAccount"
      });
      // this.$router.push({ path: "/cancelAccount" })
    },
    turnOwenerCert() {
      if (this.isShowRealName === 0) {
        nav.navigatorPush({
          url: "/ownerCert",
        });
        // this.$router.push({ path: "/ownerCert" })
      } else {
        nav.navigatorPush({
          url: "/hasOwnerCert"
        });
        // this.$router.push({ path: "/hasOwnerCert" })
      }
    }
  }
}
</script>


<style lang="less" scope>
.account-secure{
  width: 100%;
  height: auto;
  padding: 20px 16px;



}
</style>
