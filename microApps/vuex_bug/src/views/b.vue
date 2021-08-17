<template>
  <div>
    <br />
    <br />
    <br />
    <br />
    b页面测试count值：{{ $store.state.count }}
    <br />
    <br />
    <button @click="handleClickCallback">返回a页面</button>
    <br />
    <br />
    <button @click="handleClickSetCount">改变count值</button>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  computed: {},
  watch: {},
  created() {},
  mounted() {},
  methods: {
    handleClickCallback() {
      this.$router.go(-1);
    },
    handleClickSetCount() {
      this.$store.commit("setCount");
    },
  },
};
</script>

<style lang="scss" scoped></style>
