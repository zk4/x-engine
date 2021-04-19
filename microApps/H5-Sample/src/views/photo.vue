<template>
  <div class="photo">
    <van-button
      class="btn-class"
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="hanlderOpenAlert"
    >弹出拍照或选择相册的原生alert</van-button>

    <van-button
      class="btn-class"
      color="linear-gradient(to right, #4bb0ff, #6149f6)"
      size="large"
      round
      @click="handlerSavePhotoToAlbum"
    >保存图片至相册</van-button>
  </div>
</template>

<script>
import xengine from "@zkty-team/x-engine-core"
export default {
  methods: {
    hanlderOpenAlert() {
      xengine.api(
        "com.zkty.jsi.camera",
        "openImagePicker",
        {
          allowsEditing: true,
          savePhotosAlbum: false,
          cameraFlashMode: -1,
          cameraDevice: "back",
          photoCount: 5,
          args: { bytes: "100" },
          isbase64: true,
        },
        (res) => {
          let obj = JSON.parse(res)
          alert(JSON.stringify(obj))
          for (let photo of obj.data) {
            const image = document.createElement("img")
            if (!photo.width || !photo.height) {
              alert("要返回width,与height", photo)
            }
            image.src =
              "data:" + photo.contentType + ";base64,  " + photo.retImage
            image.style.cssText = "width:100%"
            document.body.appendChild(image)
          }
        }
      )
    },
    handlerSavePhotoToAlbum() {
      xengine.api(
        "com.zkty.jsi.camera",
        "saveImageToPhotoAlbum",
        {
          type: "url",
          imageData:
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201209%2F08%2F20120908134318_YVAwx.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1621332181&t=b8faabde36c3881b2e47aaf8d3f71891",
        },
        (res) => {
          console.log(res)
        }
      )
    },
  },
}
</script>

<style>
.btn-class {
  margin-top: 100px;
}
</style>