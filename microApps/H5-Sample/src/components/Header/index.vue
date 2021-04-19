<template>
  <div
    class="navigator-class"
    :style="style"
    :class="[bgImage != '' ? 'text-white bg-img' : 'none-bg', bgColor]"
  >
    <div class="title-wrapper">
      <div
        class="content-item-left"
        :style="{ lineheight: lineheight + 'px' }"
        @click="handlerLeftButton"
      >
        <slot name="left">
          <span class="content-item-left-span">{{ title }}</span>
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
  data() {
    return {
      lineheight: "",
      statusHeigt: "",
    }
  },
  computed: {
    style() {
      var navigationBar = this.lineheight
      var bgImage = this.bgImage
      var style = `height:${navigationBar}px;`
      if (this.bgImage) {
        style = `${style}background-image:url(${bgImage});`
      }
      return style
    },
  },
  props: {
    bgColor: {
      type: String,
      default: "",
    },
    textColor: {
      type: String,
      default: "#000",
    },
    title: {
      type: String,
      default: "返回",
    },
    bgImage: {
      type: String,
      default: "",
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
        this.$refs.navWrapper.style.cssText = `height: ${navheight}px;`
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
        this.$refs.navWrapper.style.cssText = `height: ${height}px;`
      }
    } else if (XEngine.platform.isPc) {
      const height = 64
      this.lineheight = height
      // this.$refs.navWrapper.style.cssText = `height: ${height}px;`
    }
  },
  methods: {
    handlerLeftButton() {
      this.$emit("leftButton")
    },
  },
}
</script>

<style>
.navigator-class {
  width: 100%;
  position: fixed;
  top: 0;
  z-index: 9999;
  border-bottom: 1px solid gainsboro;
}

.navWrapper {
  font-weight: 600;
  position: relative;
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

.content-item-left-span {
  padding-left: 20px;
}

.content-item-left-span::before {
  content: "";
  position: absolute;
  border-left: 1px solid black;
  border-top: 1px solid black;
  width: 10px;
  height: 10px;
  top: 5px;
  left: 0;
  transform: rotate(-45deg);
}

.content-item-left img {
  width: 15px;
  height: 23px;
  margin-right: 8px;
  text-align: left;
}

.content-item-center {
  text-align: center;
}

.content-item-right {
  text-align: right;
}

.none-bg {
  background-color: #fff;
}
.text-white {
  color: #fff;
}
</style>
