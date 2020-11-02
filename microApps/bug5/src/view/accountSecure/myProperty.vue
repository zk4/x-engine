<template>
  <div class="my-property">
    <ul class="my-property-list">
      <li v-for="item in data" :key="item.id" @click="turnFamily(item.roomId,item.roomAddress,item.customerRoomType,item.projectId)">
        <span class="pro-list-icon"></span>
        <div class="pro-list-text">
          <p v-if="item.roomName">{{ item.roomAddress }}</p>
          <p>{{ item.projectName }}</p>
        </div>
        <span class="pro-list-tag">{{ customerRoomType[item.customerRoomType] }}</span>
      </li>
      <div class="default-content" v-if="showDefault && data.length === 0">
        <div class="container">
          <span class="default-icon"></span>
          <p>您还没有房产信息哦~</p>
        </div>
      </div>
    </ul>
    <div class="subbottom-content">
      <van-button v-if="isShowRealName === 1" v-id="" class="sub-button" data-color="true" type="primary" color="#E8374A" @click="addProperty">添加房产</van-button>
    </div>
    <van-popup v-model="show" class="dia-pop-content">
      <div class="dia-pop">
        <div class="dia-pop-text">
          <div class="pop-text-header">暂无房产信息，请致电解决，服务热线<span class="phone-num">400-806-123</span></div>
        </div>
        <div class="pop-btn" @click="cancelPop">关闭</div>
      </div>
    </van-popup>
  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";

export default {
  name:"MyProperty",
  components: {
    
  },
  data () {
    return {
      data: [],
      isShowRealName: "",
      customerRoomType: ["","业主","租户","商户","前期管理费单位","家人","朋友"],
      pageIndex: 1,
      show: false,
      showDefault: false
    }
  },
  created() {
    nav.setNavLeftBtn({ title: "我的房产", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    this.getUserQuery();
    this.getRoomList();
  },
  methods: {
    turn_Ownercert(){
      this.$router.push({ path: "/owner_cert" })
    },
    cancelPop() {
      this.show = false;
    },
    getUserQuery() {
      api.getUserQuery().then(res => {
        if (res.code === 200) {
          this.isShowRealName = res.data.isShowRealName;
        }
      }).finally(() => {
      });
    },
    getRoomList() {
      const para = {
        dataType: 0,
        isShowAll: true,
        pageIndex: this.pageIndex,
        pageSize: 10,
        projectId: ""
      }
      api.getRoomList(para).then(res => {
        if (res.code === 200) {
          this.showDefault = true;
          if (res.data) {
            this.data = res.data.records;
          }
          console.log(res)
        }
      }).finally(() => {
      });
      // this.show = true;
    },
    turnFamily(id,title,tag,proId) {
      nav.navigatorPush({
        url: "/myFamily",
        params: encodeURI(
          `roomId=${id}&title=${title}&tag=${tag}&projectId=${proId}`
        ),
      });
      // this.$router.push({ path: "/myFamily",query: { roomId: id, title: title, tag: tag, projectId: proId} });
    },
    addProperty() {
      if (this.isShowRealName === 1) {
        nav.navigatorPush({
          url: "/ownerCert"
        });
        // this.$router.push({ path: "/ownerCert" });
      } else {
        this.show = true;
      }
    }
  }
}
</script>


<style lang="less" scope>
.my-property{
  width: 100%;
  height: auto;
  padding: 20px 16px 98px 16px;

  .my-property-list{
    width: 100%;
    li{
      width: 100%;
      height: 82px;
      padding: 17px 16px;
      background: #fff;
      box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
      border-radius: 16px;
      display: flex;
      margin-bottom: 16px;

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
          white-space: nowrap;
          overflow: hidden;
          text-overflow: ellipsis;
        }
        p:nth-child(2){  
          font-size: 14px;
          font-family: PingFangSC-Regular, PingFang SC;
          color: #121212;
          margin: 0px 0 0px 15px;
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
  }
  

}
</style>