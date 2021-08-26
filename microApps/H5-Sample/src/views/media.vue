<template>
  <div class="media-class">
    <div>
      <van-button type="warning" size="large" round @click="openPicker">openPicker</van-button>
      <van-button
        type="primary"
        style="margin-top:10px"
        size="large"
        @click="previewImg"
        round
      >previewImg</van-button>
      <van-button
        type="warning"
        style="margin-top:10px"
        size="large"
        color="linear-gradient(to right, #4bb0ff, #6149f6)"
        round
        @click="uploadImage"
      >uploadImage</van-button>
      <van-button
        type="info"
        style="margin-top:10px"
        color="linear-gradient(to right, #013656, #7e57c2)"
        size="large"
        @click="saveImage"
        round
      >saveImageToAlbum</van-button>
    </div>

    <div class="content-class">
      <pre class="content-pre-class">{{contentText}}</pre>
    </div>
  </div>
</template>
  
  <script>
export default {
  data() {
    return {
      contentText: "",
      chooseImgList: [],
    }
  },
  mounted() {},
  methods: {
    // 打开picker
    // 1. 相机
    // 2. 相册
    openPicker() {
      this.$engine.api(
        "com.zkty.jsi.media",
        "openImagePicker",
        {
          allowsEditing: true,
          savePhotosAlbum: false,
          cameraFlashMode: -1,
          cameraDevice: "back",
          photoCount: 6,
          args: { bytes: "100" },
          isbase64: true,
        },
        (res) => {
          this.contentText = res
          let imgList = res.data
          if (res.status == 0)
            for (let img of imgList) {
              const image = document.createElement("img")
              image.src = "data:" + img.type + ";base64," + img.thumbnail
              image.style.cssText =
                "width:100px; height:100px; margin-left:10px; border-radius:10px;"
              document.body.appendChild(image)
              this.chooseImgList.push(img.imgID)
            }
        }
      )
    },

    // 预览图片
    previewImg() {
      if (this.chooseImgList.length > 0) {
        this.$engine.api("com.zkty.jsi.media", "previewImg", {
          // 索引
          index: 0,
          // 图片数组
          imgList: this.chooseImgList,
        })
      } else {
        this.$toast("先openPicker后preview")
      }
    },

    // 上传图片
    uploadImage() {
      if (this.chooseImgList.length > 0) {
        this.$engine.api(
          "com.zkty.jsi.media",
          "uploadImage",
          {
            url:
              "https://api-uat.lohashow.com/gm-nxcloud-resource/api/nxcloud/res/upload",
            ids: this.chooseImgList,
            header: {},
          },
          (res) => {
            this.contentText = res
            if (res.status == 0) {
              this.$toast(res.data)
            } else {
              this.$toast(res.msg)
            }
          }
        )
      } else {
        this.$toast("先openPicker后preview")
      }
    },

    // 保存相册
    saveImage() {
      this.$engine.api(
        "com.zkty.jsi.media",
        "saveImageToPhotoAlbum",
        {
          type: "url",
          imageData:
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201410%2F20%2F20141020162058_UrMNe.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1611307946&t=175b540644bac34ec738e48ff42f8034",
        },
        (res) => {
          if (res.status == 0) {
            this.$toast.success(res.msg)
          } else {
            this.$toast.error(res.msg)
          }
        }
      )
    },
  },
}
</script>
  
  <style>
.media-class {
  margin: 0 10px;
}
.content-class {
  width: 100%;
  border-radius: 10px;
  margin-top: 10px;
  color: rgb(10, 8, 8);
  background-color: #f2f2f2;
  text-align: left;
  padding: 5px;
}
.content-pre-class {
  word-wrap: break-word;
}
</style>