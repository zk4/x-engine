<template>
  <div class="property_notice_detail">
    <div>
      <div class="default-content" v-if="showCard && arr.length === 0">
        <div class="container">
          <span class="default-icon"></span>
          <p>您还没有业主变更历史信息哦~</p>
        </div>
      </div>
    </div>
    <div class="biang" v-if="showCard && arr.length > 0">
      <div class="box-u">
        <ul>
          <li v-for="(item, index) in arr" :key="index">
            <div class="liold">
              旧业主：{{ item.oldCustomerName }} {{ item.oldCustomerMobile }}
            </div>
            <div class="liold">
              新业主：{{ item.newCustomerName }} {{ item.newCustomerMobile }}
            </div>
            <div class="liold">过户时间：{{ item.transferDate }}</div>
            <div class="liold">过户原因：卖房</div>
          </li>
        </ul>
        <img class="yimg" src="../../assets/transfer.png" alt="" />
      </div>
    </div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
import api from "@/api";
export default {
  name: "PropertyNoticeDetail",
  components: {},
  data() {
    return {
      // loading_cs:true,
      showCard: false,
      active: 0,
      arr: [],
    };
  },
  created() {
    this.housetoken_api();
  },
  mounted() {
    nav.setNavLeftBtn({
      title: "业主变更历史",
      titleColor: "#000000",
      titleSize: 24,
      titleFontName:'PingFangSC-Medium',
    });
  },
  methods: {
    housetoken_api() {
      this.showCard = false;
      const mationface = {
        midObjcetSpaceId: "",
        objectId: "41281631CF594497A8441861518DFEA4",
      };
      this.$toast.loading({
        duration: 0, // 持续展示 toast
        forbidClick: true,
        message: "加载中...",
      });
      api
        .housetoken(mationface)
        .then((res) => {
          console.log(res.code);
          if (res.code == 200) {
            if (res.data == []) {
              this.showCard = false;
            } else {
              this.showCard = true;
              this.$toast.clear();
            }
            for (let i of res.data) {
              console.log(i);
              this.arr.push(i);
            }
          } else {
            this.showCard = false;
            this.$toast.fail(res.msg);
          }
        })
        .finally(() => {
          // this.loading_cs = false;
          this.$toast.clear();
        });
      console.log(this.arr);
    },
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
    .box-u {
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
.default-content {
  width: 100%;
  height: 100%;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
  .container {
    margin-top: 0.8rem;
    .default-icon {
      width: 375px;
      height: 200px;
      margin-top: 100px;
      display: inline-block;
      background: url("../../assets/img/background.png");
      background-size: 100% 100%;
    }
    .add-btn {
      display: inline-block;
      padding: 6px 16px;
      font-size: 14px;
      font-family: PingFangSC-Medium, PingFang SC;
      font-weight: 500;
      color: #ffffff;
      background: #e7334a;
      border-radius: 8px;
    }
  }
}
</style>