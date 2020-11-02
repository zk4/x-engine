<template>
  <div class="owner-cert-success">
    <div class="scroll-content" v-infinite-scroll="loadMore" infinite-scroll-throttle-delay="500" infinite-scroll-disabled="busy" infinite-scroll-distance="300">
      <div class="cert-success-header">
        <p>业主认证成功</p>
        <p>检测到{{ cardNo }}有以下房产</p>
      </div>
      <ul class="my-property-list">
        <li v-for="item in datas" :key="item.id">
          {{ item.projectName }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";

export default {
  name:"OwnerCertSuccess",
  components: {
    
  },
  data () {
    return {
      cardNo: this.$route.query.cardNo,
      datas: [],
      busy: false,
      total: "",
      pageIndex: 1,
      more: false
    }
  },
  mounted () {
    this.cardNo = this.$route.query.cardNo.substr(0, 4) + "**********" + this.$route.query.cardNo.substr(15, 3);
    // this.cardNo = this.$route.query.cardNo.replace(/(?<=\d{4})\d+(?=[\dX]{3})/,"***********");
  },
  created() {
    nav.setNavLeftBtn({ title: "账号与安全", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    this.getRoomList();
  },
  methods: {
    loadMore: function() {
      if (10 * this.pageIndex < this.total) {
        this.busy = true;
        this.more = true;
        this.pageIndex += 1;
        this.getRoomList();
      }
      
    },
    getRoomList() {
      const para = {
        dataType: 1,
        isShowAll: true,
        pageIndex: this.pageIndex,
        pageSize: 10,
        projectId: ""
      }
      api.getRoomList(para).then(res => {
        if (res.code === 200) {
          console.log(res)
          this.total = res.data.total;
          this.datas = this.datas.concat(res.data.records)
          if (this.more && res.data.records.length > 0) {
            this.busy = false;
          }
          // this.$forceUpdate();
          console.log(this.datas)
        }
      }).finally(() => {
      });
    }
  }
}
</script>


<style lang="less" scope>
.owner-cert-success{
  width: 100%;
  height: 100%;
  padding: 110px 16px 20px 16px;
  position: absolute;

  .scroll-content{
    width: 100%;
    height: 100%;
    padding: 2.2rem 0.32rem 0rem 0.32rem;
    position: absolute;
    left: 0;
    top: 0;
    overflow-y: auto;
  }

  .cert-success-header{
    width: 100%;
    background: #fff;
    padding: 17px 16px 0 16px;
    height: 90px;
    position: fixed;
    top: 0;
    left: 0;

    p{
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #8D8D8D;
      margin: 0;
    }
    p:nth-child(1){
      font-size: 18px;
      margin-bottom: 10px;
    }
    p:nth-child(2){
      font-size: 14px;
    }
  }

  .my-property-list{
    height: 100%;
    .scroll-content{
      height: 100%;
      padding: 0;
      position: relative;
    }
    li{
      width: 100%;
      padding: 18px 16px;
      background: #FFFFFF;
      margin-bottom: 12px;
      box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
      border-radius: 16px;
      font-size: 18px;
      font-family: PingFangSC-Medium, PingFang SC;
      font-weight: 500;
      color: #121212;
    }
  }

}
</style>