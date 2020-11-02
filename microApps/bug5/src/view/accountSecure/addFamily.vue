<template>
  <div class="add-family">
    <van-form @submit="onSubmit">
      <div class="form-content">
        <div class="form-nav-header">关系</div>
        <van-field
          readonly
          clickable
          name="relationship"
          :value="value"
          right-icon="arrow-down"
          @click="showPicker = true"
        />
        <van-popup v-model="showPicker" position="bottom">
          <van-picker
            show-toolbar
            :columns="reColumns"
            @confirm="onConfirm"
            @cancel="showPicker = false"
          />
        </van-popup>
        <div class="form-nav-header">姓名</div>
        <van-field v-model="username" name="username" placeholder="请输入" @input="fieldChange" />
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
          <van-field class="phone-content" name="phone" v-model="phone" placeholder="请输入手机号" @input="fieldChange" />
          <van-popup v-model="showAreaCode" position="bottom" class="contact-customer-pop">
            <div class="contact-customer-num">
              <p :class="index === phoneIndex ? 'active' : ''" v-for="(item,index) in areaCodeColumns" :key="index" @click="onAreaConfirm(item,index)">{{item}}</p>
            </div>
            <div class="pop-btn-cancel" @click="showAreaCode = false">取消</div>
          </van-popup>
          <div v-if="phoneError" class="error-text">手机号错误</div>
        </div>
      </div>
      <van-radio-group :value="isChoose" :icon-size="16" checked-color="#E8374A" >
        <van-radio name="true">
          <span class="radio-text" @click="changeChoose">我已阅读并同意</span>
          <span class="agreememt">《认证服务协议》</span>
        </van-radio>
      </van-radio-group>
      <div class="subbottom-content">
        <van-button class="sub-button" :data-color="canSub" type="primary" :color="color" native-type="submit">确定</van-button>
      </div>
    </van-form>
    
    
    
  </div>
</template>

<script>
import api from "@/api";
import { isTruePhone } from "@/utils/common.js"
import nav from "@zkty-team/x-engine-module-nav";

const cardIcon = require("@/assets/img/photo-icon.png");

export default  {
  name:"AddFamily",
  components: {
    
  },
  data () {
    return {
      phoneIndex: 0,
      relationship: "",
      value: "业主",
      valueId: 1,
      reColumns: ["业主","租户","商户","前期管理费单位","家人","朋友"],
      showPicker: false,
      username: "",
      
      idCard: "",
      phone: "",
      sms: "",
      areaCode: "86",
      areaCodeColumns: ["中国大陆（+86）","中国香港（+852）","中国澳门（+886）","中国台湾（+853）"],
      
      showAreaCode: false,
      cardIcon: cardIcon,
      isChoose: "false",
      canSub: false,
      color: "#F5F5F6",
      time: 60,
      smsSendBtn: false,
      phoneError: false
    }
  },
  created() {
    nav.setNavLeftBtn({ title: "添加", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
  },
  methods: {
    changeMessage(value) {
      console.log(value)
      // this.message = value;
    },
    onConfirm(value) {
      this.value = value;
      if (value === "业主") {
        this.valueId = 1;
      } else if (value === "租户") {
        this.valueId = 2;
      } else if (value === "商户") {
        this.valueId = 3;
      } else if (value === "前期管理费单位") {
        this.valueId = 4;
      } else if (value === "家人") {
        this.valueId = 5;
      } else if (value === "朋友") {
        this.valueId = 6;
      }
      
      this.showPicker = false;
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
      if ( !(isTruePhone(this.areaCode, this.phone)) ){
          this.phoneError = true;
          this.errorText = "请输入正确手机号";
      } else {
        console.log(values);
        const para = {
          custSex: 1,
          roomId: this.$route.query.roomId,
          projectId: this.$route.query.proId,
          phoneAreaCode: this.areaCode,
          phone: this.phone,
          personType: this.valueId,
          custName: this.username
        }
        api.addOwner(para).then(res => {
          if (res.code === 200) {
            nav.navigatorBack({
              url: "/myFamily"
            });
          }
        }).finally(() => {
        });
      }
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
      if(this.username && this.phone && this.isChoose === "true"){
        this.canSub = true;
        this.color = "#E8374A";
      }else{
        this.canSub = false;
        this.color = "#F5F5F6";
      }
    },
  }
}
</script>


<style lang="less" scope>
.add-family{
  width: 100%;
  height: auto;
  padding: 20px 16px 98px 16px;
  .form-content{
    overflow: hidden;
  }
  .van-popup--bottom{
    background: transparent
  }
}
</style>