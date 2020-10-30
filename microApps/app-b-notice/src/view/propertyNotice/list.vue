<template>
  <div class="property-notice">
    <div class="menu">
      <van-dropdown-menu>
        <van-dropdown-item v-model="projectIndex" :options="projectList" @change="checkItem"/>
      </van-dropdown-menu>
    </div>
    <div class="tabDiv">
      <div ref="scrollContent" class="scroll-content"  v-infinite-scroll="loadMore" infinite-scroll-throttle-delay="500" infinite-scroll-disabled="busy" infinite-scroll-distance="300">
        <van-tabs v-model="active" animated @click="clickTab">
          <van-tab v-for="(item,index) in titleList" :title="item" :key="index">
            <template>
              <div class="list" v-for="list in data[index]" :key="list.id" @click="clickListItem(list.id)">
                <p class="title">{{ list.title }}</p>
                <p>
                  <span class="time">{{ moment(list.publishedAt).format("YYYY/MM/DD") }}</span>
                  <span class="type"><span class="user-icon"></span>{{ list.typeName }}</span>
                </p>
              </div>
              <div class="default-content" v-if="show && data[index].length === 0">
                <div class="container">
                  <span class="default-icon"></span>
                  <p>您还没有创建公告哦~</p>
                  <span class="add-btn" @click="addNotie">新建公告</span>
                </div>
              </div>
            </template>
          </van-tab>
        </van-tabs>
      </div>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import moment from "moment"
import nav from "@zkty-team/x-engine-module-nav";

export default {
  name:'PropertyNotice',
  data() {
    return {
      projectList: [],
      projectIndex: "",
      projectId: "",
      active: 0,
      indicators: false,
      pageIndex1: 1,
      pageIndex2: 1,
      titleList: ["已发布","未发布"],
      data: [[],[]],
      total: ["",""],
      pageIndex: [1,1],
      data0: [],
      data1: [],
      total1: "",
      total2: "",
      status: 1,
      busy: false,
      show: false,
      scroll: 0
    };
  },
  mounted() {
    this.toast();
    this.getProjectList();
    nav.setNavLeftBtn({ title: "物业公告", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
  },
  created() {
    // console.log(this.data[0])
    // this.getNotice();
  },
  activated(){
    this.$refs.scrollContent.scrollTo(0,this.scroll);
  },
  methods: {
    moment,
    toast() {
      this.$toast.loading({
        duration: 0,
        type: 'loading',
        message: '加载中...',
        forbidClick: true,
      });
    },
    clickTab(index) {
      this.status = index === 0 ? 1 : 0;
      console.log(index);
      this.busy = false;
      this.active = index;
      if(this.data[index].length === 0) {
        this.toast();
        this.pageIndex[index] = 1;
        this.getNotice();
      }

    },
    addNotie() {
      nav.navigatorPush({
        url: "/addNotice",
        params: encodeURI(
          `id=${this.projectId}`
        ),
      });
      // this.$router.push({ path: "/addNotice",query: { id: this.projectId } });
    },
    checkItem(id) {
      this.projectId = id;
      // console.log(id)
      this.data = [[],[]];
      this.pageIndex = [1,1];
      this.toast();
      this.getNotice();
    },
    clickListItem(id) {
      this.scroll = this.$refs.scrollContent.scrollTop;
      nav.navigatorPush({
        url: "/propertyDetail",
        params: encodeURI(
          `id=${id}`
        ),
      });
      // this.$router.push({ path: "/propertyDetail",query: { id: id } });
    },
    getProjectList() {
      api.getProjectList().then(res => {
        if (res.code === 200) {
          for (var i = 0;i<res.data.length; i++) {
            this.projectList.push({
              text: res.data[i].name,
              value: res.data[i].id
            })
          }
          // console.log()
          // this.projectList = this.projectList;
          this.projectIndex = res.data[0].id;
          this.projectId = res.data[0].id;
          this.getNotice();

        }
      }).finally(() => {

      });

    },
    getNotice() {
      this.show = false;
      const para = {
        projectId: this.projectId,
        pageIndex: this.status === 1 ? this.pageIndex[0] : this.pageIndex[1],
        status: this.status,
        pageSize: 10
      };
      api.getNotice(para).then(res => {
        if (res.code === 200) {
          this.show = true;
          this.data[this.status === 0 ? 1 : 0] = this.data[this.status === 0 ? 1 : 0].concat(res.data.records);
          // this.data = this.data;
          this.total[this.status === 0 ? 1 : 0] = res.data.total;
          if (this.more && res.data.records.length > 0) {
            this.busy = false;
          }
          this.$forceUpdate();
          this.$toast.clear();
          console.log(this.data[0])
        }
      }).finally(() => {

      });
    },
    loadMore() {
      if (this.status === 1) {
        if (10 * this.pageIndex[0] < this.total[0]) {
          // this.pageIndex1 += 1;
          // console.log(11)
          this.busy = true;
          this.pageIndex[0] += 1;
          this.more = true;
          this.getNotice();
        } else {
          this.more = false;
        }
      } else {
        if (10 * this.pageIndex[1] < this.total[1]) {
          // this.pageIndex1 += 1;
          // console.log(11)
          this.busy = true;
          this.pageIndex[1] += 1;
          this.more = true;
          this.getNotice();
        } else {
          this.more = false;
        }
      }
      // this.pageIndex += 1;
      // if (10 * this.pageIndex < this.total) {
      //   this.busy = true;
      //   this.pageIndex += 1;
      //   this.more = true;
      //   this.getNotice();
      // }

    }
  }
};
</script>

<style lang="less">
.property-notice {
  padding: 20px 16px;
  width: 100%;
  position: absolute;
  height: 100%;
  overflow-y: hidden;
  /*.menu{*/
  /*  position: fixed;*/
  /*  padding:20px 0;*/
  /*}*/
  .scroll-content{
    width: 100%;
    height: 100%;
    // padding: 20px 16px;
    // position: absolute;
    // left: 0;
    // top: 0;
    overflow-y: scroll;
  }

  .tabDiv {
    height: calc(100% - 55px);
    .van-tabs{
      height: 100%;
      .van-tabs__content{
        height: 100%;
        padding-top: 72px;
      }
    }
    .van-tab__pane{
      height: 100%;
    }
    .van-tabs--line .van-tabs__wrap{
      height: 72px;
      width:calc(100% - 32px);
      position: fixed;
      left: 16px;
      z-index:1;
      background: #ffffff;
      /*padding: 16px 16px 0 16px;*/
    }
    .van-tab__pane-wrapper--inactive{
      overflow: hidden;
    }
    .van-tabs__content--animated{
      overflow: inherit;
    }
    .van-tabs__nav--line{
      width: 100%;
      height: 56px;
      background: rgba(0, 0, 0, 0.03);
      border-radius: 28px;
      padding-bottom: 0;
    }
    .van-tabs__line{
      width: calc(50% - 8px);
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
      z-index: 2;
      font-weight: 500;
      color: #E8374A;
    }

  }


  .list:last-child{
    margin-bottom: 0;
  }
  .list {
    padding: 18px 16px;
    border-radius: 5px;
    position: relative;
    margin-bottom: 20px;
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
      word-break: break-all;
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
