

JSI Id: com.zkty.jsi.camera

version: 0.1.13



## openImagePicker
`async`
> 调用相机

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
| \_\_event\_\_ | _2_com.zkty.jsi.camera_DTO | 必填 |  | 返回获取图片的地址 |
**返回值**
``` js
 {

  retImage: string;
  fileName: string;
  contentType: string;
  width: string;
  height: string;

}
``` 



## saveImageToPhotoAlbum
`sync`
> 保存到相册

**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | 必填 |  | url或base64 |
| imageData | string | 必填 |  |  |
**返回值**
``` js
void
``` 


    