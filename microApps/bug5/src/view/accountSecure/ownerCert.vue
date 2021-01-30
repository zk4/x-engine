<template>
  <div class="owner-cert">
    <van-form @submit="onSubmit">
      <div class="form-content">
        <div class="title-content">
          <span class="title-icon"></span>
          <span class="title-text">验证信息</span>
        </div>
        <div class="form-nav-header">姓名</div>
        <van-field v-model="userName" name="userName" placeholder="请输入" @input="fieldChange" />
        <div class="form-nav-header">证件类型</div>
        <van-field
          readonly
          clickable
          name="cardType"
          :value="cardType"
          right-icon="arrow-down"
          @click="showPicker = true"
        />
        <van-popup v-model="showPicker" position="bottom">
          <van-picker
            show-toolbar
            :columns="columns"
            @confirm="onConfirm"
            @cancel="showPicker = false"
          />
        </van-popup>
        <div class="form-nav-header">证件号</div>
        <div class="idcard-content">
          <van-field v-model="cardNo" name="cardNo" placeholder="请输入证件号" @input="fieldChange" />
        </div>
        <div class="form-nav-header">手机号</div>
        <div :class="phoneError ? 'areaCodeContent error' : 'areaCodeContent'">
          <van-field
            class="area-content"
            readonly
            clickable
            name="areaCode"
            :value="'+' + areaCode"
            right-icon="arrow-down"
            @click="showAreaCode = true"
          />
          <van-field class="phone-content" v-model="phone" name="phone" placeholder="请输入手机号" @input="fieldChange" />
          <van-popup v-model="showAreaCode" position="bottom" class="contact-customer-pop">
            <div class="contact-customer-num">
              <p :class="index === phoneIndex ? 'active' : ''" v-for="(item,index) in areaCodeColumns" :key="index" @click="onAreaConfirm(item,index)">{{item}}</p>
            </div>
            <div class="pop-btn-cancel" @click="showAreaCode = false">取消</div>
          </van-popup>
          <div v-if="phoneError" class="error-text">{{errorText}}</div>
      </div>
      <div class="sms-content">
        <van-field
          name="verCode"
          v-model="verCode"
          center
          placeholder="请输入验证码"
          @input="fieldChange"
        >
          <template #button>
            <van-button size="small" type="primary" @click="sendCode">{{ !smsSendBtn && '发送验证码' || (time+'s后重发') }}</van-button>
          </template>
        </van-field>
      </div>
      </div>
      <van-radio-group :value="isChoose" :icon-size="16" checked-color="#E8374A" >
        <van-radio name="true" @click="changeChoose">
          <span class="radio-text">我已阅读并同意</span>
          <span class="agreememt">《认证服务协议》</span>
        </van-radio>
      </van-radio-group>
      <div class="subbottom-content">
        <van-button class="sub-button" :data-color="canSub" type="primary" :color="color" native-type="submit">确定</van-button>
      </div>
    </van-form>
    <van-popup v-model="show">
      <div class="success-pop">
        <span class="fail-pop-icon"></span>
        <div class="pop-text">
          <div class="pop-text-header">业主认证失败</div>
          <p>请确认信息是否填写正确，若信息填写无误</p>
          <p>可以拨打服务热线<span class="phone-num">400-806-123</span></p>
        </div>
        <div class="pop-btn" @click="cancelPop">关闭</div>
      </div>
    </van-popup>
  </div>
</template>

<script>
import api from "@/api";
import { isTruePhone } from "@/utils/common.js"
import nav from "@zkty-team/x-engine-module-nav";

const cardIcon = require("@/assets/img/photo-icon.png");

