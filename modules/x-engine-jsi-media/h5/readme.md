

JSI Id: com.zkty.jsi.media

version: 2.8.1



## previewImg
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
> 预览图片
**demo**
``` js

  xengine.api("com.zkty.jsi.media", "previewImg", {
    // 索引
    index: 0,
    // 图片数组
    imgList: [
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F-Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F4034970a304e251fae75ad03a786c9177e3e534e.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1631950978&t=f96881f8b3efe3f4bffe9877ab942199",
      "https://upload-images.jianshu.io/upload_images/5809200-7fe8c323e533f656.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
      "https://upload-images.jianshu.io/upload_images/5809200-736bc3917fe92142.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
      "https://upload-images.jianshu.io/upload_images/5809200-a99419bb94924e6d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
    ],
  });

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| index | int | 必填 |  | 索引 |
| imgList | Array | 必填 |  | 图片数组 |
**无返回值**



## openImagePicker
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 调用相机
**demo**
``` js

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
      let obj = JSON.parse(res);
      for (let photo of obj.data) {
        let base64 = "data:" + photo.type + ";base64,  " + photo.thumbnail;
        console.log(base64);
      }
    }
  );

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| allowsEditing | bool | optional |  | 是否允许编辑 |
| savePhotosAlbum | bool | optional |  | 是否保存图片到相册 |
| cameraFlashMode | int | optional |  | 闪光灯模式(-1:关闭状态,0:自动开关状态,1:打开状态),默认:-1 |
| cameraDevice | string | optional |  | 设置前置或后置摄像头(front:前置,back:后置),默认:back |
| isbase64 | bool | 必填 |  | 图片是否转为Base64,默认:true |
| args | Map\<string,string\> | optional |  | 裁剪参数 width:裁剪宽度; height:裁剪高度; quality:压缩质量; bytes:压缩到多少kb以内; |
| photoCount | int | optional |  | 图片选择张数 |
**返回值**
``` js
string
``` 



## saveImageToPhotoAlbum
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 保存到相册
**demo**
``` js

  // demo code
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



## uploadImage
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 上传图片
**demo**
``` js

  // demo code
  xengine.api(
    "com.zkty.jsi.media",
    "uploadImage",
    {
      url:
        "https://api-uat.lohashow.com/gm-nxcloud-resource/api/nxcloud/res/upload",
      ids: ["xxxx", "xxxxx", "xxxx", "xxxx"],
    },
    (res) => {
      console.log(JSON.stringify(res));
    }
  );

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求的url |
| header | Map\<string,string\> | 必填 |  | 请求header |
| ids | Array | 必填 |  | 拍照或者选择相册后返回id |
**返回值**
``` js
string
``` 


    