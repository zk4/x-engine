

JSI Id: com.zkty.jsi.media

version: 2.8.1



## previewImg
[`sync`](/docs/modules/模块-规范?id=jsi-调用)
> 预览图片

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| index | int | 必填 |  | 索引 |
| imgList | Array\<string\> | 必填 |  | 图片数组, 多张用逗号分隔 |
**无返回值**



## saveImageToPhotoAlbum
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 保存到相册<br>返回值: 0 保存成功<br>-1 保存失败

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | 必填 |  | url或base64 |
| imageData | string | 必填 |  | 图片数据 |
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
> 打开picker选择相册或相机

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

    imgID: string;
    type: string;
    thumbnail: string;
  
}>;

}
``` 



## uploadImage
[`async`](/docs/modules/模块-规范?id=jsi-调用)
> 上传图片

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | 必填 |  | 请求的url |
| header | Map\<string,string\> | 必填 |  | 请求header |
| ids | Array | 必填 |  | 拍照或者选择相册后返回id |
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
  data: Map<string,
 string>;

}
``` 


    