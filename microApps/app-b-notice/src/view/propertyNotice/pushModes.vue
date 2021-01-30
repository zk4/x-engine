<template>
  <div class="push-modes">
    <div class="content">
      <p class="title">通知方式</p>
      <van-radio-group :value="isChoose" :icon-size="16" checked-color="#E8374A" >
        <van-radio name="true" @click="changeChoose">
          <span class="radio-text">APP消息推送</span>
        </van-radio>
      </van-radio-group>
      <ul class="modelist-content" v-if="isChoose === 'true'">
        <li :class="index === currentIndex ? 'active' : ''" v-for="(item,index) in checkArr" :key="index" @click="chooseModes(index)">
          <span v-if="index === currentIndex" class="choose-icon"></span>
          <span>{{ item.text }}</span>
        </li>
      </ul>
    </div>
    <div class="btn-content">
      <span @click="submit(0)">保存</span>
      <span @click="submit(1)">保存并发布</span>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";

export default {
  name:'PushModes',
  data() {
    return {
      pagetype: "",
      status: 0,
      currentIndex: 0,
      isChoose: "false",
      paras: "",
      checkArr: [{text: "全部住户",value: 0},{text: "仅业主",value: 1}]
    };
  },
  mounted() {
    nav.setNavLeftBtn({ title: "新建", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" });
    this.getProjectList();
  },
  created() {
    this.noticeId = this.$route.query.noticeId;
    if (this.noticeId) {
      this.pagetype = "edit";
      this.getNoticeDetail();
    } else {
      this.pagetype = "add";
    }
    this.queryRedisNotice();
    // console.log(this.data[0])
    // this.getNotice();
  },
  methods: {
    toast() {
      this.$toast.loading({
        duration: 0,
        type: 'loading',
        message: '加载中...',
        forbidClick: true,
      });
    },
    getNoticeDetail() {
      const para = {
        id: this.noticeId,
      };
      api.getNoticeDetail(para).then(res => {
        if (res.code === 200) {
          // this.data = res.data.details;
          this.isChoose = "true";
          this.currentIndex = res.data.pushModes;
        }
      }).finally(() => {

      });
    },
    chooseModes(index) {
      console.log(index);
      this.currentIndex = index;
    },
    changeChoose() {
      if (this.isChoose === "false") {
        this.isChoose = "true";
      } else {
        this.isChoose = "false";
      }
    },
    queryRedisNotice() {
      const para = {
        id: this.$route.query.paraid
      };
      api.getRedisNotice(para).then(res => {
        if (res.code === 200) {
          this.paras = res.data;
        }
      }).finally(() => {

      });
    },
    submit(status) {
      this.toast();
      const uppara = {
        id: null
      };
      api.upPara(uppara).then(res => {
        if (res.code === 200) {
          const para = {
            pushModes: this.currentIndex,
            status: status
          };
          const paras = Object.assign(this.paras,para);
          delete paras.id;
          if (this.pagetype === "edit") {
            const noticeId = {
              id: this.noticeId
            };
            const editParas = Object.assign(paras,noticeId);
            api.editNotice(editParas).then(res => {
              if (res.code === 200) {
                this.$toast.clear();
                this.$toast("成功");
                // this.$router.push({ path: "/addNoticeDetail",query: { id: this.projectId } });
                // this.noticeTypeList = res.data;
                nav.navigatorBack({
                  url: "index"
                });
              }
            }).finally(() => {

            });

          } else {
            api.addNotice(paras).then(res => {
              if (res.code === 200) {
                this.$toast.clear();
                this.$toast("成功");
                // this.$router.push({ path: "/addNoticeDetail",query: { id: this.projectId } });
                // this.noticeTypeList = res.data;
                nav.navigatorBack({
                  url: "index"
                });
              }
            }).finally(() => {

            });
          }
        }
      });
    },
  }
};
</script>

<style lang="less">
.push-modes {
  padding: 20px 16px 0 16px;
  position: absolute;
  width: 100%;
  height: 100%;
  .content{
    width: 100%;
    height: calc(100% - 103px);
    padding: 17px 16px;
    background: #FFFFFF;
    box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
    border-radius: 16px;
    .title{
      font-size: 14px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #8D8D8D;
      margin: 0 0 12px 0;

    }
    .radio-text{
      font-size: 16px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #121212;
    }
    .modelist-content{
      margin-top: 17px;
      li{
        width: 100%;
        padding: 9px 0;
        font-size: 16px;
        font-family: PingFangSC-Regular, PingFang SC;
        font-weight: 400;
        background: #F4F5F7;
        border-radius: 6px;
        text-align: center;
        margin-bottom: 10px;
      }
      li.active{
        background: #EDF5FF;
        color: #0073FF;
      }
      .choose-icon{
        width: 12px;
        height: 9px;
        margin-right: 6px;
        display: inline-block;
        background: url("../../assets/img/choose-icon.png");
        background-size: 100% 100%;
      }
    }
  }
  .btn-content{
    width: 100%;
    height: 98px;
    padding: 16px;
    span{
      width: calc(50% - 8px);
      padding: 13px 0;
      text-align: center;
      font-size: 16px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      display: inline-block;
    }
    span:nth-child(1){
      background: #FFFFFF;
      border-radius: 8px;
      border: 1px solid #D8D8D8;
      color: #000;
      margin-right: 8px;
    }
    span:nth-child(2){
      background: #E7334A;
      border-radius: 8px;
      color: #fff;
    }
  }
}
</style>
