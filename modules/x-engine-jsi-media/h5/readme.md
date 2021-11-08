

JSI Id: com.zkty.jsi.media

version: 2.9.0



## previewImg
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
 预览图片


> **demo**
``` js

  xengine.api("com.zkty.jsi.media", "previewImg", {
    index: 0,
    imgList: ["http://xxxxxx", "https://xxxxxx"],
  });

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| index | int | 必填 |  | 用户点击索引 |
| imgList | Array\<string\> | 必填 |  | 图片数组, 多张用逗号分隔 |

**无返回值**



## saveImageToPhotoAlbum
[`async`](/docs/modules/模块-规范?id=jsi-调用)
 保存到相册<br>返回值: 0 保存成功<br>-1 保存失败


> **demo**
``` js

  xengine.api(
    "com.zkty.jsi.media",
    "saveImageToPhotoAlbum",
    {
      imgUrl: "http://xxx",
    },
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| imgUrl | string | 必填 |  | 图片地址 |

**返回值**
``` js
 {

  // 函数状态码
  // status = 0  成功
  // status = -1 失败
  status: int;
  // 函数状态描述
  msg: string;

}
``` 



## openImagePicker
[`async`](/docs/modules/模块-规范?id=jsi-调用)
 打开picker选择相册或相机


> **demo**
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
      document.getElementById("debug_text").innerText = JSON.stringify(res);
      let imgList = res.data;
      if (res.status == 0) {
        for (let img of imgList) {
          const image = document.createElement("img");
          image.src = "data:" + img.type + ";base64," + img.thumbnail;
          image.style.cssText =
            "width:100px; height:100px; margin-left:10px; border-radius:10px;";
          document.body.appendChild(image);
        }
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
 {

  // 函数状态码
  // status = 0  成功
  // status = -1 失败
  status: int;
  // 函数状态描述
  msg: string;
  data: Array<{

    // 图片id
    imgID: string;
    // 图片类型
    imgType: string;
    // 缩略图
    thumbnail: string;
  
};

}
``` 



## uploadImage
[`async`](/docs/modules/模块-规范?id=jsi-调用)
 上传图片


> **demo**
``` js

  xengine.api(
    "com.zkty.jsi.media",
    "uploadImage",
    {
      url: "http://xxx",
      imgIds: ["xxxx", "xxxxx", "xxxx", "xxxx"],
    },
    (res) => {
      document.getElementById("debug_text").innerText = JSON.stringify(res);
    }
  );

``` 

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求的url |
| imgIds | Array\<string\> | 必填 |  | 拍照或者选择相册后返回id |
| header | Map\<string,string\> | optional |  | 请求header |

**返回值**
``` js
 {

  // 函数状态码
  // status = 0  成功
  // status = -1 失败
  status: int;
  // 函数状态描述
  msg: string;
  // 图片id
  imgID: string;
  // 服务器返回的数据
  data: string;

}
``` 


    