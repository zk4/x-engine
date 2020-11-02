<template>
  <div class="cancel-account">
    <div class="content">
      <p>垃圾在分类储存阶段属于公众的私有品，垃圾经公众分类投放后成为公众所在小区或社区的区域性准公共资源，垃圾分类搬运到垃圾集中点或转运站后成为没有排除性的公共资源。结合<span>《小区业主委员会选举办法及选举试试细则》</span>来看。</p>
      <p>从国内外各城市对生活垃圾分类的方法来看，大致都是根据垃圾的成分、产生量，结合本地垃圾的资源利用和处理方式来进行分类的。</p>
    </div>
    <div class="subbottom-content">
      <van-button class="sub-button" data-color="true" type="primary" color="#E8374A" @click="cancelAccount">同意并继续注销</van-button>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";
import router from "@zkty-team/x-engine-module-router";


export default {
  name:"CancelAccount",
  components: {
    
  },
  data () {
    return {
    }
  },
  created() {
    nav.setNavLeftBtn({ title: "注销账号", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
  },
  methods: {
    cancelAccount() {
      api.delUser().then(res => {
        if (res.code === 200) {
          router.openTargetRouter({
            type: "microApp",
            uri: "com.times.microapp.AppcMine",
            path: "/changePhonenum"
          });
          console.log(res)
        }
      }).finally(() => {
      });
    },
  }
}
</script>


<style lang="less" scope>
.cancel-account{
  width: 100%;
  height: auto;
  padding: 20px 16px;

  .content{
    font-size: 14px;
    font-family: PingFangSC-Regular, PingFang SC;
    font-weight: 400;
    color: #8D8D8D;
    line-height: 28px;
    p{
      margin: 0 0 12px 0;
    
      span{
        font-family: PingFangSC-Medium, PingFang SC;
        color: #121212;
      }
    }
  }

}
</style>