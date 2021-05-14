<template>
  <div
    class="navigator-class"
    :style="style"
    :class="[
      bgImage == '' ? 'no-bg' : 'img-mode',
      isWhiteColor ? 'text-white' : 'text-black',
    ]"
    v-if="!isShowHeader"
  >
    <div class="title-wrapper">
      <!-- 左边 -->
      <div
        class="content-item-left"
        :style="{ lineheight: lineheight + 'px' }"
        @click="handlerLeftButton"
      >
        <slot name="left">
          <i class="iconfont icon-fanhui"></i>
          <div class="nav-title" v-if="!textIsCenter">
            <span class="left-text-color">{{ navTitle }}</span>
          </div>
        </slot>
      </div>

      <!-- 中间 -->
      <div class="content-item-center" :style="{ lineheight: lineheight + 'px' }">
        <slot name="center">
          <div v-if="textIsCenter" class="nav-title">{{ navTitle }}</div>
        </slot>
      </div>

      <!-- 右边 -->
      <div class="content-item-right" :style="{ lineheight: lineheight + 'px' }">
        <slot name="right"></slot>
      </div>
    </div>
  </div>
</template>

<script>
import XEngine from "@zkty-team/x-engine-core";
export default {
  name: "HEADER",
  data() {
    return {
      lineheight: "",
      bgColor: "",
      navTitle: "首页",
      bgImage: "",
      isShowHeader: false,
      // false 默认靠左
      // true  居中
      textIsCenter: false,
      // false 黑色
      // true  白色
      isWhiteColor: false,
    };
  },
  computed: {
    style() {
      var navigationBar = this.lineheight;
      var style = `height:${navigationBar}px;`;
      if (this.bgImage) {
        style = `${style}background-image:url(${this.bgImage});`;
      } else if (this.bgColor) {
        style = `${style}background:${this.bgColor};`;
      }
      return style;
    },
    textStyle() {
      var textColor = `color:${this.textColor};`;
      return textColor;
    },
  },
  mounted() {
    if (XEngine.platform.isPc) {
      this.lineheight = 64;
    } else {
      let statusBarHeight = XEngine.api("com.zkty.jsi.device", "getStatusBarHeight");
      let navheight = XEngine.api("com.zkty.jsi.device", "getNavigationHeight");
      if (navheight == undefined && statusBarHeight == undefined) {
        this.lineheight = 64;
      } else {
        let height = Number(statusBarHeight) + Number(navheight);
        this.lineheight = height;
      }
    }
  },
  methods: {
    handlerLeftButton() {
      // 返回指定页面
      if (this.$route.meta.backPath != undefined) {
        var path = this.$route.meta.backPath;
        this.$router.go(path);
      } else {
        // 返回上一页
        this.$router.go(-1);
      }
    },
  },
  watch: {
    $route(to) {
      // 文字
      if (to.meta.hasOwnProperty("title")) {
        if (to.query.hasOwnProperty("changeNavTitle")) {
          this.navTitle = to.query.changeNavTitle;
        } else {
          this.navTitle = to.meta.title;
        }
      } else {
        this.navTitle = "请在router配置title信息";
      }

      // 图片
      if (to.meta.customBgcImg) {
        this.bgImage = to.meta.customBgcImg;
      } else {
        this.bgImage = "";
      }

      // 背景色
      if (to.meta.bgColor) {
        this.bgColor = to.meta.bgColor;
      } else {
        this.bgColor = "";
      }

      // 是否显示header
      if (to.meta.isShowHeader == undefined) {
        this.isShowHeader = false;
      } else {
        this.isShowHeader = to.meta.isShowHeader;
      }

      // 文字靠左还是靠右
      if (to.meta.textIsCenter == undefined) {
        this.textIsCenter = false;
      } else {
        this.textIsCenter = to.meta.textIsCenter;
      }

      // 文字颜色
      if (to.meta.isWhiteColor == undefined) {
        this.isWhiteColor = false;
      } else {
        this.isWhiteColor = true;
      }
    },
  },
};
</script>

<style>
.navigator-class {
  top: 0;
  width: 100%;
  z-index: 999;
  position: fixed;
}

.title-wrapper {
  position: absolute;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  bottom: 8px;
  width: 100%;
}

.nav-title {
  display: flex;
  align-items: center;
  font-size: 20px;
  font-weight: 600;
}

