

**基座扫描测试**
<div id='modulename' style='display:none'>camera</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


version: 0.0.55
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
        __event__: (res) => {
          //如果获取链接，可以拼接参数，例：'?w=200&h=100&q=0.5&bytes=1024'

          var tag = document.getElementsByClassName('photo')[0];
          if(tag){
            // tag.setAttribute('src', res+'?w=200&h=100&q=0.5&bytes=1024');
            tag.setAttribute('src', "data:image/png;base64,"+res);
          }else{
            // document.body.innerHTML += "<img class='photo' style='width: 100%' "+"src="+res+'?w=200&h=100&q=0.5&bytes=1024'+">";
            document.body.innerHTML += "<img class='photo' style='width: 100%' "+"src="+"'data:image/png;base64,"+res+"'"+">";
          }
        },
      })
      .then((res) => {
        // document.getElementById("debug_text").innerText = res;
      });
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
| args | Map\<string,string\> |  | {"width":"200","height":"100","quality":"0.5","bytes":"1024"} | 裁剪参数 width:裁剪宽度; height:裁剪高度; quality:压缩质量; bytes:压缩到多少kb以内; |
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


