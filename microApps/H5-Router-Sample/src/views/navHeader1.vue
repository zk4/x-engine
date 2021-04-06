<template>
  <div>
    <HEADER
      @clickLeftButton="handlerHeaderBack"
      @clickRightButton="handlerHeaderRightBtn"
    />

    <div class="navHeader1-class">
      <van-button type="primary" size="large" round @click="handlerNoHaderPage">跳至没有Header页面</van-button>
    </div>
  </div>
</template>

<script>
import HEADER from "../components/Header/index"
export default {
  components: {
    HEADER,
  },
  data() {
    return {
      skeletonShow: true,
    }
  },
  mounted() {
    setTimeout(() => {
      this.skeletonShow = false
    }, 50000)
  },
  methods: {
    handlerHeaderBack() {
      this.$router.go("/")
    },
    handlerHeaderRightBtn() {
      alert("点击的了右上角按钮")
    },
    handlerNoHaderPage() {
      this.$router.push({
        path: "/navHeader2",
      })
    },
  },
}
</script>

<style>
.navHeader1-class {
  margin-top: 200px;
}
</style>