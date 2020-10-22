<template>
  <div class="gonggao">
    <van-dropdown-menu class="menu-class">
      <van-dropdown-item
        v-model="dropDownValue"
        :options="dropDownOption"
        title-class="menu-title-class"
        @change="changeOption"
      />
    </van-dropdown-menu>

    <div class="tabDiv-class">
      <van-tabs
        color="#E8374A"
        @click="clickTab"
        line-height="0px"
        background="rgba(0, 0, 0, 0)"
        swipeable
        scrollspy
        class="tab-class"
        title-active-color="#E8374A"
        title-inactive-color="#121212"
        title-style="title-style-class"
        v-model="activeName"
      >
        <van-tab title="已发布" name='0'></van-tab>
        <van-tab title="未发布" name='1'></van-tab>
      </van-tabs>
    </div>

    <van-list>
      <div class="list-class" v-for="item in list" :key="item.id" @click="clickListItem(item)">
        <span class="title-class">{{ item.title }}</span>
        <span class="time-class">{{ item.createAt | formatDate('YYYY-MM-DD') }}</span>
        <span class="type-class">{{ item.typeName }}</span>
      </div>
    </van-list>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
import {getProjectMenus,getNoticesByProject} from '../service/gonggao-service';
export default {
  data() {
    return {
      isShowList: true,
      dropDownValue: 0,
      activeName:0,//tab
      projectId:0,//项目
      dropDownOption: [
        { text: "时代外滩", value: 0 },
        { text: "在水一方", value: 1 },
        { text: "天上人间", value: 2 }
      ],
      list: []
    };
  },
  mounted() {
    nav.setNavTitle({
      title: "物业公告",
      titleColor: "#000000",
      titleSize: 18
    });
    nav.setNavRightBtn({
      icon: "/static/edit.png",
      iconSize: [20, 20],
      __event__:()=>{
        //新建公告 删除存的信息
        localStorage.removeItem('editNotice');
        localStorage.removeItem('firstStep');
        nav.navigatorPush({
          url: "/PublicAnnouncement1",
          params: "create"
        });
      }
    });
    // this.dropDownMenus()
    this.getNoticesListByProject();
  },
  methods: {
    //下拉列表
    dropDownMenus(){
      getProjectMenus().then(res=>{
        console.log(res);
        
        // this.getNoticesListByProject();
      })
    },
    changeOption(value){
      console.log(value);
      this.projectId = value;
      localStorage.setItem('projectId',value)
      this.getNoticesListByProject();
    },
    //tab下公告列表
    getNoticesListByProject(){
      // this.list=[]
      const param_in = {
        projectId:this.projectId,
        params:{
          pageInede:1,
          pageSize:10
        }
      }
      getNoticesByProject(param_in,parseInt(this.activeName)).then(res=>{
        console.log(res);
        this.list = res.result.code=== 200 && res.result.data.records
      }).catch(e=>{
        console.log(e)
      })
    },
    //切换tab
    clickTab() {
      this.getNoticesListByProject();
    },
    clickListItem(item) {
      nav.navigatorPush({
        url: "/GonggaoDesc",
        params:`status=${item.status}&noticeId=${item.id}`
      });
    }
  }
};
</script>

<style lang="less">
.gonggao {
  background-color: white;
  .menu-class {
    .menu-title-class {
      font-family: PingFangSC-Medium;
      font-size: 21px;
      color: #121212;
      letter-spacing: -0.47px;
      line-height: 60px;
      margin-left: -250px;
    }
    .van-dropdown-menu__bar {
      box-shadow: 0 0 0 rgba(100, 101, 102, 0);
    }
  }

  .tabDiv-class {
    height: 50px;
    width: 90%;
    background: rgba(0, 0, 0, 0.03);
    border-radius: 25px;
    margin: 0 15px;
    .tab-class {
      margin: 0 10px;
      .van-tabs__wrap {
        position: relative;
        top: 3px;
        border-radius: 25px;
      }
      .van-tab--active {
        background-color: white;
        border-radius: 25px;
      }
    }
  }

  .list-class {
    border-radius: 5px;
    position: relative;
    margin: 10px 16px;
    display: flex;
    flex-direction: column;
    height: 82px;
    font-size: 14px;
    background: #ffffff;
    box-shadow: 0 6px 30px 0 rgba(71, 77, 96, 0.06);
    border-radius: 16px;
    .title-class {
      position: absolute;
      top: 22px;
      left: 16px;
      font-family: PingFangSC-Medium;
      font-size: 18px;
      color: #121212;
      letter-spacing: -0.3px;
      line-height: 18px;
    }
    .time-class {
      position: absolute;
      bottom: 18px;
      left: 16px;
      font-family: PingFangSC-Regular;
      font-size: 14px;
      color: #666666;
      letter-spacing: -0.23px;
      line-height: 14px;
    }
    .type-class {
      position: absolute;
      bottom: 15px;
      right: 16px;
      padding: 2px 7px;
      background: rgba(37, 116, 255, 0.1);
      border-radius: 20px;
      font-family: PingFangSC-Regular;
      font-size: 10px;
      color: #2574ff;
      letter-spacing: -0.17px;
    }
  }

  .list-class2 {
    border-radius: 5px;
    position: relative;
    margin: 10px 16px;
    display: flex;
    flex-direction: column;
    height: 82px;
    font-size: 14px;
    background: #ffffff;
    box-shadow: 0 6px 30px 0 rgba(71, 77, 96, 0.06);
    border-radius: 16px;

    .title-class2 {
      position: absolute;
      top: 32px;
      left: 16px;
      font-family: PingFangSC-Medium;
      font-size: 18px;
      color: #121212;
      letter-spacing: -0.3px;
      line-height: 18px;
    }
    .type-class2 {
      position: absolute;
      top: 32px;
      right: 16px;
      padding: 2px 7px;
      background: rgba(37, 116, 255, 0.1);
      border-radius: 20px;
      font-family: PingFangSC-Regular;
      font-size: 10px;
      color: #2574ff;
      letter-spacing: -0.17px;
    }
  }
}
</style>
