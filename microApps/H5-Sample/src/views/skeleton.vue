<template>
  <div>
    <HEADER
      @clickLeftButton="handlerHeaderBack"
      @clickRightButton="handlerHeaderRightBtn"
      :reviceNavTitle="navTitle"
    />
    <div :style="{marginTop:navigatorHeight+'px'}">
      <div style="margin-top:30px;" v-show="skeletonShow">
        <van-skeleton title avatar round animate :row="3" />
      </div>

      <div style="margin-top:50px;" v-show="!skeletonShow">
        <div>老子出现了</div>
      </div>
    </div>

    <div class="content">store中的count为:{{$store.state.count}}</div>

    <div class="operating">
      <van-button
        color="linear-gradient(to right, #4bb0ff, #6149f6)"
        size="large"
        round
        @click="handlerSyncJIA"
      >sync加</van-button>
      <van-button
        color="linear-gradient(to right, #ff6034, #ee0a24)"
        size="large"
        round
        @click="handlerSyncJIAN"
      >async减</van-button>
    </div>
  </div>
</template>

<script>
import HEADER from "../components/Header/index"
import XEngine from "@zkty-team/x-engine-core"
export default {
  components: {
    HEADER,
  },
  data() {
    return {
      navTitle: "骨架屏",
      skeletonShow: true,
      navigatorHeight: "",
    }
  },
  mounted() {
    let navHeight = XEngine.api("com.zkty.jsi.device", "getNavigationHeight")
    this.navigatorHeight = navHeight
    setTimeout(() => {
      this.skeletonShow = false
    }, 3000)
  },
  methods: {
    handlerHeaderBack() {
      this.$router.go(-1)
    },
    handlerHeaderRightBtn() {
      alert("点击的了右上角按钮")
    },
    handlerNextpage() {
      this.$router.push({
        path: "/navHeader",
      })
    },
    handlerSyncJIA() {
      this.$store.commit("jia")
    },
    handlerSyncJIAN() {
      this.$store.commit("jian")
    },
  },
}
</script>

<style>
.skeleton-class {
  margin-top: 20px;
}

.content {
  background: gray;
  border-radius: 20px;
  margin-top: 200px;
  margin: 50px;
  height: 200px;
  color: white;
  line-height: 200px;
}

.operating {
  margin-top: 50px;
  display: flex;
  flex-direction: row;
}
</style>