.content-item-left {
  text-align: left;
  display: flex;
  text-align: center;
  flex: 0.4;
}

.content-item-center {
  text-align: center;
}

.content-item-right {
  text-align: right;
  flex: 0.4;
}

.left-text-color {
  margin-left: 10px;
}

.text-white {
  color: #fff;
}

.text-black {
  color: #000;
}

.img-mode {
  background-size: 100% 100%;
}

.no-bg {
  background-color: #fff;
}

span {
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

div {
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

@font-face {
  font-family: "iconfont";
  src: url("data:application/font-woff;charset=utf-8;base64,d09GRgABAAAAAAQ4AA0AAAAABlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABGRlRNAAAEHAAAABoAAAAcjvZa/0dERUYAAAP8AAAAHgAAAB4AKQAKT1MvMgAAAaQAAABCAAAAVjyvSDNjbWFwAAAB+AAAAD4AAAFCAA/p7Gdhc3AAAAP0AAAACAAAAAj//wADZ2x5ZgAAAkQAAABEAAAARG6fs/RoZWFkAAABMAAAADEAAAA2HEN382hoZWEAAAFkAAAAHQAAACQGiQOFaG10eAAAAegAAAAQAAAAEAwAAShsb2NhAAACOAAAAAoAAAAKACIAAG1heHAAAAGEAAAAHwAAACABDwAdbmFtZQAAAogAAAFJAAACiCnmEVVwb3N0AAAD1AAAAB8AAAAxy4Fu3njaY2BkYGAA4g9PvtyO57f5ysDNwgACd1ZK/obRjBoMGkyrmW4AuRwMTCBRAHxqDGgAAAB42mNgZGBgbvjfwBDDwgACTKsZGBlQAQsAU5MDFgAAAHjaY2BkYGBgYRBkANEMDExAzAWEDAz/wXwGAAp2AS0AeNpjYGRhYJzAwMrAwNTJdIaBgaEfQjO+ZjBi5ACKMrAyM2AFAWmuKQwOzxyfOTI3/G9giGFuYGgACjOC5ADk5QxdAAAEAAAAAAAAAAQAAAAEAAEoeNpjYGBgZoBgGQZGBhCwAfIYwXwWBgUgzQKEQP4zx///IaTkIahKBkY2BhiTgZEJSDAxoAJGhmEPAIP8B+EAAAAAAAAAAAAAACIAAAABASgAKAKrAtgAEAAACQEWFAYiJwEmNDcBNjIWFAcBjwEPDRoiDf7SDAwBLg0iGg0BgP7xDiEaDAEuDSINAS4MGiEOeNp9kD1OAzEQhZ/zByQSQiCoXVEA2vyUKRMp9Ailo0g23pBo1155nUg5AS0VB6DlGByAGyDRcgpelkmTImvt6PObmeexAZzjGwr/3yXuhBWO8ShcwREy4Sr1F+Ea+V24jhY+hRvUf4SbuFUD4RYu1BsdVO2Eu5vSbcsKZxgIV3CKJ+Eq9ZVwjfwqXMcVPoQb1L+EmxjjV7iFa2WpDOFhMEFgnEFjig3jAjEcLJIyBtahOfRmEsxMTzd6ETubOBso71dilwMeaDnngCntPbdmvkon/mDLgdSYbh4FS7YpjS4idCgbXyyc1d2oc7D9nu22tNi/a4E1x+xRDWzU/D3bM9JIbAyvkJI18jK3pBJTj2hrrPG7ZynW814IiU68y/SIx5o0dTr3bmniwOLn8owcfbS5kj33qBw+Y1kIeb/dTsQgil2GP5PYcRkAAAB42mNgYoAALjDJyIAOWMCiTIxMbGmJeRmlmQALcgKZAAAAAAH//wACAAEAAAAMAAAAFgAAAAIAAQADAAMAAQAEAAAAAgAAAAB42mNgYGBkAIKrS9Q5QPSdlZK/YTQAQkMG3AAA")
    format("woff");
  font-weight: 900;
  font-style: normal;
  font-display: swap;
}

.iconfont {
  font-family: "iconfont" !important;
  font-size: 25px;
  padding-top: 3px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.iconfont-white {
  font-family: "iconfont" !important;
  font-size: 25px;
  padding-top: 3px;
  font-style: normal;
  color: #fff;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.icon-fanhui:before {
  content: "\e641";
  padding-left: 10px;
}
</style>
