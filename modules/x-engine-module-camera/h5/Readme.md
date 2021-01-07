
`
com.zkty.module.camera
`



## openImagePicker


  返回数据有做调整, 0.58 后在反序列字符串后会得到一个对象,对象里的 data 有一个数组.里面保存了图片的的json对象序列.
  ``` json
  data:{
    [
      retImage: string;
      fileName:string;
      contentType:string;
      width: string;
      height: string;
    ]
  }
  ```
  见 demo


	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| allowsEditing | bool | true | true | 是否允许编辑 |
| savePhotosAlbum | bool | true |  | 是否保存图片到相册 |
| cameraFlashMode | int | true | -1 | 闪光灯模式(-1:关闭状态,0:自动开关状态,1:打开状态),默认:-1 |
| cameraDevice | string | true | back | 设置前置或后置摄像头(front:前置,back:后置),默认:back |
| isbase64 | bool |  |  | 图片是否转为Base64,默认:true |
| args | Map\<string,string\> |  |  | 裁剪参数 width:裁剪宽度; height:裁剪高度; quality:压缩质量; bytes:压缩到多少kb以内; |
| photoCount | int | true | 1 |  图片选择张数 |
| \_\_event\_\_ |  |  | (string)=>{} | 返回获取图片的地址 |


## saveImageToAlbum

保存到相册

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string |  | url | url或base64 |
| imageData | string |  |  |  |

    