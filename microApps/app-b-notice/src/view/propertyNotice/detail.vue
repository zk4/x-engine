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
      a:"12221"
    }
  },
  mounted() {
    nav.setNavLeftBtn({ title: "公告详情hello", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
                nav.setNavRightMenuBtn({
                  title: "操作hello",
                  titleColor: "#000000",
                  titleSize: 14,
                  icon: "",
                  iconSize: ["20", "20"],
                  popWidth: "96",
                  showMenuImg: "false",
                  popList: [
                    { icon: "", iconSize: "14", title: "编辑" },
                    { icon: "", iconSize: "14", title: "删除" },
                  ],
                  __event__: (r) => {
                    console.log("hello"+r)
                    },
                }).then(()=>{})

  },
  created() {
  },
  activated(){
    nav.setNavLeftBtn({ title: "公告详情", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
  },
  methods: {
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
