<template>
  <div>
    <HEADER @clickLeftButton="handlerHeaderBack" :reviceNavTitle="navTitle" />

    <div :style="{marginTop:navigatorHeight+'px'}">
      <van-pull-refresh
        v-model="refreshing"
        @refresh="onRefresh"
      >
        <van-list v-model="loading" :finished="finished" finished-text="没有更多了" @load="onLoad">
          <van-cell v-for="item in list" :key="item" :title="item" />
        </van-list>
      </van-pull-refresh>
    </div>
  </div>
</template>

<script>
import HEADER from "@/components/Header/index"
import device from "@zkty-team/x-engine-module-device"
export default {
  components: {
    HEADER,
  },
  data() {
    return {
      navTitle: "刷新数据",
      list: [],
      loading: false,
      finished: false,
      refreshing: false,
      navigatorHeight:''
    }
  },
  mounted() {
    // 导航条高度
    device.getNavigationHeight({}).then((res) => {
      this.navigatorHeight = res.content
    })
  },
  methods: {
    onLoad() {
      setTimeout(() => {
        if (this.refreshing) {
          this.list = []
          this.refreshing = false
        }

        for (let i = 0; i < 10; i++) {
          this.list.push(this.list.length + 1)
        }
        this.loading = false

        if (this.list.length >= 40) {
          this.finished = true
        }
      }, 1000)
    },
    onRefresh() {
      // 清空列表数据
      this.finished = false

      // 重新加载数据
      // 将 loading 设置为 true，表示处于加载状态
      this.loading = true
      this.onLoad()
    },
    handlerHeaderBack() {
      this.$router.go(-1)
    },
  },
}
</script>

<style>
</style>