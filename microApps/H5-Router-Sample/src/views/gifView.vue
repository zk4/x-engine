<template>
  <div>
    <HEADER
      @clickLeftButton="handlerHeaderBack"
      @clickRightButton="handlerHeaderRightBtn"
      :reviceTitle="navHeader1"
    />
    <div v-if="isShowContent">
      <img class="img-class" src="../static/image/gif.gif" alt />
      <div>加载数据中.......</div>
    </div>
    <div v-else>
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
        我是数据回来之后的内容
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
      isShowContent: true,
    }
  },
  mounted() {
    setTimeout(() => {
      this.isShowContent = false
    }, 3000)
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
.img-class {
  width: 100%;
}
</style>