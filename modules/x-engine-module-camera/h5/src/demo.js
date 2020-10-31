
import camera from './index.js'

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

    