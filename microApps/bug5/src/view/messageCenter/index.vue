<template>
  <div class="massage-list">
    
  </div>
</template>

<script>
export default {
  name:'MessageList',
  components: {
    
  },
  data () {
    return {
      
    }
  },
  methods: {
    turn_detail(){
      this.$router.push({ path: "/property_detail" })
    }
  }
}
</script>


<style lang="less" scope>
.massage-list{
  width: 100%;
  height: auto;
  padding: 20px 16px 20px 38px;
  
  
}
</style>