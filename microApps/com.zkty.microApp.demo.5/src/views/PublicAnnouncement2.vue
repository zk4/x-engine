<template>
  <div class="public-class">
    <div class="top-class">
      <div class="biaoti-class">类型</div>
      <van-field
        class="row-class"
        readonly
        clickable
        name="typeName"
        :value="typeName"
        placeholder="请选择类型"
        @click="showTypePicker = true"
      />
      <van-popup v-model="showTypePicker" position="bottom">
        <van-picker
          show-toolbar
          value-key='name'
          :loading="typeload"
          :columns="typePickerColumns"
          @confirm="onTypeConfirm"
          @cancel="showTypePicker = false"
        />
      </van-popup>

      <div class="biaoti-class">公告等级</div>
      <van-field
        class="row-class"
        readonly
        clickable
        name="picker"
        :value="gradeName"
        placeholder="请选择公告等级"
        @click="showLevalPicker = true"
      />
      <van-popup v-model="showLevalPicker" position="bottom">
        <van-picker
          show-toolbar
          :columns="levelPickerColumns"
          @confirm="onLevelPickerConfirm"
          @cancel="showLevalPicker = false"
        />
      </van-popup>

      <div class="biaoti-class">通知方式</div>
      <van-checkbox v-model="notice_checked" checked-color="#E7334A" icon-size="18px">APP消息推送</van-checkbox>

      <div class="noti-class" v-if="notice_checked">
        <van-radio-group
          v-model="pushModes"
          direction="horizontal"
          class="radio-class"
          icon-size="16"
          @change="onNoticeRadioChange"
        >
          <van-radio name="0" checked-color="#E7334A" icon-size="18px">全部住户</van-radio>
          <van-radio name="1" checked-color="#E7334A" icon-size="18px">仅业主</van-radio>
        </van-radio-group>
      </div>

      <div class="bottom-class">
        <span class="save" @click="saveNotice">保存</span>
        <span class="savePublic" @click="publicedNotice">保存并发布</span>
      </div>
    </div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";

import { typeList,createOrEditNotice } from '../service/gonggao-service'
export default {
  data() {
    return {
      id:'',

      typeId: '',
      typeName:'',
      typeload:true,
      showTypePicker: false,
      typePickerColumns: ["1", "2", "3", "4"],

      grade: "",
      gradeName:'',
      showLevalPicker: false,
      levelPickerColumns: [{
        text:'1级',
        value:1
      },{
        text:'2级',
        value:2
      },{
        text:'3级',
        value:3
      },{
        text:'4级',
        value:4
      },{
        text:'5级',
        value:5
      }],

      notice_checked: true,
      pushModes: '0'//0:全员1:仅员工
    };
  },
  mounted() {
    //是否有需要初始化的数据
    this.getInitData()
    //公告类型列表
    this.getTypeList()

    nav.setNavTitle({
      title: `${this.$route.query.params == "create" ? '新建':' 编辑'}`,
      titleColor: "#000000",
      titleSize: 18
    });
    
    nav.setNavLeftBtn({
      __event__:()=>{
        console.log(1231231)
        localStorage.setItem('secondStep',JSON.stringify({
          grade:this.grade,
          typeId:this.typeId,
          pushModes:this.pushModes,
        }))
        nav.navigatorPush({
          url: "/PublicAnnouncement1",
          params: `${this.pageType==='create'?'create':'edit'}`
        });
      }
    })
  },
  methods: {
    getInitData(){
      this.pageType = this.$route.query.params;
      let noticeDetail = null;
      if(this.pageType === 'edit'){
        //编辑时候获取接口数据
        noticeDetail = localStorage.getItem('editNotice');
        
      }else{
        console.log(this.$store.state.createNotice)
        //创建时候获取第二步的缓存 防止在下一步又返回第一步操作
        noticeDetail = localStorage.getItem('secondStep');
        console.log(noticeDetail)
      }
      if(noticeDetail){
        const noticeDetailObj = JSON.parse(noticeDetail);
        this.grade = noticeDetailObj.grade;
        this.typeId = noticeDetailObj.typeId;
        this.pushModes = noticeDetailObj.pushModes+'';
        this.id = noticeDetailObj.id;
      } 
    },
    //获取公告类型列表
    getTypeList(){
      typeList().then(res=>{
        console.log(res)
        if(res.result.code === 200){
          this.typeload = false;
          console.log(this.typeload)
          this.typePickerColumns = res.result.data;
        }
      })
    },
    //保存发布公告
    publicedNotice () {
      console.log('保存发布')
      const firstData = JSON.parse(localStorage.getItem('firstStep'));
      const param = {
        ...firstData,
        grade:this.grade,
        typeId:this.typeId,
        pushModes:this.pushModes,
        projectId:localStorage.getItem('projectId')
      }
      createOrEditNotice(param,this.id).then(res=>{
        console.log(res);
        localStorage.removeItem('firstStep');
      })
    },
    saveNotice(){

    },
    onTypeConfirm(item) {
      this.typeId = item.id;
      this.typeName = item.name;

      this.$store.commit('createNotice/publicedNotice',{name:'typeId',value:this.typeId})
      console.log(this.$store.state.createNotice)
      this.showTypePicker = false;
    },
    onLevelPickerConfirm(item) {
      this.grade = item.value;
      this.gradeName = item.text;
      
      this.showLevalPicker = false;
    },
    onNoticeRadioChange(value) {
      console.log(value);
    },
    afterRead(file) {
      // base64编码的图片
      this.imgFile = file.content;
    }
  }
};
</script>

<style lang="less" scoped>
.public-class {
  .top-class {
    padding: 20px;
    .row-class {
      border: 1px solid #f0f0f0;
      border-radius: 8px;
      margin-bottom: 10px;
    }
    .biaoti-class {
      text-align: left;
      font-family: PingFangSC-Regular;
      font-size: 14px;
      color: #8d8d8d;
      letter-spacing: 0;
      line-height: 14px;
      margin-bottom: 8px;
    }
    .radio-class {
      margin-top: 27px;
    }
  }
  .bottom-class {
    width: 100%;
    position: fixed;
    bottom: 22px;
    height: 44px;
    background-color: #f7f7f7;
    display: flex;
    line-height: 44px;
    .save {
      background: #ffffff;
      border: 1px solid #d8d8d8;
      border-radius: 8px;
      width: 43%;
      margin-right:15px;
    }
    .savePublic {
      background: #e7334a;
      border-radius: 8px;
      color:white;
      width: 43%;
    }
  }
}
</style>
