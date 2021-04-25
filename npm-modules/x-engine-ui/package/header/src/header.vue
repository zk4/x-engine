<template>
  <div
    class="navigator-class"
    :style="style"
    :class="[bgImage==''?'text-black no-bg':'text-white img-mode']"
    v-if="!isShowHeader"
  >
    <div class="title-wrapper">
      <div
        class="content-item-left"
        :style="{ lineheight: lineheight + 'px' }"
        @click="handlerLeftButton"
      >
        <slot name="left">
          <i class="iconfont icon-fanhui"></i>
          <div  class="nav-title"
            v-if="!textIsCenter"
          >
          <span style="margin-left:10px;">{{ navTitle }}</span>

          </div>
        </slot>
      </div>

      <div class="content-item-center" :style="{ lineheight: lineheight + 'px' }">
        <slot name="center">
          <div v-if="textIsCenter" class="nav-title"
          >{{ navTitle }}</div>
        </slot>
      </div>
            <!-- :class="[bgImage==''?'content-item-left-span-black': 'content-item-left-span-white']" -->
      <div class="content-item-right" :style="{ lineheight: lineheight + 'px' }">
        <slot name="right"></slot>
      </div>
    </div>
  </div>
</template>

<script>
import XEngine from "@zkty-team/x-engine-core"
export default {
  name: "ZKTY-Header",
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
      textColor:"#000"
    }
  },
  computed: {
    style() {
      var navigationBar = this.lineheight
      var style = `height:${navigationBar}px;`
      if (this.bgImage) {
        style = `${style}background-image:url(${this.bgImage});`
      } else if (this.bgColor) {
        style = `${style}background:${this.bgColor};`
      }
      return style
    },
  },
  mounted() {
      console.log(this.navTitle)

    if (XEngine.isHybrid()) {
      if (XEngine.platform.isPhone) {
        let navheight = XEngine.api(
          "com.zkty.jsi.device",
          "getNavigationHeight"
        )
        this.lineheight = navheight
      } else if (XEngine.platform.isAndroid) {
        let statusBarHeight = XEngine.api(
          "com.zkty.jsi.device",
          "getStatusBarHeight"
        )
        let navheight = XEngine.api(
          "com.zkty.jsi.device",
          "getNavigationHeight"
        )
        let height = Number(statusBarHeight) + Number(navheight)
        this.lineheight = height
      }
    } else if (XEngine.platform.isPc) {
      const height = 64
      this.lineheight = height
    } else {
      const height = 64
      this.lineheight = height
    }
  },
  methods: {
    handlerLeftButton() {
      // 返回指定页面
      if (this.$route.meta.backPath != undefined) {
        var path = this.$route.meta.backPath
        this.$router.go(path)
      } else {
        // 返回上一页
        this.$router.go(-1)
      }
    },
  },
  watch: {
    $route(to) {
      // 文字
      if (to.meta.hasOwnProperty("title")) {
        if (to.query.hasOwnProperty("changeNavTitle")) {
          this.navTitle = to.query.changeNavTitle
        } else {
          this.navTitle = to.meta.title
        }
      } else {
        this.navTitle = "请在router配置title信息"
      }

      // 图片
      if (to.meta.customBgcImg) {
        this.bgImage = to.meta.customBgcImg
      } else {
        this.bgImage = ""
      }

      // 背景色
      if (to.meta.bgColor) {
        this.bgColor = to.meta.bgColor
      } else {
        this.bgColor = ""
      }

      // 是否显示header
      if (to.meta.isShowHeader == undefined) {
        this.isShowHeader = false;
      } else {
        this.isShowHeader = to.meta.isShowHeader;
      }

      // 文字靠左还是靠右
      alert(to.meta.textIsCenter)
      if (to.meta.textIsCenter == undefined) {
        this.textIsCenter = false;
      } else {
        this.textIsCenter = to.meta.textIsCenter;
      }

      // // 文字颜色
      // if (to.meta.textColor == undefined) {
      //   this.textColor = "#000";
      // } else {
      //   this.textColor = to.meta.textColor;
      // }
    },
  },
}
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
  /* left: 20px; */
  /* right: 20px; */
}

