<template>
  <div>
    <HEADER
      @clickLeftButton="handlerHeaderBack"
      @clickRightButton="handlerHeaderRightBtn"
      :reviceTitle="测试"
    />
    <div class="skeleton-class" v-show="skeletonShow">
      <van-skeleton title avatar round animate :row="3" />
      <div style="margin-top:30px;">待做 骨架屏</div>
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
  },
}
</script>

<style>
.skeleton-class {
  margin-top: 20px;
}
</style>