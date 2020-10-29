
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
          console.log(res);
          //拼接参数，例：'?w=200&h=100&q=0.5&bytes=1024'
          document.getElementById("debug_text").innerText = res;
        
          var tag = document.getElementsByClassName('photo')[0];
          if(tag){
            tag.setAttribute('src', res);
          }else{
            document.body.innerHTML += "<img class='photo' style='width: 100%' "+"src="+res+">";
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
| isbase64 | bool |  | true |  |
| \_\_event\_\_ |  |  | (string)=>{} | 返回获取图片的地址 |

    