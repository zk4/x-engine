

JSI Id: com.zkty.jsi.camera

version: 0.1.13



## openImagePicker
`async`
> 调用相机
**demo**
``` js

  function test_openImagePicker() {
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
        let obj = JSON.parse(res);
        for (let photo of obj.data) {
          const image = document.createElement("img");
          if (!photo.width || !photo.height) {
            alert("要返回width,与height", photo);
          }
          image.src =
            "data:" + photo.contentType + ";base64,  " + photo.retImage;
          image.style.cssText = "width:100%";
          document.body.appendChild(image);
        }
      }
    );
  }

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| allowsEditing | bool | optional |  | 是否允许编辑 |
| savePhotosAlbum | bool | optional |  | 是否保存图片到相册 |
| cameraFlashMode | int | optional |  | 闪光灯模式(-1:关闭状态,0:自动开关状态,1:打开状态),默认:-1 |
| cameraDevice | string | optional |  | 设置前置或后置摄像头(front:前置,back:后置),默认:back |
| isbase64 | bool | 必填 |  | 图片是否转为Base64,默认:true |
| args | Map\<string,string\> | 必填 |  | 裁剪参数 width:裁剪宽度; height:裁剪高度; quality:压缩质量; bytes:压缩到多少kb以内; |
| photoCount | int | optional |  | 图片选择张数 |
**返回值**
``` js
string
``` 



## saveImageToPhotoAlbum
`async`
> 保存到相册
**demo**
``` js

  // 保存图片至相册
  function test_saveImageToPhotoAlbum() {
    xengine.api(
      "com.zkty.jsi.camera",
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

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | 必填 |  | url或base64 |
| imageData | string | 必填 |  | 图片数据 |
**返回值**
``` js
string
``` 


    