.content-item-left {
  text-align: left;
  display: flex;
  text-align: center;
}
.nav-title{
  display: flex;
  align-items: center;
  font-size: 18px;
  font-weight: 600;
}
/* 
.content-item-left-span-white {
  padding-left: 20px;
  font-size: 18px;
  font-weight: 600;
}

.content-item-left-span-white::before {
  left: 0px;
  content: "";
  top: 8px;
  width: 10px;
  height: 10px;
  position: absolute;
  transform: rotate(-45deg);
  border-left: 2px solid white;
  border-top: 2px solid white;
}

.content-item-left-span-black {
  padding-left: 20px;
  font-size: 18px;
  font-weight: 600;
}

.content-item-left-span-black::before {
  left: 0px;
  content: "";
  top: 8px;
  width: 10px;
  height: 10px;
  position: absolute;
  transform: rotate(-45deg);
  border-left: 2px solid black;
  border-top: 2px solid black;
} */

.content-item-center {
  text-align: center;
}

.content-item-right {
  text-align: right;
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
  /* background-color: #fff; */
  background-color:pink;
}
@font-face {
    font-family: 'iconfont';
    src:url('data:application/font-woff;charset=utf-8;base64,d09GRgABAAAAAAQ4AA0AAAAABlQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABGRlRNAAAEHAAAABoAAAAcjvZa/0dERUYAAAP8AAAAHgAAAB4AKQAKT1MvMgAAAaQAAABCAAAAVjyvSDNjbWFwAAAB+AAAAD4AAAFCAA/p7Gdhc3AAAAP0AAAACAAAAAj//wADZ2x5ZgAAAkQAAABEAAAARG6fs/RoZWFkAAABMAAAADEAAAA2HEN382hoZWEAAAFkAAAAHQAAACQGiQOFaG10eAAAAegAAAAQAAAAEAwAAShsb2NhAAACOAAAAAoAAAAKACIAAG1heHAAAAGEAAAAHwAAACABDwAdbmFtZQAAAogAAAFJAAACiCnmEVVwb3N0AAAD1AAAAB8AAAAxy4Fu3njaY2BkYGAA4g9PvtyO57f5ysDNwgACd1ZK/obRjBoMGkyrmW4AuRwMTCBRAHxqDGgAAAB42mNgZGBgbvjfwBDDwgACTKsZGBlQAQsAU5MDFgAAAHjaY2BkYGBgYRBkANEMDExAzAWEDAz/wXwGAAp2AS0AeNpjYGRhYJzAwMrAwNTJdIaBgaEfQjO+ZjBi5ACKMrAyM2AFAWmuKQwOzxyfOTI3/G9giGFuYGgACjOC5ADk5QxdAAAEAAAAAAAAAAQAAAAEAAEoeNpjYGBgZoBgGQZGBhCwAfIYwXwWBgUgzQKEQP4zx///IaTkIahKBkY2BhiTgZEJSDAxoAJGhmEPAIP8B+EAAAAAAAAAAAAAACIAAAABASgAKAKrAtgAEAAACQEWFAYiJwEmNDcBNjIWFAcBjwEPDRoiDf7SDAwBLg0iGg0BgP7xDiEaDAEuDSINAS4MGiEOeNp9kD1OAzEQhZ/zByQSQiCoXVEA2vyUKRMp9Ailo0g23pBo1155nUg5AS0VB6DlGByAGyDRcgpelkmTImvt6PObmeexAZzjGwr/3yXuhBWO8ShcwREy4Sr1F+Ea+V24jhY+hRvUf4SbuFUD4RYu1BsdVO2Eu5vSbcsKZxgIV3CKJ+Eq9ZVwjfwqXMcVPoQb1L+EmxjjV7iFa2WpDOFhMEFgnEFjig3jAjEcLJIyBtahOfRmEsxMTzd6ETubOBso71dilwMeaDnngCntPbdmvkon/mDLgdSYbh4FS7YpjS4idCgbXyyc1d2oc7D9nu22tNi/a4E1x+xRDWzU/D3bM9JIbAyvkJI18jK3pBJTj2hrrPG7ZynW814IiU68y/SIx5o0dTr3bmniwOLn8owcfbS5kj33qBw+Y1kIeb/dTsQgil2GP5PYcRkAAAB42mNgYoAALjDJyIAOWMCiTIxMbGmJeRmlmQALcgKZAAAAAAH//wACAAEAAAAMAAAAFgAAAAIAAQADAAMAAQAEAAAAAgAAAAB42mNgYGBkAIKrS9Q5QPSdlZK/YTQAQkMG3AAA') format('woff');
    font-weight: 900;
    font-style: normal;
    font-display: swap;
}

.iconfont {
  font-family: "iconfont" !important;
  font-size: 22px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.icon-fanhui:before {
  content: "\e641";
  padding-left: 10px;
}
</style>