export default  {
  name:"OwnerCert",
  components: {
    
  },
  data () {
    return {
      phoneIndex: 0,
      show: false,
      userName: "",
      cardType: "大陆身份证",
      cardTypeValue: "111",
      cardNo: "",
      phone: "",
      verCode: "",
      areaCode: "86",
      areaCodeColumns: ["中国大陆（+86）","中国香港（+852）","中国澳门（+886）","中国台湾（+853）"],
      columns: ["大陆身份证","军官证","港澳通行证","台湾居民来往大陆通行证","港澳同胞回乡证","出生证","士兵证","户口薄","警官证","学生证","文职干部证","香港居民身份证","澳门居民身份证","护照","台湾居民身份证","营业执照","组织机构代码证","税务登记证","其他"],
      showPicker: false,
      showAreaCode: false,
      cardIcon: cardIcon,
      isChoose: "false",
      canSub: false,
      color: "#F5F5F6",
      time: 60,
      smsSendBtn: false,
      phoneError: false,
      errorText: "手机号错误"
    }
  },
  created() {
    nav.setNavLeftBtn({ title: "业主认证", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
  },
  methods: {
    changeMessage(value) {
      console.log(value)
      // this.message = value;
    },
    onConfirm(value) {
      if (value === "大陆身份证") {
        this.cardTypeValue = "111";
      } else if (value === "军官证") {
        this.cardTypeValue = "114";
      } else if (value === "港澳通行证") {
        this.cardTypeValue = "513";
      } else if (value === "台湾居民来往大陆通行证") {
        this.cardTypeValue = "511";
      } else if (value === "港澳同胞回乡证") {
        this.cardTypeValue = "516";
      } else if (value === "出生证") {
        this.cardTypeValue = "117";
      } else if (value === "士兵证") {
        this.cardTypeValue = "235";
      } else if (value === "户口薄") {
        this.cardTypeValue = "113";
      } else if (value === "警官证") {
        this.cardTypeValue = "123";
      } else if (value === "学生证") {
        this.cardTypeValue = "133";
      } else if (value === "文职干部证") {
        this.cardTypeValue = "115";
      } else if (value === "香港居民身份证") {
        this.cardTypeValue = "A01";
      } else if (value === "澳门居民身份证") {
        this.cardTypeValue = "A02";
      } else if (value === "护照") {
        this.cardTypeValue = "A03";
      } else if (value === "台湾居民身份证") {
        this.cardTypeValue = "A04";
      } else if (value === "营业执照") {
        this.cardTypeValue = "B01";
      } else if (value === "组织机构代码证") {
        this.cardTypeValue = "B02";
      } else if (value === "税务登记证") {
        this.cardTypeValue = "B03";
      } else if (value === "其他") {
        this.cardTypeValue = "990";
      }
      this.showPicker = false;
      this.cardType = value;
    },
    onAreaConfirm(value,index) {
      if (value === "中国大陆（+86）") {
        this.areaCode = "86";
      } else if (value === "中国香港（+852）") {
        this.areaCode = "852";
      } else if (value === "中国澳门（+886）") {
        this.areaCode = "886";
      } else if (value === "中国台湾（+853）") {
        this.areaCode = "853";
      }
      this.phoneIndex = index;
      // this.areaCode = "+" + value;
      this.showAreaCode = false;
    },
    afterRead(file) {
      console.log(file);
    },
    onSubmit(values) {
      const para = values;
      para.areaCode = para.areaCode.split("+")[1];
      para.cardType = this.cardTypeValue;
      api.ownerCert(para).then(res => {
         if (res.code == 200) {
          nav.navigatorPush({
            url: "/ownerCertSuccess",
            params: encodeURI(
              `cardNo=${this.cardNo}`
            ),
          });
          // this.$router.push({ path: "/ownerCertSuccess",query: { cardNo: this.cardNo } })
         } else {
          this.show = true;
         }
      }).finally(() => {
        
      });
      console.log(values);
    },
    changeChoose() {
      if (this.isChoose === "false") {
        this.isChoose = "true";
      } else {
        this.isChoose = "false";
      }
      this.fieldChange();
    },
    fieldChange() {
      this.phoneError = false;
      if(this.userName && this.cardNo && this.phone && this.verCode && this.isChoose === "true"){
        this.canSub = true;
        this.color = "#E8374A";
      }else{
        this.canSub = false;
        this.color = "#F5F5F6";
      }
    },
    sendCode() {
      if (!this.phone) {
        this.$toast("请输入手机号");
      } else if ( !(isTruePhone(this.areaCode, this.phone)) ){
          this.phoneError = true;
          this.errorText = "请输入正确手机号";
      } else {
        this.smsSendBtn = true;
        const interval = window.setInterval(() => {
          if (this.time-- <= 0) {
            this.time = 60
            this.smsSendBtn = false
            window.clearInterval(interval)
          }
        }, 1000)
        const para = {
          areaCode: this.areaCode,
          phoneNumber: this.phone
        }
        api.sendCode(para).then(res => {
          if (res.code === 200) {
            console.log("成功")
          }
        }).finally(() => {
          clearInterval(interval)
          this.time = 60
          this.smsSendBtn = false
        });
      }
    },
    cancelPop() {
      this.show = false;
    }
  }
}
</script>


<style lang="less" scope>
.owner-cert{
  width: 100%;
  height: auto;
  padding: 20px 16px 98px 16px;
  
  .radio-text{
    font-size: 12px;
    font-family: PingFangSC-Regular, PingFang SC;
    color: #9593A4;
  }
  .agreememt{
    font-size: 12px;
    font-family: PingFangSC-Regular, PingFang SC;
    color: #E8374A;
    text-decoration: underline;
  }
  .van-popup--bottom{
    background: transparent
  }
}
</style>