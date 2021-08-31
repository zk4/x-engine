
import media from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_placeholder = () => {
}
 document.getElementById("test_placeholder").click()
        window.test_placeholder = () => {
}
 document.getElementById("test_placeholder").click()
        window.test_placeholder = () => {
}
 document.getElementById("test_placeholder").click()
        window.test_previewImg = () => {

  xengine.api("com.zkty.jsi.media", "previewImg", {
    index: 0,
    imgList: [
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F-Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F4034970a304e251fae75ad03a786c9177e3e534e.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631950978&t=f96881f8b3efe3f4bffe9877ab942199",
      "https://upload-images.jianshu.io/upload_images/5809200-7fe8c323e533f656.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
    ],
  });
}
 document.getElementById("test_previewImg").click()
        window.test_saveImageToPhotoAlbum = () => {

  xengine.api(
    "com.zkty.jsi.media",
    "saveImageToPhotoAlbum",
    {
      type: "url",
      imageData:
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201410%2F20%2F20141020162058_UrMNe.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1611307946&t=175b540644bac34ec738e48ff42f8034",
    },
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );
}
 document.getElementById("test_saveImageToPhotoAlbum").click()
        window.test_openImagePicker = () => {

  xengine.api(
    "com.zkty.jsi.media",
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
      document.getElementById("debug_text").innerText = JSON.stringify(res);
      let obj = JSON.parse(res);
      for (let photo of obj.data) {
        const image = document.createElement("img");
        // 使用缩略图来展示小图
        image.src = "data:" + photo.type + ";base64,  " + photo.thumbnail;
        image.style.cssText =
          "width:100px; height:100px; margin-right:10px; border-radius:10px;";
        document.body.appendChild(image);
      }
    }
  );
}
 document.getElementById("test_openImagePicker").click()
        window.test_uploadImage = () => {

  xengine.api(
    "com.zkty.jsi.media",
    "uploadImage",
    {
      url:
        "https://api-uat.lohashow.com/gm-nxcloud-resource/api/nxcloud/res/upload",
      ids: ["xxxx", "xxxxx", "xxxx", "xxxx"],
      header: {},
    },
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );
}
 document.getElementById("test_uploadImage").click()
        
    