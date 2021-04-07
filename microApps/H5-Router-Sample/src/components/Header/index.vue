<template>
  <div class="navigator-class">
    <div ref="navWrapper" class="navWrapper" :style="{ height: lineheight + 'px' }">
      <div class="title-wrapper">
        <div
          ref="leftButton"
          class="content-item-left"
          :style="{ lineheight: lineheight + 'px' }"
          @click="leftButton"
        >
          {{ reviceLeftTitle }}
        </div>
        <div
          ref="canterButton"
          class="content-item-center"
          :style="{ lineheight: lineheight + 'px' }"
        >
          {{ reviceNavTitle }}
        </div>
        <div
          ref="rightButton"
          class="content-item-right"
          :style="{ lineheight: lineheight + 'px' }"
          @click="rightButton"
        >
          {{ reviceRightTitle }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import device from "@zkty-team/x-engine-module-device";
export default {
  data() {
    return {
      lineheight: "",
      statusHeigt: "",
    };
  },
  props: {
    reviceLeftTitle: {
      type: String,
      default: "< 返回",
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

  created() {
    if (this.isPhoneType().isiPhone) {
      device.getNavigationHeight({}).then((navRes) => {
        this.lineheight = navRes.content;
        this.$refs.navWrapper.style.cssText = `height: ${navRes.content}px;`;
      });
    } else if (this.isPhoneType.isAndroid) {
      alert("android");
      // device.getStatusHeight({}).then((statusRes) => {
      // this.statusHeigt = statusRes.content;
      // this.$refs.navWrapper.style.cssText = `height: ${statusRes.content}px;`
      // this.$refs.navWrapper.style.cssText = `height: ${this.statusHeigt + navRes.content}px;`
      // })

      device.getNavigationHeight({}).then((navRes) => {
        this.lineheight = navRes.content;
        this.$refs.navWrapper.style.cssText = `height: ${navRes.content}px;`;
      });
    }
  },
  methods: {
    isPhoneType() {
      let deviceType = {
        userAgent: navigator.userAgent.toLowerCase(),
        isAndroid: Boolean(navigator.userAgent.match(/android/gi)),
        isiPhone: Boolean(navigator.userAgent.match(/iphone|ipod/gi)),
        // isIpad: Boolean(navigator.userAgent.match(/ipad/gi)),
        // isWeixin: Boolean(navigator.userAgent.match(/MicroMessenger/gi)),
      };
      return deviceType;
    },
    leftButton() {
      this.$emit("clickLeftButton");
    },
    rightButton() {
      this.$emit("clickRightButton");
    },
  },
};
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
.title-wrapper{
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
