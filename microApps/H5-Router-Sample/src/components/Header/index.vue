<template>
  <div class="navigator-class">
    <div ref="navWrapper" class="contentWrapper" :style="{height: lineheight+'px'}">
      <div
        ref="leftButton"
        class="content-item"
        :style="{lineheight: lineheight+'px'}"
        @click="leftButton"
      >back</div>
      <div
        ref="canterButton"
        class="content-item"
        :style="{lineheight: lineheight+'px'}"
      >{{reviceTitle}}</div>
      <div
        ref="rightButton"
        class="content-item"
        :style="{lineheight: lineheight+'px'}"
        @click="rightButton"
      >fun</div>
    </div>
  </div>
</template>

<script>
import device from "@zkty-team/x-engine-module-device"
export default {
  data() {
    return {
      lineheight: "",
    }
  },
  props: {
    reviceTitle: {
      type: String,
      default: "",
    },
  },
  created() {
    device.getNavigationHeight({}).then((res) => {
      this.$refs.navWrapper.style.cssText = `height: ${res.content}px;`
    })
  },
  methods: {
    leftButton() {
      this.$emit("clickLeftButton")
    },
    rightButton() {
      this.$emit("clickRightButton")
    }
  },
}
</script>

<style>
.navigator-class {
  width: 100%;
  background-color: orange;
}

.contentWrapper {
  display: flex;
  flex-direction: row;
  color: white;
  justify-content: space-between;
  padding: 0 25px;
}

.contentWrapper > .content-item {
  margin-top: 15%;
  align-items: center;
}
</style>