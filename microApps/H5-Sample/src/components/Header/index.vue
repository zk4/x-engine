<template>
  <div class="navigator-class">
    <div ref="navWrapper" class="navWrapper" :style="{ height: lineheight + 'px' }">
      <div class="title-wrapper">
        <div
          ref="leftButton"
          class="content-item-left"
          :style="{ lineheight: lineheight + 'px' }"
          @click="leftButton"
        >{{ reviceLeftTitle }}</div>
        <div
          ref="canterButton"
          class="content-item-center"
          :style="{ lineheight: lineheight + 'px' }"
        >{{ reviceNavTitle }}</div>
        <div
          ref="rightButton"
          class="content-item-right"
          :style="{ lineheight: lineheight + 'px' }"
          @click="rightButton"
        >{{ reviceRightTitle }}</div>
      </div>
    </div>
  </div>
</template>

<script>
// import device from "@zkty-team/x-engine-module-device"
import XEngine from "@zkty-team/x-engine-core"
export default {
  data() {
    return {
      lineheight: "",
      statusHeigt: "",
    }
  },
  props: {
    reviceLeftTitle: {
      type: String,
      default: "back",
      require: true,
    },
    reviceNavTitle: {
      type: String,
      default: "title",
      require: true,
    },
    reviceRightTitle: {
      type: String,
      default: "right",
      require: true,
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
      this.$refs.navWrapper.style.cssText = `height: ${height}px;`
    }
  },
  methods: {
    leftButton() {
      this.$emit("clickLeftButton")
    },
    rightButton() {
      this.$emit("clickRightButton")
    },
  },
}
</script>

<style>
.navigator-class {
  width: 100%;
  background-color: orange;
  position: fixed;
  top: 0;
  z-index: 9999;
}

.navWrapper {
  background-color: orange;
  color: white;
  font-weight: 600;
  position: relative;
}
.title-wrapper {
  position: absolute;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  bottom: 10px;
  left: 25px;
  right: 25px;
}
.content-item-left {
  text-align: left;
}
.content-item-center {
  text-align: center;
}
.content-item-right {
  text-align: right;
}
</style>
