<template>
    <div>
        <br/>
        <br/>
        <br/>
        <br/>
        a页面测试count值：{{ $store.state.count }}
        <br/>
        <br/>
        <button @click="handleClickLocation">跳转b页面</button>
        <br/>
        <br/>
        <button @click="handleClickSetCount">改变当前值</button>
    </div>
</template>

<script>
export default {
    data() {
        return {
        
        }
    },
    computed: {
    
    },
    watch: {
    
    },
    created() {
    
    },
    mounted() {
    
    },
    methods: {
      onNativeShow() {
        alert('当前页显示 ------ ')
      },
      handleClickLocation() {
        this.$router.push({ path: '/b' })
      },
      handleClickSetCount() {
        this.$store.commit('setCount')
      }
    }
}
</script>

<style lang="scss" scoped>

</style>
