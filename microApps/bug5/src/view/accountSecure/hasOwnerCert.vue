<template>
  <div class="has-owner-cert">
    <div class="content">
      <van-cell class="account-cell" title="证件类型" value="身份证" />
      <van-cell class="account-cell" title="证件号" :value="cardNo.replace(/(?<=\d{4})\d+(?=[\dX]{3})/,'***********')" />
      <van-cell class="account-cell" title="姓名" :value="realName" />
    </div>
    <div class="subbottom-content">
      <van-button class="sub-button" data-color="true" type="primary" color="#E8374A" @click="cancelCert">取消认证</van-button>
    </div>
    <van-popup v-model="show">
      <div class="success-pop">
        <span class="success-pop-icon"></span>
        <div class="pop-text">
          <div class="pop-text-header">取消认证成功</div>
        </div>
        <div class="pop-btn" @click="cancelPop">返回</div>
      </div>
    </van-popup>
  </div>
</template>

<script>
import api from "@/api";
import { Dialog } from 'vant';
import nav from "@zkty-team/x-engine-module-nav";

export default {
  name:"HasOwnerCert",
  components: {
    
  },
  data () {
    return {
      cardNo: "",
      realName: "",
      show: false
    }
  },
  created() {
    nav.setNavLeftBtn({ title: "业主认证", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    this.getUserQuery();
  },
  methods: {
    cancelCert() {
      Dialog.alert({
        message: "取消认证后将会解除对应房产的业主身份，您确定要取消吗？",
        theme: "round-button",
        showCancelButton: "true",
        className: "time-dialog",
        cancelButtonColor: "#F5F5F6",
        confirmButtonColor: "#E8374A"
      }).then(() => {
        // on close
        api.cancelAccount().then(res => {
          if (res.code === 200) {
            this.show = true;
          }
        }).finally(() => {
        });
        
      })
      .catch(() => {
        
      });
      
    },
    cancelPop() {
      this.show = false;
      //跳转到登录页
    },
    getUserQuery() {
      api.getUserQuery().then(res => {
        if (res.code === 200) {
          this.cardNo = res.data.cardNo;
          this.realName = res.data.realName;
        }
      }).finally(() => {
      });
    }
  }
}
</script>


<style lang="less" scope>
.has-owner-cert{
  width: 100%;
  height: auto;
  padding: 20px 16px;
  

}
</style>