<template>
  <div class="add_notice_detail" @touchstart="touchstart">
    <div class="add-btn-content">
      <span class="add-btn" @click="addText"><span class="text-add-icon"></span>添加文字</span>
      <van-uploader class="add-btn" :after-read="addPic" multiple :max-count="3">
        <span><span class="img-add-icon"></span>添加图片</span>
      </van-uploader>
    </div>
    <div v-if="data.length > 0" class="content">
      <div v-for="(item, index) in data" :key="index" class="container">
        <div v-if="item.type==='text'" class="text-content">
          <van-field
            v-model="item.content"
            rows="3"
            autosize
            type="textarea"
            maxlength="500"
            placeholder="请输入文本"
            show-word-limit
          />
          <span class="dele-btn" @click="deleteItem(index)"></span>
        </div>
        <div v-if="item.type==='pic'" class="img-content">
          <img :src="item.content" />
          <span class="dele-btn dele-btn-img" @click="deleteItem(index)"></span>
        </div>
        <div class="operate-wrapper">
          <span :class="{'hidden': index === 0}" type="link" @click="move(index, index - 1)">
          </span>
          <span :class="{'hidden': index === data.length - 1}" type="link" @click="move(index, index + 1)">
          </span>
        </div>
      </div>
    </div>
    <div class="sub-btn" @click="subMit">
      <span>下一步</span>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";
