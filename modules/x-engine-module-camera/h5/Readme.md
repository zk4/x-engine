
version: 0.0.57
``` bash
npm install @zkty-team/x-engine-module-camera
```



## openImagePicker



**demo**
``` js
 {
  window.openImagePicker = () => {
    camera
      .openImagePicker({
        allowsEditing: true,
        savePhotosAlbum: false,
        cameraFlashMode: -1,
        cameraDevice:'back',
        photoCount: 5,
        isbase64:true,
        __event__: (res) => {
            let photos = JSON.parse(res[0]);
            for(let photo of photos){
            const image         = document.createElement('img')
            image.src           = "data:image/png;base64,  " + photo.retImage;
            image.style.cssText = 'width:100%';
            document.body.appendChild(image);
            }

        }
      })
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| allowsEditing | bool | true | true | 是否允许编辑 |
| savePhotosAlbum | bool | true |  | 是否保存图片到相册 |
| cameraFlashMode | int | true | -1 | 闪光灯模式(-1:关闭状态,0:自动开关状态,1:打开状态),默认:-1 |
| cameraDevice | string | true | back | 设置前置或后置摄像头(front:前置,back:后置),默认:back |
| isbase64 | bool |  | true | 图片是否转为Base64,默认:true |
| args | Map\<string,string\> |  | {"width":"200","quality":"0.5"} | 裁剪参数 width:裁剪宽度; height:裁剪高度; quality:压缩质量; bytes:压缩到多少kb以内; |
| photoCount | int |  | 1 |  图片选择张数 |
| \_\_event\_\_ |  |  | (string)=>{} | 返回获取图片的地址 |

    