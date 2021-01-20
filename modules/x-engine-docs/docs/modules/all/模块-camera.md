

**基座扫描测试**
<div id='modulename' style='display:none'>camera</div> <img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


version: 0.1.12
``` bash
npm install @zkty-team/x-engine-module-camera
```



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
        args:{width:'200',quality:'0.5'},
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
| allowsEditing | bool | optional | true | 是否允许编辑 |
| savePhotosAlbum | bool | optional |  | 是否保存图片到相册 |
| cameraFlashMode | int | optional | -1 | 闪光灯模式(-1:关闭状态,0:自动开关状态,1:打开状态),默认:-1 |
| cameraDevice | string | optional | back | 设置前置或后置摄像头(front:前置,back:后置),默认:back |
| isbase64 | bool | 必填 |  | 图片是否转为Base64,默认:true |
| args | Map\<string,string\> | 必填 |  | 裁剪参数 width:裁剪宽度; height:裁剪高度; quality:压缩质量; bytes:压缩到多少kb以内; |
| photoCount | int | optional | 1 |  图片选择张数 |
| \_\_event\_\_ | _0_com.zkty.module.camera_DTO | 必填 | (string)=>{} | 返回获取图片的地址 |


参数 object  定义
``` js


// dto
interface CameraDTO {

  //是否允许编辑
  allowsEditing?: boolean;
  //是否保存图片到相册
  savePhotosAlbum?: boolean;
  //闪光灯模式(-1:关闭状态,
0:自动开关状态,
1:打开状态),
默认:-1
  cameraFlashMode?: int;
  //设置前置或后置摄像头(front:前置,
back:后置),
默认:back
  cameraDevice?: string;
  //图片是否转为Base64,
默认:true
  isbase64: boolean;
  //裁剪参数 width:裁剪宽度; height:裁剪高度; quality:压缩质量; bytes:压缩到多少kb以内;
  args:Map<string,
string>;
  // 图片选择张数
  photoCount?: int;
  //返回获取图片的地址
  __event__: (string)=>void;
  

}
``` 


---------------------
**返回值**
``` js

interface CameraRetDTO {

  retImage: string;
  fileName:string;
  contentType:string;
  width: string;
  height: string;

}
``` 




## saveImageToAlbum

保存到相册

**demo**
``` js
{
  window.saveImageToAlbum = () => {
    camera
      .saveImageToAlbum({
        imageData:'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201410%2F20%2F20141020162058_UrMNe.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1611307946&t=175b540644bac34ec738e48ff42f8034'
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string | 必填 | url | url或base64 |
| imageData | string | 必填 |  |  |


参数 object  定义
``` js


interface SaveImageDTO {

  //url或base64
  type:string;
  imageData: string;

}
``` 


---------------------
**无返回值**



    

# iOS
需要添加info.plist中添加相册和相机权限：

```
<key>NSPhotoLibraryUsageDescription</key>
	<string>使用相册选择图片</string>
<key>NSCameraUsageDescription</key>
	<string>使用相机拍摄照片</string>
```



# android


