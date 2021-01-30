<template>
  <div class="public-class">
    <div class="top-class">
      <div class="biaoti-class">标题</div>
      <van-field class="row-class" name='title' v-model="title" placeholder="请您在这里输入标题" :border="false" />

      <div class="biaoti-class">发布方</div>
      <van-field 
        class="row-class" 
        v-model="publisher" 
        placeholder="请输入发布方" 
        :border="false" 
        
      />

      <div class="biaoti-class">内容</div>
      <div class="bottom-class">
        <van-field
          v-model="detail"
          type="textarea"
          placeholder="请输入内容"
          class="content-class"
          :border="false"
          show-word-limit
          autosize
          
        />
        <div class="uploader-class">
          <van-uploader
            v-model="fileList"
            :after-read="afterRead"
            multiple
            :max-count="9"
            preview-size="88"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import nav from "@zkty-team/x-engine-module-nav";
export default {
  data() {
    return {
      title: '',
      publisher: '',
      detail: '',
      fileList: [],
      pageType:'create'
    };
  },
  mounted() {
    this.getInitData()
    // this.getTitle();
    // nav.setNavRightBtn({
    //   title: "下一步",
    //   titleColor: "#E8374A",
    //   titleSize: 14,
    //   __event__:()=>{
    //     localStorage.setItem('firstStep',JSON.stringify({
    //       title:this.title,
    //       publisher:this.publisher,
    //       detail:this.detail,
    //       fileList:this.fileList
    //     }))
    //     nav.navigatorPush({
    //       url: "/PublicAnnouncement2",
    //       params: `${this.pageType==='create'?'create':'edit'}`
    //     });
    //   }
    // });
  },
  
methods: {
  getInitData () {
    this.pageType = this.$route.query.params;
    let noticeDetail = null;
    if(this.pageType === 'edit'){
      //编辑时候获取接口数据
      noticeDetail = localStorage.getItem('editNotice');
    }else{
      //创建时候获取第一步的缓存 防止在下一步又返回第一步操作
      noticeDetail = localStorage.getItem('firstStep');
    }
    if(noticeDetail){
      const noticeDetailObj = JSON.parse(noticeDetail);
      this.title = noticeDetailObj.title;
      this.publisher = noticeDetailObj.publisher;
      this.detail = noticeDetailObj.detail; 
    }
      
  },
  // getTitle(){
  //     nav.setNavTitle({
  //       title: `${this.pageType == "create" ? '新建':' 编辑'}`,
  //       titleColor: "#000000",
  //       titleSize: 18
  //     });
  // },
    afterRead(file) {
      this.fileList = file.content;
    }
  }
};
</script>

<style lang="less">
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

    .bottom-class {
      border-radius: 8px;
      border: 1px solid #f0f0f0;
      .content-class {
        margin-top: 5px;
        margin-left: 5px;
        width: 95%;
        height: 250px;
      }
      .uploader-class {
        text-align: left;
      }
      .van-uploader__wrapper {
        display: flex;
        flex-direction: row;
        margin-left: 25px;
      }
      .van-uploader__input {
        border-radius: 20px;
      }
      .van-image__img {
        border-radius: 10px;
      }
      .uploader-button {
        background: #d8d8d8;
        border-radius: 10px;
      }
    }
  }
}
</style>
