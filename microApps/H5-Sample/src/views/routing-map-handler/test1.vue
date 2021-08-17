<template>
  <div>
    <van-tabs type="card" @click="go">
      <van-tab title='标签 1'>内容 1</van-tab>
      <van-tab title='标签 2'>内容 2</van-tab>
      <van-tab title='标签 3'>内容 3</van-tab>
      <van-tab title='标签 4'>内容 4</van-tab>
    </van-tabs>
    <div>{{`home: ${$route.query.home}`}}</div>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  data() {
    return {
      active: 2
    };
  },
  methods: {
    go(name) {
      this.$router.push({path: `/test1/test${name + 1}`, query: {
        a: 1,
        b: 2
      }})
    }
  }
};
</script>

<style>
</style>