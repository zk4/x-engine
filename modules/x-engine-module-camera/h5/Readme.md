
`
com.zkty.module.camera
`



## openImagePicker



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| allowsEditing | bool | true | true | 是否允许编辑 |
| savePhotosAlbum | bool | true |  | 是否保存图片到相册 |
| cameraFlashMode | int | true | -1 | 闪光灯模式(-1:关闭状态,0:自动开关状态,1:打开状态),默认:-1 |
| cameraDevice | string | true | back | 设置前置或后置摄像头(front:前置,back:后置),默认:back |
| isbase64 | bool |  | true | 图片是否转为Base64,默认:true |
| width | string |  | 200 | 裁剪宽度 |
| height | string |  | 100 | 裁剪高度 |
| quality | string |  | 0.5 | 压缩质量 |
| bytes | string |  | 1024 | 压缩到多少kb以内 |
| \_\_event\_\_ |  |  | (string)=>{} | 返回获取图片的地址 |

    