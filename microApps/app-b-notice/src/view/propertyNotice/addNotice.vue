<template>
  <div class="add-notice">
    <div>{{pagetype === "add" ? "添加" : "编辑"}}</div>
    <div class="menu">
      <van-dropdown-menu>
        <van-dropdown-item v-model="projectIndex" :options="projectList" @change="checkItem"/>
      </van-dropdown-menu>
    </div>
    <van-form @submit="onSubmit">
      <div class="form-content">
        <div class="form-nav-header">标题</div>
        <van-field v-model="title" name="title" placeholder="请您在这里输入标题" @input="fieldChange" maxlength="30" />
        <div class="form-nav-header">发布方</div>
        <van-field v-model="publisher" name="publisher" placeholder="请输入发布方" @input="fieldChange" maxlength="13" />
        <div class="form-nav-header">类型</div>
        <van-field
          readonly
          clickable
          name="type"
          :value="type"
          right-icon="arrow-down"
          @click="showPicker = true"
        />
        <van-popup v-model="showPicker" position="bottom">
          <van-picker
            show-toolbar
            :columns="columnsType"
            @confirm="onConfirmType"
            @cancel="showPicker = false"
          />
        </van-popup>
        <div class="form-nav-header">公告等级</div>
        <van-field
          readonly
          clickable
          name="grade"
          :value="grade"
          right-icon="arrow-down"
          @click="showPickerGrade = true"
        />
        <van-popup v-model="showPickerGrade" position="bottom">
          <van-picker
            show-toolbar
            :columns="columnsGrade"
            @confirm="onConfirm"
            @cancel="showPickerGrade = false"
          />
        </van-popup>
      </div>

      <div class="subbottom-content">
        <van-button class="sub-button" :data-color="canSub" type="primary" :color="color" native-type="submit">确定</van-button>
      </div>
    </van-form>

  </div>
</template>

<script>
import api from "@/api";
import nav from "@zkty-team/x-engine-module-nav";

export default  {
  name:"AddNotice",
  components: {

  },
  data () {
    return {
      pagetype: "",
      projectList: [],
      projectIndex: "",
      showPicker: false,
      showPickerGrade: false,
      projectId: "",
      title: "",
      publisher: "",
      type: "",
      typeId: "",
      gradeId: 1,
      grade: "普通",
      columnsType: [],
      columnsGrade: ["普通","提示","重要","紧急","非常紧急"],
      gradeIdArr: [1,2,3,4,5],
      isChoose: "false",
      canSub: false,
      color: "#F5F5F6",
      time: 60,
      smsSendBtn: false
    }
  },
  created() {
    this.noticeId = this.$route.query.noticeId;
    if (this.noticeId) {
      this.pagetype = "edit";
      this.getNoticeDetail();
      nav.setNavLeftBtn({ title: "编辑", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    } else {
      this.pagetype = "add";
      nav.setNavLeftBtn({ title: "新建", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    }

  },
  mounted() {
    // nav.setNavLeftBtn({ title: "新建", titleColor: "#000000", titleSize: 24, titleFontName: "PingFangSC-Medium", titleBig: "500" })
    this.getProjectList();
    this.getAllNoticeType();
  },
  methods: {
    getProjectList() {
      api.getProjectList().then(res => {
        if (res.code === 200) {
          for (var i = 0;i<res.data.length; i++) {
            this.projectList.push({
              text: res.data[i].name,
              value: res.data[i].id
            })
          }
          // console.log()
          // this.projectList = this.projectList;
          if (this.$route.query.id) {
            this.projectIndex = this.$route.query.id;
            this.projectId = this.$route.query.id;
          } else {
            this.projectIndex = res.data[0].id;
            this.projectId = res.data[0].id;
          }
          this.fieldChange();
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
          this.title = res.data.title;
          this.publisher = res.data.publisher;
          this.type = res.data.typeName;
          this.typeId = res.data.typeId;
          this.gradeId = res.data.grade;
          this.grade = this.columnsGrade[res.data.grade - 1];
          this.fieldChange();
        }
      }).finally(() => {

      });
    },
    getAllNoticeType() {
      api.getAllNoticeType().then(res => {
        if (res.code === 200) {
          this.data = res.data;
          this.type = res.data[0].name;
          this.typeId = res.data[0].id;
          for (var m = 0;m<res.data.length;m++) {
            this.columnsType.push(res.data[m].name);
          }
          // this.noticeTypeList = res.data;

        }
      }).finally(() => {

      });
    },
    checkItem(id) {
      this.projectId = id;
    },
    changeMessage(value) {
      console.log(value)
      // this.message = value;
    },
    onConfirm(value,index) {
      this.grade = value;
      this.gradeId = this.gradeIdArr[index];
      this.showPickerGrade = false;
    },
    onConfirmType(value,index) {
      this.type = value;
      this.typeId = this.data[index].id;
      this.showPicker = false;
    },
    onSubmit(values) {
      // this.$router.push({ path: "/addNoticeDetail",query: { id: this.projectId } });
      const para = {
        projectId: this.projectId,
        title: values.title,
        publisher: values.publisher,
        typeId: this.typeId,
        grade: this.gradeId
      };
      api.upPara(para).then(res => {
        if (res.code === 200) {
          if (this.pagetype === "edit") {
            nav.navigatorPush({
              url: "/addNoticeDetail",
              params: encodeURI(
                `id=${this.projectId},paraid=${res.data.id},noticeId=${this.noticeId}`
              ),
            });
            // this.$router.push({ path: "/addNoticeDetail",query: { id: this.projectId, paraid: res.data.id, noticeId: this.noticeId } });
          } else {
            nav.navigatorPush({
              url: "/addNoticeDetail",
              params: encodeURI(
                `id=${this.projectId},paraid=${res.data.id}`
              ),
            });
            // this.$router.push({ path: "/addNoticeDetail",query: { id: this.projectId, paraid: res.data.id } });
          }
          // this.noticeTypeList = res.data;
        }
      }).finally(() => {

      });
      console.log(values);
    },
    changeChoose() {
      if (this.isChoose === "false") {
        this.isChoose = "true";
      } else {
        this.isChoose = "false";
      }
      this.fieldChange();
    },
    fieldChange() {
      if (this.projectId && this.title && this.publisher && this.typeId) {
        this.canSub = true;
        this.color = "#E8374A";
      } else {
        this.canSub = false;
        this.color = "#F5F5F6";
      }
    },
    sendCode() {
      if (!this.phonenum) {
        this.$toast("请输入手机号");
      } else {
        this.smsSendBtn = true;
        const interval = window.setInterval(() => {
          if (this.time-- <= 0) {
            this.time = 60;
            this.smsSendBtn = false;
            window.clearInterval(interval)
          }
        }, 1000)
        // api.sendCode(para).then(res => {
        //   if (res.code === 200) {
        //     console.log("成功")
        //   }
        // }).finally(() => {
        //   setTimeout(hide, 1)
        //   clearInterval(interval)
        //   this.time = 60
        //   this.smsSendBtn = false
        // });
      }

    },
    turn_detail() {
      this.$router.push({ path: "/property_detail" })
    },
  }
}
</script>


<style lang="less" scope>
.add-notice{
  width: 100%;
  height: auto;
  padding: 20px 16px 98px 16px;
  .form-content{
    margin-top: 10px;
  }
}
</style>
