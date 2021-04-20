<template>
  <div
    class="navigator-class"
    :style="style"
    :class="[bgImage==''?'text-black':'text-white img-mode']"
  >
    <slot name="leftSlot"></slot>
    <div class="title-wrapper">
      <div
        class="content-item-left"
        :style="{ lineheight: lineheight + 'px' }"
        @click="handlerLeftButton"
      >
        <slot name="left">
          <div
            :class="[bgImage==''?'content-item-left-span-black': 'content-item-left-span-white']"
          >{{ title }}</div>
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
export default {
  data() {
    return {
      lineheight: ""
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
  props: {
    isShowHeader: {
      type: Boolean,
      default: false,
    },
    bgColor: {
      type: String,
      default: "",
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
    if (this.engine.isHybrid()) {
      if (this.engine.platform.isPhone) {
        let navheight = this.engine.api(
          "com.zkty.jsi.device",
          "getNavigationHeight"
        )
        this.lineheight = navheight
      } else if (this.engine.platform.isAndroid) {
        let statusBarHeight = this.engine.api(
          "com.zkty.jsi.device",
          "getStatusBarHeight"
        )
        let navheight = this.engine.api(
          "com.zkty.jsi.device",
          "getNavigationHeight"
        )
        let height = Number(statusBarHeight) + Number(navheight)
        this.lineheight = height
      }
    } else if (this.engine.platform.isPc) {
      const height = 64
      this.lineheight = height
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
  top: 0;
  width: 100%;
  z-index: 9999;
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
</style>
