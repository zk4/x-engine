
import camera from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_openImagePicker = () => {

  xengine.api(
    "com.zkty.jsi.camera",
    "openImagePicker",
    {
      allowsEditing: true,
      savePhotosAlbum: false,
      cameraFlashMode: -1,
      cameraDevice: "back",
      photoCount: 5,
      args: { bytes: "100" },
      isbase64: true,
      __event__: (ret) => {},
    },
    (val) => {
        const image         = document.createElement('img')
        image.src           = "data:image/png;base64,  " + val.retImage;
        image.style.cssText = 'width:100%';
        document.body.appendChild(image);

    }
  );
}
 document.getElementById("test_openImagePicker").click()
      
    