<template>
  <div class="property_notice_detail">
    <div class="details">
      <div style="padding: 20px 0">
        <p class="address">{{ this.$route.query.address }}</p>
        <p class="address2">{{ this.$route.query.address2 }}</p>
      </div>
      <van-divider
        dashed
        style="margin: 0 auto; width: 301px; padding-bottom: 20px"
      ></van-divider>
      <!-- <ul class="clearfix" style="position: relative;">
      <li class="demo right-circle"></li>
      <li class="demo"></li>
      <li></li>
    </ul> -->
      <van-tabs type="card" v-model="active">
        <van-tab title="基本信息">
          <ul style="margin-top: 20px">
            <li v-for="(item, index) in datas1" :key="index">
              <div class="beita">
                <div class="rightbei">{{ item.name }}</div>
                <div class="leftbei">{{ item.id }}</div>
              </div>
            </li>
          </ul>
        </van-tab>
        <van-tab title="住户信息">
          <householdinformation
            :active1="active"
            @hellobe="hellobe11"
          ></householdinformation>
        </van-tab>
        <van-tab title="其他信息">
          <otherinformation></otherinformation>
        </van-tab>
      </van-tabs>
    </div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
import householdinformation from "@/components/householdinformation.vue";
import otherinformation from "@/components/otherinformation.vue";
import api from "@/api";
/*import { CellGroup } from 'vant';*/
export default {
  mounted() {
    nav.setNavTitle({
      title: "房产详情",
      titleColor: "#000000",
      titleSize: 18
    });
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
      __event__: () => {
      },
    })
    .then(() => {});
  },
  name: "PropertyNoticeDetail",
  components: {
    householdinformation,
    otherinformation,
  },
  data() {
    return {
      active: 0,
      datas1: [
        {
          name: "分期",
          id: "1期",
        },
        {
          name: "所属楼栋",
          id: "1期",
        },
        {
          name: "单元",
          id: "1期",
        },
        {
          name: "楼层",
          id: "1期",
        },
        {
          name: "房号",
          id: "1期",
        },
        {
          name: "物业面积m²",
          id: "1期",
        },
        {
          name: "实际交付",
          id: "1期",
        },
        {
          name: "实际收楼",
          id: "1期",
        },
        {
          name: "实体状态",
          id: "1期",
        },
        {
          name: "业态",
          id: "1期",
        },
      ],
    };
  },
  created() {
    // 房屋基本信息参数spaceId
    const oder = { spaceId: this.$route.query.idr };
    // const oder={spaceId:2206329166721191013}
    // const oder={spaceId:2206329166721191013}
    api.houseroom(oder).then((res) => {
      console.log(res);
    });
    console.log(this.$route.query.name);
    console.log(this.$route.query.id);
    console.log(this.active);
    console.log(this.$store.state.user.active);
    this.active = this.$store.state.user.active;
  },
  methods: {
    onClickLeft() {
      this.$router.go(-1);
      this.$store.commit("setactive", 0);
    },
    hellobe11(data) {
      console.log(data, 123456);
      this.active = data;
      console.log(this.active);
      window.localStorage.setItem("SD_SETACTIVE", this.active);
      this.$store.commit("setactive", this.active);
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
.van-tabs--card > .van-tabs__wrap {
  height: 100%;
}
.van-tab__text--ellipsis {
  font-size: 16px;
  font-family: PingFangSC-Regular, PingFang SC;
  font-weight: 400;
  line-height: 22px;
  text-shadow: 0px 2px 30px rgba(71, 77, 96, 0.06);
}
.van-tabs__nav--card .van-tab.van-tab--active {
  color: red;
  background-color: #fff;
}
.van-tabs__nav--card {
  height: 56px;
  border: 0px;
  background: rgba(0, 0, 0, 0.03);
  padding: 5px;
  border-radius: 28px;
}
.van-tabs__nav--card .van-tab {
  color: #333;
  border-right: none;
  // padding:12px 15px 13px 15px;
}
.van-nav-bar {
  height: none;
}
.van-nav-bar .van-icon {
  color: #121212;
}
.van-tabs__nav--line {
  background: rgba(0, 0, 0, 0.03);
  border-radius: 28px;
  padding: 5px;
  box-sizing: border-box;
}
.van-tab--active {
  background: #ffffff;
  box-shadow: 0px 2px 30px 0px rgba(71, 77, 96, 0.06);
  border-radius: 25px;
}
.van-tabs__line {
  background-color: #fff;
  display: none;
}
.property_notice_detail {
  width: 100%;
  height: auto;
  // padding: 29px 16px 20px 16px;
  .van-nav-bar {
    // padding: 55px 236px 23px 16px;

    // box-shadow: 0px 5px 10px 0px rgba(0, 64, 128, 0.04);
    .van-nav-bar .van-icon {
      font-size: 24px;
      font-family: PingFangSC-Medium, PingFang SC;
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
  }
  .details {
    padding: 16px;
  }
  .address {
    font-size: 24px;
    font-family: PingFangSC-Medium, PingFang SC;
    font-weight: 500;
    color: #121212;
    line-height: 33px;
    text-align: center;
    margin: 0;
  }
  .address2 {
    font-size: 14px;
    font-family: PingFangSC-Regular, PingFang SC;
    font-weight: 400;
    color: #666666;
    line-height: 20px;
    text-align: center;
    margin: 5px 0 0 0;
  }
  .beita {
    display: flex;
    background: #ffffff;
    box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
    padding: 16px;
    margin-bottom: 10px;
    .rightbei {
      flex: 5;
      font-size: 15px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #9b9b9b;
      line-height: 20px;
    }
    .leftbei {
      flex: 1;
      font-size: 15px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #121212;
      line-height: 20px;
    }
  }
  .clearfix li {
      list-style: none;
      float: left;
      margin: 0 0 0 20px;
      text-align: center;
    }
    li {
      background: #C1C1CA;
    }
  .clearfix{zoom:1;    top: -82px;/*为IE6，7的兼容性设置*/}
    .clearfix:after {
      content: '.';
      display: block;
      height: 0;
      clear: both;
      visibility: hidden;
    }
  .demo { /*左半圆*/
      position:absolute; /*clip 属性剪裁绝对定位元素。也就是说，只有 position:absolute 的时候才是生效的。*/
      width: 22px;
      height: 22px;
      border-radius: 50px;
          right: -0.6rem;
      /* line-height: 50px; */
      clip: rect(0px 11px 22px 0px); /*唯一合法的形状值是：rect (top, right, bottom, left)*/
    }
    .right-circle { /*右半圆*/
      left: -1rem;
      clip: rect(0px 22px 22px 11px); /*唯一合法的形状值是：rect (top, right, bottom, left)*/
    }
}
</style>
