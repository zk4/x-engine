<template>
  <div class="gonggao">
    <div class="tabDiv-class">
      <van-tabs
        color="#E8374A"
        @click="clickTab"
        line-height="0px"
        background="rgba(0, 0, 0, 0)"
        swipeable
        scrollspy
        class="tab-class"
        title-active-color="#E8374A"
        title-inactive-color="#121212"
        title-style="title-style-class"
      >
        <van-tab title="新闻咨询"></van-tab>
        <van-tab title="通知公告"></van-tab>
        <van-tab title="规章制度"></van-tab>
        <van-tab title="处罚通报"></van-tab>
      </van-tabs>
    </div>

    <van-list>
      <div class="list-class" v-for="item in list" :key="item.id" @click="clickListItem()">
        <span class="title-class">{{ item.title }}</span>
        <span class="time-class">{{ item.time }}</span>
        <span class="type-class">{{ item.type }}</span>
      </div>
    </van-list>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
export default {
  data() {
    return {
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
    nav.setNavTitle({
      title: "员工公告",
      titleColor: "#000000",
      titleSize: 18
    });
  },
  methods: {
    clickTab(index) {
      this.showListIndex = index;
      console.log(index);
    },
    clickListItem() {
      nav.navigatorPush({
        url: "/GonggaoDesc"
      });
    }
  }
};
</script>

<style lang="less">
.gonggao {
  background-color: white;
  .tabDiv-class {
    height: 50px;
    width: 90%;
    background: rgba(0, 0, 0, 0.03);
    border-radius: 25px;
    margin: 0 15px;
    .tab-class {
      margin: 20px 10px;
      .van-tabs__wrap {
        position: relative;
        top: 3px;
        border-radius: 25px;
      }
      .van-tab--active {
        background-color: white;
        border-radius: 25px;
      }
    }
  }

  .list-class {
    border-radius: 5px;
    position: relative;
    margin: 10px 16px;
    display: flex;
    flex-direction: column;
    height: 82px;
    font-size: 14px;
    background: #ffffff;
    box-shadow: 0 6px 30px 0 rgba(71, 77, 96, 0.06);
    border-radius: 16px;
    .title-class {
      position: absolute;
      top: 22px;
      left: 16px;
      font-family: PingFangSC-Medium;
      font-size: 18px;
      color: #121212;
      letter-spacing: -0.3px;
      line-height: 18px;
    }
    .time-class {
      position: absolute;
      bottom: 18px;
      left: 16px;
      font-family: PingFangSC-Regular;
      font-size: 14px;
      color: #666666;
      letter-spacing: -0.23px;
      line-height: 14px;
    }
    .type-class {
      position: absolute;
      bottom: 15px;
      right: 16px;
      padding: 2px 7px;
      background: rgba(37, 116, 255, 0.1);
      border-radius: 20px;
      font-family: PingFangSC-Regular;
      font-size: 10px;
      color: #2574ff;
      letter-spacing: -0.17px;
    }
  }
}
</style>
