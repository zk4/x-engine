<template>
  <div class="property_notice">
    <div class="Community">
      <van-dropdown-menu>
        <van-dropdown-item
          v-model="value1"
          :options="option1"
          @change="add($event)"
        />
      </van-dropdown-menu>
    </div>
    <div>
      <div class="default-content" v-if="showCard_list && datas.length === 0">
        <div class="container">
          <span class="default-icon"></span>
          <p>您还没有房产档案信息哦~</p>
        </div>
      </div>
    </div>
    <ul
      class="top_k"
      v-infinite-scroll="loadMore"
      infinite-scroll-disabled="busy"
      infinite-scroll-distance="10"
    >
      <li
        class="li_op"
        v-for="(item, index) in filterBy(datas, value)"
        :key="index"
        @click="turn_detail(index, item)"
      >
        <div class="tabled">
          <div class="Inside">
            <div class="rightbox" style="flex: 3">
              <span class="rightboxfinz">{{ item.buildingName }}</span>
              <span
                v-html="brightenKeyword(item.roomName, value)"
                class="rightboxfinz"
              ></span>
              <div class="rightboxfine">{{ item.blockName }}</div>
            </div>
            <div
              class="leftbox"
              style="
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                line-height: 45px;
              "
            >
              {{ item.value }}
            </div>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
const cardIcon = require("../../assets/img/searchfor.png");

import nav from "@zkty-team/x-engine-module-nav";
import api from "@/api";
export default {
  name: "PropertyNotice",
  components: {},
  created() {
    this.old();
  },
  data() {
    return {
      showCard_list: false,
      busy: false,
      moreList: [],
      i: 0,
      pageSize: 10,
      pageIndex: 1,
      totalnum:'',
      value: "",
      isShow: true,
      isShow2: true,
      value1: -1,
      option1: [{ text: "全部", value: -1, id: 2206329166721191006 }],
      datas: [],
      urlimg:cardIcon
    };
  },
  watch: {
    ownerList: {
      handler(newVal) {
        console.log("ownerList newVal :>> ", newVal);
      },
      immediate: true, //刷新加载 立马触发一次handler
      deep: true, // 可以深度检测到 person 对象的属性值的变化
    },
  },
  mounted() {
    //搜索框数据
    let searchnavArg = {
      cornerRadius: 5,
      backgroundColor: "#D8D8D8",
      iconSearch: "",
      iconSearchSize: [20, 20],
      iconClear: "",
      iconClearSize: [20, 20],
      textColor: "#000000",
      fontSize: 16,
      placeHolder: "默认文字",
      placeHolderFontSize: 16,
      isInput: true,
      becomeFirstResponder: false,
      __event__: (i) => {
        this.value = i;
      },
    };
    //left数据
    let leftbtn = {
      title: "房产档案",
      titleColor: "#000000",
      titleSize: 24,
      titleBig: 500,
    };
    //left为空数据
    let leftunbtn = {
      title: " ",
      titleColor: "#000000",
      titleSize: 24,
      titleBig: 500,
    };
    //right数据
    let rightbtn = {
      title: "right",
      titleColor: "#000000",
      titleSize: 16,
      icon: "urlimg",
      iconSize: ["20", "20"],
    };
    //取消数据
    let rightunbtn = {
      title: "取消",
      titleColor: "#000000",
      titleSize: 16,
      icon: "",
      iconSize: ["20", "20"],
    };
    //左边文字
    nav.setNavLeftBtn({
      ...leftbtn,
    });
    leftobtn();
    function leftobtn() {
      //点击right
      nav.setNavRightBtn({
        ...rightbtn,
        __event__: () => {
          //点击right显示搜索框
          nav.setNavSearchBar({ ...searchnavArg });
          //点击rightleft换位空
          nav.setNavLeftBtn({
            ...leftunbtn,
          });
          rightobtn();
        },
      });
    }
    // rightobtn()
    var that = this;
    function rightobtn() {
      //right换成取消
      nav.setNavRightBtn({
        ...rightunbtn,
        __event__: () => {
          //点击取消value为空
          that.value = [];
          //搜索框隐藏
          nav.setSearchBarHidden({
            isHidden: true,
            isAnimation: false,
          });
          //left为房产档案
          nav.setNavLeftBtn({
            ...leftbtn,
          });
          leftobtn();
        },
      });
    }
  },
  methods: {
    addNotie() {
      console.log(123);
    },
    //滚动条到底部加载数据
    loadMore() {
     if(this.pageIndex * this.pageSize <this.totalnum){
      console.log("我执行了"+this.pageIndex)
      var _vm = this;
      this.busy = true;
      _vm.i += 1;
      this.pageIndex+=1;
      const para = {
        pageIndex: this.pageIndex,
        pageSize: this.pageSize,
        projectId: "2206329166721191006",
      };
      api.houselist(para).then((res) => {
        _vm.moreList = res.data.records;
        if (_vm.moreList.length == 0) {
          _vm.busy = true;
        } else {
          _vm.moreList.forEach(function (item) {
            _vm.datas.push(item);
          });
        }
      });
      this.busy = false;
     }
    },
    //搜索高亮
    brightenKeyword(val, keyword) {
      // 方法2：用正则表达式
      const Reg = new RegExp(keyword, "i");
      if (val) {
        const res = val.replace(
          Reg,
          `<span style="color: #E8374A;">${keyword}</span>`
        );
        return res;
      }
    },

    old() {
      this.showCard_list = false;
      const para = {
        pageIndex: "1",
        pageSize: this.pageSize,
        projectId: "2206329166721191006",
      };
      this.$toast.loading({
        duration: 0, // 持续展示 toast
        forbidClick: true,
        message: "加载中...",
      });
      //下拉菜单
      let value = 0;
      api.houseject().then((res) => {
        // console.log(res);
        for (let v of res.data) {
          v.value = value++;
          v.text = v.projectName;
          this.option1.push(v);
        }
      });
      //数据展示
      api
        .houselist(para)
        .then((res) => {
          console.log(res.data.total);
          this.totalnum=res.data.total
          if (res.code == 200) {
            if (res.data == []) {
              this.showCard_list = false;
            } else {
              this.showCard_list = true;
              this.$toast.clear();
            }
            for (let v of res.data.records) {
              this.datas.push(v);
            }
          } else {
            this.showCard_list = false;
            this.$toast.fail(res.msg);
          }
        })
        .finally(() => {
          // this.loading_xs=false
          this.$toast.clear();
        });
      console.log(this.datas, "第一次执行");
    },
    onClickLeft() {
      this.$router.go(-1);
    },
    onClickRight() {
      this.isShow = false;
      this.isShow2 = true;
    },
    onSearch() {
      console.log(789);
    },
    onCancel() {
      this.isShow = true;
      this.isShow2 = false;
    },
    filterBy(customers, inputvalue) {
      return customers.filter((datas) => {
        if (datas.roomName.indexOf(inputvalue) !== -1) {
          //判断这个字段中是否包含keyword
          //如果包含的话，就把这个字段中的那一部分进行替换成html字符
          datas.roomName.replace(
            inputvalue,
            `<font color='#42cccc'>${inputvalue}</font>`
          );
        }
        return datas.roomName.match(inputvalue);
      });
    },
    add(event) {
      this.showCard_list = false;
      // console.log(this.option1[event].id);
      console.log(this.option1[event + 1]);
      //根据下拉菜单的id拉取循环数据
      const para = {
        pageIndex: "1",
        pageSize: 10,
        projectId: this.option1[event + 1].id,
      };
      this.$toast.loading({
        duration: 0, // 持续展示 toast
        forbidClick: true,
        message: "加载中...",
      });
      //数据展示
      this.datas = [];
      api
        .houselist(para)
        .then((res) => {
          console.log(res.data.records);
          if (res.code == 200) {
            if (res.data == []) {
              this.showCard_list = false;
            } else {
              this.showCard_list = true;
            }
            for (let v of res.data.records) {
              this.datas.push(v);
            }
          } else {
            this.showCard_list = false;
          }
        })
        .finally(() => {
          this.loading_xs = false;
          this.$toast.clear();
        });
      console.log(this.datas);
    },
    turn_detail(index, item) {
      console.log(index, item);
      nav.navigatorPush({
        url: "/Property_Detail",
        params: encodeURI(
          `name=${item.blockName}&id=${item.buildingName + item.roomName}&idr=${
            item.id
          }`
        ),
      });
    },
  },
};
</script>


