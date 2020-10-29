<template>
  <div class="news-notice">
    <div class="tabDiv">
      <van-tabs v-model="active" animated scrollspy sticky>
        <van-tab v-for="(item,index) in titleList" :title="item" :key="index">
          <div class="list" v-for="list in list" :key="list.id" @click="clickListItem">
            <p class="title">{{ list.title }}</p>
            <p>
              <span class="time">{{ list.time }}</span>
              <span class="type"><span class="user-icon"></span>{{ list.type }}</span>
            </p>
          </div>
        </van-tab>
      </van-tabs>
    </div>
  </div>
</template>

<script>
// import nav from "@zkty-team/x-engine-module-nav";
import nav from "@zkty-team/x-engine-module-nav";
export default {
  name:'NewsNotice',
  data() {
    return {
      indicators: false,
      titleList: ["新闻咨询","通知公告","规章制度","处罚通报","规章制度","处罚通报","规章制度"],
      list: [
        {
          id: 0,
          title: "关于胡管家和刘管家打架通知",
          time: "2019-09-10",
          type: "人事部"
        },
        {
          id: 1,
          title: "夏季上班时间变更",
          time: "2020-08-12",
          type: "人力资源管理中心"
        },
        {
          id: 2,
          title: "办理门禁新流程公告",
          time: "2019-09-10",
          type: "人事部"
        }
      ],
      showListIndex: 0
    };
  },
  mounted() {
    nav.setNavLeftBtn({ title: "物业公告", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    // nav.setNavTitle({
    //   title: "员工公告",
    //   titleColor: "#000000",
    //   titleSize: 18
    // });
  },
  methods: {
    clickTab(index) {
      // this.$refs.swiper.swipeTo(index);
      this.showListIndex = index;
      console.log(index);
    },
    clickListItem() {
      // nav.navigatorPush({
      //   url: "/GonggaoDesc"
      // });
    }
  }
};
</script>

<style lang="less">
.news-notice {
  padding: 20px 16px;

  .tabDiv {
    .van-tabs--line .van-tabs__wrap{
      height: 56px;
    }
    .van-tab__pane-wrapper--inactive{
      overflow: hidden;
    }
    .van-tabs__content--animated{
      overflow: inherit;
    }
    .van-tabs__nav--line{
      height: 56px;
      background: rgba(0, 0, 0, 0.03);
      border-radius: 28px;
      padding-bottom: 0;
    }
    .van-tabs__line{
      width: calc(29% - 8px);
      height: 47px;
      top: 5px;
      background: #FFFFFF;
      border-radius: 23px;
      z-index: 0;
    }
    .van-tab{
      font-size: 16px;
      font-family: PingFangSC-Medium, PingFang SC;
      font-weight: 400;
      color: #121212;
    }
    .van-tab--active{
      z-index: 1;
      font-weight: 500;
      color: #E8374A;
    }
  }


  .list {
    padding: 18px 16px;
    border-radius: 5px;
    position: relative;
    margin-top: 20px;
    display: flex;
    flex-direction: column;
    font-size: 14px;
    background: #ffffff;
    box-shadow: 0 6px 30px 0 rgba(71, 77, 96, 0.06);
    border-radius: 16px;
    p{
      margin: 0;
    }
    .title {
      font-family: PingFangSC-Medium;
      font-size: 18px;
      color: #121212;
      letter-spacing: -0.3px;
      line-height: 18px;
      margin: 0 0 10px 0;
    }
    .time {
      font-family: PingFangSC-Regular;
      font-size: 14px;
      color: #666666;
      letter-spacing: -0.23px;
      line-height: 14px;
      margin-right: 22px;
    }
    .type {
      font-size: 14px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #666666;
      position: relative;
      top: 1px;

      .user-icon{
        width: 12px;
        height: 12px;
        display: inline-block;
        background: url("../../assets/img/user-icon.png");
        background-size: 100% 100%;
        margin-right: 2px;
      }
    }
  }
}
</style>
