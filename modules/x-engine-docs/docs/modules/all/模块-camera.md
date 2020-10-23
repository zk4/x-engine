

**基座扫描测试**
<div id='modulename' style='display:none'>camera</div>
<img id='qrimg' src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=http://192.168.44.52:3000/docs/modules/all/dist/ui/index.html'></img>
<a id='qrlink' href="about:none">link of QR</a>



# JS


``` bash
npm install @zkty-team/com-zkty-module-camera
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
| allowsEditing | bool | true | true |  |
| savePhotosAlbum | bool | true |  |  |
| cameraFlashMode | int | true | -1 |  |
| cameraDevice | string | true | back |  |
| \_\_event\_\_ | string |  |  |  |

    

# iOS


# android


