<template>
  <div class="gonggaodesc-class">
    <div class="title-class">{{descData.title}}</div>
    <div class="middle-class">
      <div class="target-class">{{descData.target}}</div>
      <div class="time-class">{{descData.time}}</div>
    </div>
    <div class="content-class">{{descData.content}}</div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
export default {
  name: "GonggaoDesc",
  data() {
    return {
      descData: {
        title: "召开业主大会公告",
        target: "小区居委会",
        time: "2019-09-10",
        content:
          "尊敬的小区全体业主:根据相关法律法规的要求，结合《小区业主委员会选举办法及选举实施细则》点这里查看现定于2009年月日起采取书面方式召开业主大会，请业主准备好业主选举证或房屋产权证、身份证，以便核实投票权数；委托他人投票的，被委托人需出示本人身份证及委托人的业主委员会选举证或身份证复印件、房屋产权复印件和委托书。业主大会议题：      一、表决通过业主管理规约；      二、表决通过业主大会、业主委员会议事规则；      三、选举产生业主委员会委员、候补"
      }
    };
  },
  mounted() {
    nav.setNavTitle({
      title: "公告详情",
      titleColor: "#121212",
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
    line-height: 20px;
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