// import camera from "@zkty-team/x-engine-module-camera";
export default {
  name:'AddNoticeDetail',
  components: {

  },
  data () {
    return {
      pagetype: "",
      paras: "",
      projectId: this.$route.query.id,
      noticeId: "",
      data: [],
      type: ""
    }
  },
  mounted() {
    // nav.setNavRightBtn({
    //   title: "预览",
    //   titleColor: "#000000",
    //   titleSize: 16,
    //   icon: "",
    //   iconSize: ["20", "20"],
    //   __event__: () => {
    //     document.getElementById("debug_text").innerText = "ret: click right";
    //   },
    // })
  },
  created() {
    this.queryRedisNotice();
    this.noticeId = this.$route.query.noticeId;
    if (this.noticeId) {
      this.pagetype = "edit";
      this.getNoticeDetail();
      nav.setNavLeftBtn({ title: "编辑", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" });
    } else {
      this.pagetype = "add";
      nav.setNavLeftBtn({ title: "新建", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" });
    }

  },
  methods: {
    touchstart() {},
    toast() {
      this.$toast.loading({
        duration: 0,
        type: 'loading',
        message: '加载中...',
        forbidClick: true,
      });
    },
    queryRedisNotice() {
      const para = {
        id: this.$route.query.paraid
      };
      api.getRedisNotice(para).then(res => {
        if (res.code === 200) {
          this.paras = res.data;
        }
      }).finally(() => {

      });
    },
    getNoticeDetail() {
      const para = {
        id: this.noticeId,
      };
      api.getNoticeDetail(para).then(res => {
        if (res.code === 200) {
          this.data = res.data.details;
        }
      }).finally(() => {

      });
    },
    addText() {
      this.data.push({ type: 'text', content: '' });
    },
    addNotice() {
      const para = {
        detail: JSON.stringify(this.data)
      };
      const paras = Object.assign(this.paras,para);
      api.upPara(paras).then(res => {
        if (res.code === 200) {
          if (this.pagetype === "edit") {
            nav.navigatorPush({
              url: "/pushModes",
              params: encodeURI(
                `id=${this.projectId},paraid=${res.data.id},noticeId=${this.noticeId}`
              ),
            });
            // this.$router.push({ path: "/pushModes",query: { id: this.projectId, paraid: res.data.id, noticeId: this.noticeId } });
          } else {
            nav.navigatorPush({
              url: "/pushModes",
              params: encodeURI(
                `id=${this.projectId},paraid=${res.data.id}`
              ),
            });
            // this.$router.push({ path: "/pushModes",query: { id: this.projectId, paraid: res.data.id } });
          }
          // this.noticeTypeList = res.data;
        }
      }).finally(() => {

      });
    },
    addPic(fileList) {
        const formData = new FormData();
        if (fileList.length > 0) {
          fileList.forEach((file, index) => {
            formData.append('file' + index, file.file);
          });
        } else {
          formData.append('file', fileList.file);
        }
        api.uploadPropertyNoticePic(formData).then(res => {
          // alert(222)
          if (res.code === 200) {
            // alert(res.data[0])
            for (var i =0;i<res.data.length;i++) {
              this.data.push({ type: 'pic', content: res.data[i] });
            }

            this.$toast.clear();
            // 清空旧数据
            // this.picList = [];
          } else {
            // alert(res.message)
          }
        }).catch(() => {
          // alert(res.message)
        }).finally(() => {
        });
    },
    move(index, oppIndex) {
      const temp = this.data[index];
      this.data[index] = this.data[oppIndex];
      this.data[oppIndex] = temp;
      this.$forceUpdate();
    },
    deleteItem(index) {
      this.data.splice(index, 1);
      this.$forceUpdate();
    },
    subMit() {
      this.addNotice();
      console.log(this.data)

    }
  }
}
</script>


<style lang="less" scope>
.add_notice_detail{
  width: 100%;
  height: auto;
  padding: 68px 16px 100px 16px;
  .add-btn-content{
    position: fixed;
    top: 0px;
    width: 100%;
    padding: 20px 20px 0;
    left: 0;
    background: #fff;
    z-index: 9;
    .text-add-icon{
      width: 16px;
      height: 16px;
      display: inline-block;
      position: relative;
      top: 1px;
      margin-right: 7px;
      background: url("../../assets/img/text-add-icon.png");
      background-size: 100% 100%;
    }
    .img-add-icon{
      width: 16px;
      height: 16px;
      display: inline-block;
      position: relative;
      top: 1px;
      margin-right: 7px;
      background: url("../../assets/img/img-add-icon.png");
      background-size: 100% 100%;
    }
    .van-uploader__input-wrapper{
      width: 100%;
    }
    .add-btn:nth-child(1){
      margin-right: 10px;
    }
    .add-btn{
      width: calc(50% - 5px);
      padding: 12px 0;
      text-align: center;
      font-size: 16px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #121212;
      display: inline-block;
      border-radius: 24px;
      border: 1px solid #E8374A;
      border-style: dashed;
    }
  }

  .content{
    width: 100%;
    height: auto;
    padding: 20px 16px;
    margin-top: 20px;
    background: #FFFFFF;
    box-shadow: 0px 6px 30px 0px rgba(71, 77, 96, 0.06);
    border-radius: 16px;
    .text-content{
      position: relative;
    }
    .container{
      width: 100%;
      height: auto;
      position: relative;
      margin-bottom: 14px;
      .img-content img{
        width: 110px;
        height: 110px;
        border-radius: 8px;
      }
    }
    .van-cell{
      overflow: inherit;
      transform: inherit;
      left: inherit;
    }
    .dele-btn{
      width: 16px;
      height: 16px;
      display: inline-block;
      background: url("../../assets/img/del-icon.png");
      background-size: 100% 100%;
      top: -8px;
      right: 40px;
      position: absolute;
    }
    .dele-btn-img{
      left: 102px;
    }
    .van-field{
      width: calc(100% - 48px);
      min-height: 110px;
      background: #FFFFFF;
      border-radius: 8px;
      border: 1px solid #F0F0F0;
      position: relative;
    }
    .operate-wrapper{
      width: 24px;
      position: absolute;
      right: 4px;
      top: 0;
      padding-top: 28px;
      span{
        width: 24px;
        height: 24px;
        display: inline-block;
      }
      span.hidden:nth-child(1){
        background: url("../../assets/img/up-icon-disable.png");
        background-size: 100% 100%;
      }
      span.hidden:nth-child(2){
        background: url("../../assets/img/bottom-icon-disable.png");
        background-size: 100% 100%;
      }
      span:nth-child(1){
        background: url("../../assets/img/up-icon-default.png");
        background-size: 100% 100%;
      }
      span:nth-child(1):active,span:nth-child(1):focus{
        background: url("../../assets/img/up-icon-hover.png");
        background-size: 100% 100%;
      }
      span:nth-child(2){
        background: url("../../assets/img/bottom-icon-default.png");
        background-size: 100% 100%;
      }
      span:nth-child(2):active,span:nth-child(2):focus{
        background: url("../../assets/img/down-icon-hover.png");
        background-size: 100% 100%;
      }
    }

  }

  .sub-btn{
    width: 100%;
    position: fixed;
    bottom: 0;
    left: 0;
    padding: 0 16px 34px 16px;
    span{
      width: 100%;
      padding: 12px 0;
      display: inline-block;
      background: #E7334A;
      border-radius: 8px;
      font-size: 16px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #FFFFFF;
      text-align: center;
    }
  }

}
</style>
