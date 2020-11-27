
import camera from './index.js'

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
            if(!photo.width || !photo.height)
              {

                alert('要返回width,与height',photo);
              }

            image.src           = "data:image/png;base64,  " + photo.retImage;
            image.style.cssText = 'width:100%';
            document.body.appendChild(image);
            }

        }
      })
  };

    