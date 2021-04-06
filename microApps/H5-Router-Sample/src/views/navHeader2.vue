<template>
  <div class="navHeader2Class">
    <img src="../static/image/testImg.jpeg" alt />
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <van-button type="primary" size="large" round @click="handlerNoHaderPage">back</van-button>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
    <div>占位</div>
  </div>
</template>

<script>
export default {
  components: {},
  data() {
    return {
      skeletonShow: true,
    }
  },
  mounted() {
    setTimeout(() => {
      this.skeletonShow = false
    }, 2000)
  },
  methods: {
    handlerNoHaderPage() {
      this.$router.go(-1)
    },
    handlerHeaderRightBtn() {
      alert("点击的了右上角按钮")
    },
  },
}
</script>

<style>
.navHeader2Class > img {
  width: 100%;
}
</style>