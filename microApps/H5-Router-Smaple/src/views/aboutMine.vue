<template>
  <div>
    <div class="navbar">
      <div ref="mineWrapper"></div>
      <!-- <div style="width:100%;height:20px;background:#fff;"></div> -->
      <van-nav-bar left-text="关于我们" left-arrow @click-left="onClickLeft" />
    </div>
    <div class="about-wrapper">
      <div class="logo">
        <img src="../../../assets/img/mine/aboutMine.png" alt />
      </div>
      <div class="version">Version {{ appVersion }}</div>
      <div class="content">
        <div>线下平台定位线下展示体验+生活服务平台。集合了展示体验电器门店、车展体验店、家装体验店、生活综合服务，包括生活综合服务类管理平台，以及家娱乐、家秀场、家餐厅、家休闲娱乐等等娱乐化平台。线下平台是集团本地生活主要场景，具备了置业和运营两大能力，以商品展示体验、家延伸以及家娱乐为核心，提供到家到店到网服务。</div>
        <div>线下平台通过租赁、合作、共建以及众多轻资产运营等物业整合模式，快速拓展了无论从商场、社区、仓库等等这些优质物业，优化了现有国美自有门店和存量租赁门店，重新布局线下网络，打造线下最大的数字化专业化门店平台。线下平台运营能力是线上线下一体化运营方式，以“分时复用、场地复用、设备共享、人员共享”为共享理念，为商户提供商品展示体验、娱乐直播、赛事直播、视频导购、一店一页和社群运营工具以及商品专家、礼仪人员专业化代运营管理能力，通过流量汇集和分发，帮助商品、商户实现流量转化和实现。</div>
        <div>线下平台以经营展示+娱乐+服务，形成了大服务概念，抢占本地生活服务行业的制高点。重点打造本地生活高标准生活性运营体系。全品类供应端，我们以“GM标准+N”，这种国美的标准，目前有四项，还在扩大，包括：100%低价无忧保障承诺、100%贵宾礼遇无忧承诺、100%正品无忧承诺、100%特殊售后无忧承诺，并且建立各种特色N条运营管理标准。这些GM标准+N条标准，形成了企业标准及行业标准，我们将形成大服务体验标准及行业标准，严选入住商家，以八重标准进行遴选，来形成真选商品以及打造顶级品牌。</div>
        <div>线下运营端利用自营与代运营能力，在通用运营能力基础上通过撮合平台、服务抢单平台、一店一页、社群运营，为商家线上线下共享场景进行赋能。</div>

        <div>在场景端，打造家·秀场、家·餐饮娱乐、家·休闲娱乐、家·宠物、家·健康保健、家·教育培训、家·文化、家·生活等到店到家体验与服务。</div>
      </div>
      <div class="footer">
        <div>国美公司 版权所有</div>Copyright © 2020-2021 Gome. All Rights Reserved
      </div>
    </div>
  </div>
</template>

<script>
import device from "@zkty-team/x-engine-module-device";
export default {
  data() {
    return {
      appVersion: null
    }
  },
  created() {
    device
      .getStatusHeight({})
      .then((res) => {
        this.$refs.mineWrapper.style.cssText = `height: ${res.content}px;`;
      });
    device
      .getSystemVersion({})
      .then((res) => {
        this.appVersion = res.content
      });
  },
  methods: {
    onClickLeft() {
      this.setRouter({
        goout: false,
        isBack: true,
      });
    },
  },
};
</script>

<style lang="less" scoped>
.navbar {
  width: 100%;
  position: fixed;
  top: 0;
}
.about-wrapper {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  overflow: hidden;
  padding-top: 70px;
  .logo {
    width: 140px;
    height: 140px;
    margin-top: 35px;
    img {
      width: 100%;
      height: 100%;
    }
  }
  .version {
    margin-top: 12px;
    font-size: 14px;
    font-family: PingFangSC-Regular, PingFang SC;
    font-weight: 400;
    color: #9b99a9;
  }
  .content {
    width: 100%;
    padding: 0 16px;
    margin-top: 56px;
    > div {
      margin-top: 12px;
      font-size: 14px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #121212;
      text-align: justify;
    }
  }
  .footer {
    width: 100%;
    text-align: center;
    margin-top: 56px;
    margin-bottom: 16px;
    font-size: 12px;
    font-family: PingFangSC-Regular, PingFang SC;
    font-weight: 400;
    color: #9b99a9;
  }
}
</style>