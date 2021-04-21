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
          <div
            :class="[bgImage==''?'content-item-left-span-black': 'content-item-left-span-white']"
          >{{ navTitle }}</div>
        </slot>
      </div>

      <div class="content-item-center" :style="{ lineheight: lineheight + 'px' }">
        <slot name="center"></slot>
      </div>

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
      navTitle: "",
      bgImage: "",
      isShowHeader: false,
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
      if (to.meta.hasOwnProperty('title')) {
        if (to.query.hasOwnProperty("changeNavTitle")) {
          this.navTitle = to.query.changeNavTitle
        } else {
          this.navTitle = to.meta.title
        }
      } else  {
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
        this.isShowHeader = false
      } else {
        this.isShowHeader = to.meta.isShowHeader
      }
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
  left: 20px;
  right: 20px;
}

.content-item-left {
  text-align: left;
  display: flex;
  text-align: center;
}

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
}

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
  background-color: #fff;
}
</style>
