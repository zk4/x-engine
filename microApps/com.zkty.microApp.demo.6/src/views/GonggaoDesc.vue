<template>
  <div class="gonggaodesc-class">
    <div class="title-class">
      {{ descData.title }}
      <span v-if="publicStatus==0" class="status-class">未发布</span>
    </div>
    <div class="middle-class">
      <div class="target-class">{{ descData.target }}</div>
      <div class="time-class">{{ descData.time }}</div>
    </div>
    <div class="content-class">{{ descData.content }}</div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
export default {
  name: "GonggaoDesc",
  data() {
    return {
      // 0 未发布  1已发布
      publicStatus: 0,
      descData: {
        title: "关于胡管家和刘管家打架通知",
        target: "人事部",
        time: "2019-09-10",
        content:
          "能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架能不能给点力,别打架"
      }
    };
  },
  mounted() {
    this.publicStatus = this.$route.query.params;

    nav.setNavTitle({
      title: "公告详情",
      titleColor: "#000000",
      titleSize: 18
    });
  }
};
</script>

<style lang="less" scoped>
.gonggaodesc-class {
  text-align: left;
  display: flex;
  padding: 30px 16px 0 16px;
  flex-direction: column;
  .title-class {
    font-family: PingFangSC-Medium;
    font-size: 20px;
    color: #121212;
    letter-spacing: -0.33px;
    line-height: 25px;
    font-size: 21px;
  }
  .status-class {
    display: inline-block;
    position: relative;
    top: -1;
    padding: 2px 7px;
    margin-left: 5px;
    background: rgba(232, 55, 74, 0.1);
    border: 1px solid #e8374a;
    border-radius: 4px;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    line-height: 14px;
    color: #e8374a;
    letter-spacing: -0.22px;
  }
  .middle-class {
    display: flex;
    margin-top: 16px;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    color: #8d8d8d;
    letter-spacing: -0.23px;
    line-height: 14px;
    .target-class {
      margin-right: 32px;
      color: rgb(160, 160, 160);
    }
  }
  .content-class {
    margin: 32px 0;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    color: #121212;
    letter-spacing: -0.23px;
    line-height: 28px;
  }
}
</style>
