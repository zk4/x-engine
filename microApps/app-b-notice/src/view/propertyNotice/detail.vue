<template>
  <div class="property_notice_detail">
    <div class="title">
      <div>
        <span>{{ title }}</span>
        <span>{{a}}</span>
      </div>
      <div class="container" v-if="shot">
        <span>{{ typeName }}</span>
        <span>{{ createdAt ? moment(createdAt).format("YYYY/MM/DD") : "" }}</span>
      </div>
      <div class="container" v-else>
        <p>{{ typeName }}</p>
        <p>{{ moment(createdAt).format("YYYY/MM/DD")  }}</p>
      </div>
    </div>
    <div class="container">
      <template v-for="(items,index) in details">
        <van-image v-if="items.type === 'pic'" :src="items.content" fit="cover" :key="index">
          <template v-slot:loading>
            <van-loading type="spinner" size="20" />
          </template>
        </van-image>
        <div v-else class="text" :key="index">
          <span v-for="(item,index) in items.content.split(' ')" :key="index">
            <span>{{ execText(item) }}</span>
            <a v-if="linkLength(item) === 'true'" :href="execLink(item)"><span class="link-icon"></span>网页链接</a>
          </span>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import moment from "moment"
import nav from "@zkty-team/x-engine-module-nav";

export default {
  name:'PropertyNoticeDetail',
  components: {

  },
  data () {
    return {
      shot: true,
      arr: [],
      details: [],
      createdAt: "",
      title: "",
      typeName: "",
      a:"11"
    }
  },
  mounted() {
    nav.setNavLeftBtn({ title: "公告详情", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
  },
  created() {
    this.toast();
    this.getNoticeDetail();
  },
  activated(){
    this.toast();
    this.getNoticeDetail();
    nav.setNavLeftBtn({ title: "公告详情", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
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
    //获取详情
    getNoticeDetail() {
      const that = this;
      const para = {
        id: this.$route.query.id,
      };
      api.getNoticeDetail(para).then(res => {
        if (res.code === 200) {
          this.details = res.data.details;
          this.title = res.data.title;
          this.createdAt = res.data.createdAt;
          this.typeName = res.data.typeName;
          if (res.data.status === 0) {
            const that = this;
            nav.setNavRightMenuBtn({
              title: "操作",
              titleColor: "#000000",
              titleSize: 14,
              icon: "@/assets/img/operation.png",
              iconSize: ["20", "20"],
              popWidth: "96",
              showMenuImg: "false",
              popList: [
                { icon: "", iconSize: "14", title: "编辑" },
                { icon: "", iconSize: "14", title: "删除" },
              ],
              __event__: (r) => {
                if ( r === 0 ) {
                  nav.navigatorPush({
                    url: "/addNotice",
                    params: encodeURI(
                      `noticeId=${this.this.$route.query.id}`
                    ),
                  });
                } else {
                  that.$toast("撤回成功");
                  that.onDeleteNotice()
                }
              },
            })
          } else {

            nav
              .setNavRightMenuBtn({
                title: "menu",
                titleColor: "#000000",
                titleSize: 16,
                icon: "",
                iconSize: ["20", "20"],
                popWidth: "200",
                showMenuImg: "false",
                popList: [
                  { icon: "", iconSize: "20", title: "1" },
                  { icon: "", iconSize: "20", title: "2" },
                  { icon: "", iconSize: "20", title: "3" },
                ],
                __event__: (r) => {
                  // that.$toast("撤回成功"+r);
                  that.a = r
                },
              })
              .then(() => {});
          }
        }
      }).finally(() => {
        this.$toast.clear()
      });
    },
    //删除公告
    onDeleteNotice() {
      const para = {
        id: this.$route.query.id,
      };
      api.deleteNotice(para).then(res => {
        if (res.code === 200) {
          this.$toast("删除成功");
        }
      })
    },
    //撤回公告
    onRevocationNotice() {
      const para = {
        id: this.$route.query.id,
      };
      api.revocationNotice(para).then(res => {
        if (res.code === 200) {
          this.$toast("撤回成功");
        }
      })
    },
    execText(item) {
      const link_arr = /(http:\/\/|https:\/\/)((\w|=|\?|\.|\/|&|-)+)/g.exec(item);
      if (link_arr) {
        const link = link_arr[0];
        const text = item.split(link);
        return text[0];
      } else {
        return item;
      }
    },
    execLink(item) {
      const link_arr = /(http:\/\/|https:\/\/)((\w|=|\?|\.|\/|&|-)+)/g.exec(item);
      if (link_arr) {
        return link_arr[0];
      }
    },
    linkLength(item) {
      if (item.split(/(http:\/\/|https:\/\/)((\w|=|\?|\.|\/|&|-)+)/g.exec(item))[0].indexOf("http") >= 0) {
        return "true";
      } else {
        return "false";
      }
    }
  }
}
</script>


<style lang="less" scope>
.property_notice_detail{
  width: 100%;
  height: auto;
  padding: 29px 16px 20px 16px;

  .title{
    margin-bottom: 6px;

    span{
      font-size: 18px;
      font-family: PingFangSC-Medium, PingFang SC;
      font-weight: 500;
      color: #121212;
      word-break: break-all;
    }

    .container{
      font-family: PingFangSC-Regular;
      font-size: 14px;
      letter-spacing: -0.23px;
      line-height: 14px;
      margin-top: 10px;

      p{
        margin: 6px 0;
      }
      span,p{
        font-size: 14px;
        font-family: PingFangSC-Regular, PingFang SC;
        font-weight: 400;
        color: #717171;
      }
      span:nth-child(1){
        margin-right: 32px;
      }
    }
  }

  .container{
    img{
      display: block;
      width: 100%;
      height: 192px;
      margin-top: 20px;
    }

    .text{
      margin-top: 18px;
      font-family: PingFangSC-Regular;
      font-size: 14px;
      color: #8D8D8D;
      letter-spacing: -0.23px;
      line-height: 28px;
      a{
        color: #6192CD;
      }
      span{
        word-break: break-all;
      }
    }
    .link-icon{
      width: 16px;
      height: 16px;
      display: inline-block;
      position: relative;
      top: 2px;
      background: url("../../assets/img/link-icon.png");
      background-repeat: no-repeat;
      background-size: 100% 100%;
      margin: 0 2px 0 4px;
    }
  }
}
</style>
