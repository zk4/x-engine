<template>
  <div class="gonggao">
    <van-list>
      <div class="list-class" v-for="item in list" :key="item.id" @click="clickItem">
        <span class="title-class">{{ item.title }}</span>
        <span class="time-class">{{ item.create_time }}</span>
        <span class="type-class">{{ item.typeName }}</span>
      </div>
    </van-list>
    <!-- <van-loading color="#1989fa" v-if="isShowLoading" /> -->
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
import network from "@zkty-team/x-engine-module-network";
export default {
  data() {
    return {
      // list: [],
      isShowLoading: true,
      list: [
        {
          id: 0,
          title: "小区垃圾分类公告",
          create_time: "2019-09-10",
          typeName: "社区公告"
        },
        {
          id: 1,
          title: "社区防疫分类公告",
          create_time: "2020-09-10",
          typeName: "政府公告"
        },
        {
          id: 2,
          title: "召开业务大会分类公告",
          create_time: "2020-06-31",
          typeName: "社区公告"
        }
      ]
    };
  },
  mounted() {
    nav.setNavTitle({
      title: "物业公告",
      titleColor: "#000000",
      titleSize: 18
    });
    // this.getData();
  },
  methods: {
    async getData() {
      const params = {
        // url: "http://dev.linli580.com:10000/notice/api/v1/query/1",
        url: "http://localhost:8000/wuyegonggaoList.json",
        method: "GET"
      };
      const result = await network.request(params);
      this.isShowLoading = false;
      this.list = result.result.data.notices;
    },
    clickItem() {
      nav.navigatorPush({
        url: "/GonggaoDesc"
      });
    }
  }
};
</script>

<style lang="less" scoped>
.list-class {
  box-shadow: 0 6px 30px 0 rgba(71, 77, 96, 0.06);
  border-radius: 16px;
  background-color: #ffffff;
  position: relative;
  margin: 15px;
  display: flex;
  flex-direction: column;
  height: 82px;
  font-size: 14px;
  .title-class {
    position: absolute;
    top: 20px;
    left: 16px;
    font-family: PingFangSC-Medium;
    font-size: 18px;
    color: #121212;
    letter-spacing: -0.3px;
    line-height: 18px;
  }
  .time-class {
    position: absolute;
    bottom: 20px;
    left: 16px;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    color: #717171;
    letter-spacing: -0.23px;
    line-height: 14px;
  }
  .type-class {
    background: #e3f0ff;
    border-radius: 10px;
    position: absolute;
    bottom: 17px;
    right: 16px;
    padding-left: 12px;
    padding-right: 12px;
    font-family: PingFangSC-Medium;
    font-size: 12px;
    color: #6192cd;
    letter-spacing: -0.27px;
    text-align: center;
    line-height: 20px;
  }
}
</style>
