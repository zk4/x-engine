<template>
  <div :class="tag === 1 ? 'my-family my-family-pa' : 'my-family'">
    <ul class="my-property-list">
      <div class="my-family-header">
        <span class="myfam-header-icon"></span>
        <span class="header-title">{{ title }}</span>
      </div>
      <van-swipe-cell @open="open" @close="close" :class="opacity" v-for="item in data" :key="item.custId">
        <li>
          <span class="pro-list-icon"></span>
          <div class="pro-list-text">
            <p>{{ item.custName }}</p>
            <p>+{{ item.phoneAreaCode + " " + item.phone }}</p>
          </div>
          <span class="pro-list-tag">{{ customerRoomType[item.personType] }}</span>
        </li>
        <template #right>
          <van-button square type="danger" text="删除" />
        </template>
      </van-swipe-cell>
    </ul>
    <div class="subbottom-content" v-if="tag === '1'">
      <van-button class="sub-button" type="primary" color="#E8374A" @click="addFamily">添加成员</van-button>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";

export default {
  name:"MyFamily",
  components: {
    
  },
  data () {
    return {
      data: "",
      customerRoomType: ["","业主","租户","商户","前期管理费单位","家人","朋友"],
      title: this.$route.query.title,
      tag: this.$route.query.tag,
      opacity: "isOpacity"
    }
  },
  created() {
    nav.setNavLeftBtn({ title: "我的家庭", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    this.getCustomerList();
  },
  methods: {
    getCustomerList() {
      const para = {
        roomId: this.$route.query.roomId
      };
      api.getCustomerList(para).then(res => {
        if (res.code === 200) {
          this.data = res.data;
          this.total = res.data.total;
        }
      }).catch(() => {
        this.tableLoading = false;
      }).finally(() => {
        this.tableLoading = false;
      });
    },
    addFamily() {
      this.$router.push({ path: "/addFamily", query: { roomId: this.$route.query.roomId, proId: this.$route.query.projectId } });
    },
    open() {
      this.opacity = "notOpacity";
    },
    close() {
      this.opacity = "isOpacity";
    }
  }
}
</script>


<style lang="less" scope>
.my-family-pa{
  padding: 20px 16px 98px 16px;
}
.my-family{
  width: 100%;
  height: auto;
  padding: 20px 16px 20px 16px;
  overflow: hidden;

  .my-property-list{
    width: 100%;
    .my-family-header{
      width: 100%;
      // height: 60px;
      padding: 21px 18px;
      background: #FFFFFF;
      box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
      border-radius: 16px;
      margin-bottom: 16px;
      font-size: 16px;
      font-family: PingFangSC-Regular, PingFang SC;
      color: #111111;
    }
    li{
      width: 100%;
      height: 82px;
      padding: 17px 16px;
      background: #fff;
      box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
      border-radius: 16px;
      display: flex;
      margin-bottom: 16px;
      position: relative;
      z-index: 9;

      .pro-list-icon{
        display: inline-block;
        width: 48px;
        height: 48px;
        background: url("../../assets/img/pro-list-icon.png") no-repeat;
        background-size: 100%;
        border-radius: 50%;
      }
      .pro-list-text{
        width: calc(100% - 114px);
        margin-right: 10px;
        p{
          margin: 0px;
        }
        p:nth-child(1){
          font-size: 18px;
          font-family: PingFangSC-Medium, PingFang SC;
          font-weight: 500;
          color: #121212;
          margin: 2px 0 0px 15px;
        }
        p:nth-child(2){  
          font-size: 14px;
          font-family: PingFangSC-Regular, PingFang SC;
          font-weight: 400;
          color: #8D8D8D;
          margin: 4px 0 0 15px;
        }
      }
      .pro-list-tag{
        display: inline-block;
        width: 46px;
        height: 18px; 
        background: #E3F0FF;
        border-radius: 0px 10px 0px 10px;
        font-size: 12px;
        font-family: PingFangSC-Medium, PingFang SC;
        font-weight: 500;
        color: #6192CD;
        text-align: center;
      }
    }
    .van-swipe-cell{
      // overflow: inherit;
    }
    .isOpacity{
      .van-swipe-cell__right{
        // opacity: 0;
      }
    }
    .van-swipe-cell__right{
      top: 19px;
      width: .78rem;
      height: 45px;
      background: #6192CD;
      // margin-right: 6px;
      border-radius: 0 8px 8px 0;
      box-shadow: 0px 0px 15px 0px rgba(0, 0, 0, 0.25);
      
      .van-button--danger{
        background: #6192CD;
        border: 0;
        width: 39px;
        border-radius: 0 8px 8px 0;
      }
    }
  }

  .sub-button{
    .van-button__text{
      color: #fff;
    }
  }
  

}
</style>