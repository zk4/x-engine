

**基座扫描测试**
<div id='modulename' style='display:none'>camera</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


version: 0.0.60
``` bash
npm install @zkty-team/x-engine-module-camera
```



## openImagePicker


  返回数据有做调整, 0.58 后在反序列字符串后会得到一个对象,对象里的 data 有一个数组.里面保存了图片的的json对象序列.
  data:{
    [
      retImage: string;
      fileName:string;
      contentType:string;
      width: string;
      height: string;
    ]
  }
  见 demo


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
            let jres = JSON.parse(res);
            for(let photo of jres.data){
            const image         = document.createElement('img')

            if(!photo.width || !photo.height){
              alert('要返回width,与height',photo);
            }

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
| photoCount | int | true | 1 |  图片选择张数 |
| \_\_event\_\_ |  |  | (string)=>{} | 返回获取图片的地址 |

    

# iOS
需要添加info.plist中添加相册和相机权限：

```
<key>NSPhotoLibraryUsageDescription</key>
	<string>使用相册选择图片</string>
<key>NSCameraUsageDescription</key>
	<string>使用相机拍摄照片</string>
```



# android


