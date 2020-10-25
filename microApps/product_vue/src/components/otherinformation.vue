<template>
  <div class="property_notice_detail">
    <div class="tiile">
      <div class="rightbbox">
          <router-link class="base-info-item" :to="{ name: 'coursebyid' }">
                  <div class="title-left" >业主变更历史</div>
                  <div class="arrow-right"></div>
                </router-link>
        <!-- <router-link class="couby" :to="{ name: 'coursebyid' }">业主变更历史 <van-icon style="vertical-align: middle;" name="play" /></router-link> -->
      </div>
      <div class="leftbbox"> <div class="base-info-item">
                  <div class="title-left">历史缴费记录</div>
                  <div class="arrow-right"></div>
                </div></div>
    </div>
  </div>
</template>

<script>
export default {
  name: "PropertyNoticeDetail",
  components: {},
  data() {
    return {
      active: 0,
    };
  },
  created() {},
  methods: {},
};
</script>


<style lang="less" scope>
.property_notice_detail {
  width: 100%;
  height: auto;
  //   padding: 29px 16px 20px 16px;
  .tiile {
    display: flex;
    .rightbbox {
      flex: 1;
      padding: 10px 16px 10px 10px;
      text-align: center;

      box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
      border-radius: 6px;

      font-size: 15px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #666666;
      line-height: 21px;
    }
  }
  .leftbbox {
    flex: 1;
    padding: 10px 16px 10px 10px;
    text-align: center;

    box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
    border-radius: 6px;

    font-size: 15px;
    font-family: PingFangSC-Regular, PingFang SC;
    font-weight: 400;
    color: #666666;
    line-height: 21px;
  }
  .couby{
      color: #666666;
  }
  .base-info-item {
            padding: 10px 0 10px 16px;
            width: 146px;
            background-color: #fff;
            margin-top: 10px;
            box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
            border-radius: 6px;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
            .title-left{
                color: #666666;
            }
    .arrow-right{
         width: 8px;
              height: 8px;
              margin-right: 14px;
              border-width: 4px;
              border-style: solid;
              border-color: transparent transparent transparent #666666;
    }
  }
}
</style>