<style lang="less" scope>
.scroll-content {
  width: 100%;
  height: 100%;
  padding: 2.2rem 0.32rem 0.4rem 0.32rem;
  position: absolute;
  left: 0;
  top: 0;
  overflow-y: auto;
}
.li_op {
  margin-bottom: 10px;
}
.top_k {
  //固定定位
  padding-top: 64px;
}
.van-dropdown-menu__bar {
  box-shadow: none;
  //固定定位
  position: fixed;
  width: 100%;
  // margin-top: 27px;
}
.van-nav-bar {
  height: -webkit-fill-available;
}
.van-nav-bar .van-icon {
  color: red;
}
.van-icon-arrow-left::before {
  color: black;
}
.van-nav-bar__text {
  font-size: 24px;
  font-family: PingFangSC-Medium, PingFang SC;
  font-weight: 500;
  color: #121212;
  line-height: 24px;
}
.title {
  height: 102px;
  padding: 55px 0 23px 0;
  box-shadow: 0px 5px 10px 0px rgba(0, 64, 128, 0.04);
}
.van-search {
  padding: 0 0;
  height: inherit;
}
.van-search__content {
  background-color: #ffffff;
}
.van-search .van-cell {
  background-color: #f7f8fa;
  padding: 16px 16px 16px 16px;
  border-radius: 25px;
}
.van-field__right-icon .van-icon {
  height: 16px;
  line-height: initial;
}
.van-field__left-icon .van-icon {
  height: 16px;
  line-height: initial;
}
.van-cell__value--alone {
  height: 16px;
}
.van-field__control {
  height: 16px;
}
.property_notice {
  width: 100%;
  height: auto;
  background: #ffffff;
}
.van-dropdown-menu__item {
  flex: inherit;
}
.van-dropdown-menu__title {
  padding: 0 9px 0 16px;
}
.van-nav-bar__left,
.van-nav-bar__right {
  padding: 0 15px;
}
.tabled {
  // margin: 0 16px 10px 16px;
  padding: 0 16px 10px 16px;
  box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
}
.Inside {
  padding: 25px 16px 20px 32px;
  //   height: 90px;
  display: flex;
}
.rightboxfinz {
  font-size: 18px;
  font-family: PingFangSC-Medium, PingFang SC;
  font-weight: 500;
  color: #121212;
  line-height: 20px;
  word-break: break-all;
}
.rightboxfine {
  font-size: 13px;
  font-family: PingFangSC-Regular, PingFang SC;
  font-weight: 400;
  color: #666666;
  line-height: 18px;
  margin-top: 7px;
}
.leftbox {
  font-size: 15px;
  font-family: PingFangSC-Regular, PingFang SC;
  font-weight: 400;
  color: #121212;
  line-height: 21px;
}
.van-ellipsis {
  font-size: 21px;
  font-family: PingFangSC-Medium, PingFang SC;
  font-weight: 500;
  color: #121212;
}
.van-dropdown-menu__title::after {
  border-color: transparent transparent #333 #333;
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
