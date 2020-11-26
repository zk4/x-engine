
import camera from './index.js'

  window.openImagePicker = () => {
    camera
      .openImagePicker({
        allowsEditing: true,
        savePhotosAlbum: false,
        cameraFlashMode: -1,
        cameraDevice:'back',
        multiselect: true,
        isbase64:true,
        args:{width:'200',height:'100',quality:'0.5',bytes:'1024'},
        __event__: (res) => {
          //如果获取链接，可以拼接参数，例：'?w=200&h=100&q=0.5&bytes=1024'

          var tag = document.getElementsByClassName('photo')[0];
          if(tag){
            // tag.setAttribute('src', res+'?w=200&h=100&q=0.5&bytes=1024');
            tag.setAttribute('src', res[0]);
          }else{
            // document.body.innerHTML += "<img class='photo' style='width: 100%' "+"src="+res+'?w=200&h=100&q=0.5&bytes=1024'+">";
            document.body.innerHTML += "<img class='photo' style='width: 100%' "+"src="+"'"+res[0]+"'"+">";
          }
        },
      })
      .then((res) => {
        // document.getElementById("debug_text").innerText = res;
      });
  };

    