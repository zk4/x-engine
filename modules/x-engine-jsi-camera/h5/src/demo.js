
import camera from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openImagePicker = () => {

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
      isbase64: true
    },
    (res) => {
      let obj = JSON.parse(res);
      for (let photo of obj.data) {
        const image = document.createElement("img");
        if (!photo.width || !photo.height) {
          alert("要返回width,与height", photo);
        }
        image.src = "data:" + photo.contentType + ";base64,  " + photo.retImage;
        image.style.cssText = "width:100%";
        document.body.appendChild(image);
      }
    }
  );
}
 document.getElementById("test_openImagePicker").click()
      window.test_saveImageToPhotoAlbum = () => {

  xengine.api(
    "com.zkty.jsi.camera",
    "saveImageToPhotoAlbum",
    {
      type: "url",
      imageData:
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201410%2F20%2F20141020162058_UrMNe.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1611307946&t=175b540644bac34ec738e48ff42f8034",
    });
}
 document.getElementById("test_saveImageToPhotoAlbum").click()
      
    