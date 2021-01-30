<template>
  <div class="public-class">
    <div class="top-class">
      <van-field class="row-class" v-model="titleValue" label="标题" placeholder="请您在这里输入标题" />
      <van-field class="row-class" v-model="publicValue" label="发布方" placeholder="请输入发布方" />
      <van-field
        class="row-class"
        readonly
        clickable
        name="picker"
        :value="typePickerValue"
        label="类型"
        placeholder="请选择类型"
        @click="showTypePicker = true"
      />
      <van-popup v-model="showTypePicker" position="bottom">
        <van-picker
          show-toolbar
          :columns="typePickerColumns"
          @confirm="onTypeConfirm"
          @cancel="showTypePicker = false"
        />
      </van-popup>

      <van-field
        class="row-class"
        readonly
        clickable
        name="picker"
        :value="levelPickerValue"
        label="公告等级"
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

      <div class="noti-class">
        <span class="noti-title">App消息推送</span>
        <van-switch class="noti-switch" v-model="checked" @change="onSwitchChange" :size="25" />
      </div>

      <div class="noti-class" v-if="isShowRadio">
        <van-radio-group v-model="radio" direction="horizontal" class="radio-class" icon-size="16">
          <van-radio name="0">全部住户</van-radio>
          <van-radio name="1">仅业主</van-radio>
        </van-radio-group>
      </div>

      <van-field
        class="row-class"
        v-model="contentValue"
        label="内容"
        type="textarea"
        placeholder="请输入内容"
        maxlength="200"
        show-word-limit
        autosize
      />

      <div class="uploader-class">
        <van-uploader  v-model="fileList" class="uploader-button" :after-read="afterRead" multiple :max-count="6" preview-size="100"/>
      </div>
    </div>

    <div class="bottom-class">
      <span class="save">保存</span>
      <span class="savePublic">保存并发布</span>
    </div>
  </div>
</template>

<script>
import nav from "@zkty-team/x-engine-module-nav";
export default {
  data() {
    return {
      fileList: [],
      titleValue: "",
      publicValue: "",
      contentValue: "",
      typePickerValue: "",
      showTypePicker: false,
      typePickerColumns: ["粉色丝袜", "肉色丝袜", "黑色丝袜", "白色丝袜"],

      levelPickerValue: "",
      showLevalPicker: false,
      levelPickerColumns: ["1级", "2级", "3级", "4级", "5级"],

      isShowRadio: false,
      checked: false,
      radio: 1
    };
  },
  mounted() {
    if (this.$route.query.params == "create") {
      nav.setNavTitle({
        title: "新建",
        titleColor: "#000000",
        titleSize: 18
      });
    } else {
      nav.setNavTitle({
        title: "编辑",
        titleColor: "#000000",
        titleSize: 18
      });
    }

    nav.setNavRightBtn({
      title: "下一步",
      titleColor: "#E8374A",
      titleSize: 14
    });
  },
  methods: {
    onTypeConfirm(value) {
      this.typePickerValue = value;
      this.showTypePicker = false;
    },
    onLevelPickerConfirm(value) {
      this.levelPickerValue = value;
      this.showLevalPicker = false;
    },
    onSwitchChange(checked) {
      this.checked = checked;
      if (checked == false) {
        this.isShowRadio = false;
      } else {
        this.isShowRadio = true;
      }
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
      background-color: #f7f7f7;
      border-radius: 20px;
      margin-bottom: 10px;
    }
    .noti-class {
      border-radius: 20px;
      background-color: #f7f7f7;
      margin-bottom: 10px;
      display: flex;
      height: 44px;
      .noti-title {
        font-size: 14px;
        color: #646566;
        line-height: 44px;
        margin-left: 15px;
        font-family: "Avenir, Helvetica, Arial, sans-serif";
      }
      .noti-switch {
        margin-top: 8px;
        margin-left: 20px;
      }
      .radio-class {
        margin-left: 50px;
      }
    }
    .uploader-class {
      border-radius: 20px;
      background-color: #f7f7f7;
      display: flex;
      .uploader-button{
        padding-left: 10px;
        padding-top: 10px;
      }
    }
  }
  .bottom-class {
    width: 100%;
    position: fixed;
    bottom: 0;
    height: 44px;
    background-color: #f7f7f7;
    display: flex;
    line-height: 44px;
    .save {
      width: 50%;
      border-right: 1px solid white;
    }
    .savePublic {
      width: 50%;
    }
  }
}
</style>
