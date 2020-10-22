<template>
  <div class="gonggaodesc-class">
    <div class="title-class">
      {{ descData.title }}
      <span v-if="publicStatus==0" class="status-class">未发布</span>
    </div>
    <div class="middle-class">
      <div class="target-class">{{ descData.target }}</div>
      <div class="time-class">{{ descData.createAt | formatDate('YYYY-MM-DD') }}</div>
    </div>
    <div class="content-class">{{ descData.detail }}</div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
import { noticeDetail,deleteNotice,editNotice,revokeNotice } from '../service/gonggao-service'
export default {
  name: "GonggaoDesc",
  data() {
    return {
      // 0 未发布  1已发布
      publicStatus: 0,
      noticeId:0,
      descData: {}
    };
  },
  mounted() {
    this.publicStatus = this.$route.query.params.split('=')[1];
    this.noticeId = this.$route.query.noticeId;

    this.getNoticeDetail();

    nav.setNavTitle({
      title: "公告详情",
      titleColor: "#000000",
      titleSize: 18
    });
    //0未发布；1已发布
    if (this.publicStatus == 1) {
      nav.setNavRightBtn({
        icon: "/static/edit.png",
        iconSize: [20, 20],
        showMenuImg: "true",
        menuWidth: 70,
        itemList: [
          { title: "编辑" },
          { title: "删除" }
        ],
        __event__:(operIndex)=>{
          //操作右边按钮的事件
          console.log(operIndex)
          switch(operIndex){
            case '1':
              this.deleteNoticeOper();
              break;
            case '0':
              this.editNoticeOper();
              break;
          }
        }
      });
    } else {
      nav.setNavRightBtn({
        icon: "/static/edit.png",
        iconSize: [20, 20],
        showMenuImg: "true",
        menuWidth: 70,
        itemList: [{ title: "撤回" }],
        __event__:()=>{
          //操作右边按钮的事件
          console.log('撤回')
          this.revokeNoticeOper()
        }
        });
    }
  },
  methods: {
    pushPath() {
      nav.navigatorPush({
        url: "/PublicAnnouncement1",
        params: "edit"
      });
    },
     //获取公告详情
    async getNoticeDetail() {
      await noticeDetail(this.noticeId).then(res => {

        this.descData = res.result.code=== 200 && res.result.data;

        console.log(`接口结果：`,res);
      });
    },
    //删除公告
    deleteNoticeOper(){
      deleteNotice(this.noticeId).then(res=>{
        console.log('删除',res);

        // nav.navigatorPush({
        //   url: "/Gonggao",
        // });

        
      })
    },
    // 编辑公告
    editNoticeOper(){
      
      editNotice(this.noticeId).then(res=>{
        
        console.log('编辑',res);
        const noticeDetail = res.result.code === 200 && res.result.data;
        localStorage.setItem('editNotice',JSON.stringify(noticeDetail));
        this.pushPath()
      })
    },
    //撤回公告
    revokeNoticeOper(){
      // nav.navigatorBack({
      //   path: "/Gonggao",
      // });
      revokeNotice(this.noticeId).then(res=>{
        console.log('撤回',res);
         nav.navigatorBack({
          path: "/Gonggao",
        });
      })
    }
  }
};
</script>

<style lang="less" scoped>
.gonggaodesc-class {
  text-align: left;
  display: flex;
  padding: 30px 16px 0 16px;
  flex-direction: column;
  .title-class {
    font-family: PingFangSC-Medium;
    font-size: 20px;
    color: #121212;
    letter-spacing: -0.33px;
    line-height: 25px;
    font-size: 21px;
  }
  .status-class {
    display: inline-block;
    position: relative;
    top: -1;
    padding: 2px 7px;
    margin-left: 5px;
    background: rgba(232, 55, 74, 0.1);
    border: 1px solid #e8374a;
    border-radius: 4px;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    line-height: 14px;
    color: #e8374a;
    letter-spacing: -0.22px;
  }
  .middle-class {
    display: flex;
    margin-top: 16px;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    color: #8d8d8d;
    letter-spacing: -0.23px;
    line-height: 14px;
    .target-class {
      margin-right: 32px;
      color: rgb(160, 160, 160);
    }
  }
  .content-class {
    margin: 32px 0;
    font-family: PingFangSC-Regular;
    font-size: 14px;
    color: #121212;
    letter-spacing: -0.23px;
    line-height: 28px;
  }
}
</style>
