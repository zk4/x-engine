<template>
  <div class="property_notice_detail">
    <div class="title">
    </div>
    <div class="biang">
      <div class="box-u">
      <!-- <ul>
        <li v-for="(item, index) in arr" :key="index">
          <div class="liold">旧业主：{{item.oldCustomerName}} {{item.oldCustomerMobile}}</div>
        <div class="liold">新业主：{{item.newCustomerName}} {{item.newCustomerMobile}}</div>
        <div class="liold">过户时间：{{item.transferDate}}</div>
        <div class="liold">过户原因：卖房</div>
        </li>
      </ul> -->
      <ul>
        <li class="liold">旧业主：张斯斯 13431122345</li>
        <li class="liold">新业主：李漂亮 13431109875</li>
        <li class="liold">过户时间：2020-08-23 12:1</li>
        <li class="liold">过户原因：卖房</li>
      </ul>
      <img class="yimg" src="../../assets/transfer.png" alt="" />          
      </div>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";
export default {
  name: "PropertyNoticeDetail",
  mounted() {
    nav.setNavTitle({
      title: "业主变更",
      titleColor: "#000000",
      titleSize: 18
    });
    },
  components: {},
  data() {
    return {
      active: 0,
      arr: [],
    };
  },
  created() {
    const mationface = {
      midObjcetSpaceId: "",
      objectId: "41281631CF594497A8441861518DFEA4",
    };
    api.housetoken(mationface).then((res) => {
      for (let i of res.data) {
        console.log(i);
        // this.arr.push(i);
      }
    });
    console.log(this.arr);
  },
  methods: {
    onClickLeft() {
      this.$router.go(-1);
      this.$store.commit("setactive", 3);
    },
  },
};
</script>


<style lang="less" scope>
.title {
  height: 102px;
  padding: 55px 0 23px 0;
  box-shadow: 0px 5px 10px 0px rgba(0, 64, 128, 0.04);
}
.van-nav-bar .van-icon {
  font-size: 24px;
  font-weight: 500;
  color: #121212;
  line-height: 24px;
}
.van-nav-bar__text {
  font-size: 24px;
  font-family: PingFangSC-Medium, PingFang SC;
  font-weight: 500;
  color: #121212;
  line-height: 24px;
}
.property_notice_detail {
  width: 100%;
  height: auto;
  
  .biang {
    position: relative;
    background: #ffffff;
    box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
    padding: 16px;
    .box-u{
padding: 26px 0 21px 32px;
    }
    .yimg {
      position: absolute;
      right: 0;
      bottom: 0;
    }
    .liold {
      font-size: 15px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #121212;
      line-height: 20px;
      margin-bottom: 10px;
    }
  }
}
</style>
