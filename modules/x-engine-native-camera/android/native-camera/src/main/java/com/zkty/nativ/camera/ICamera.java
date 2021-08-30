package com.zkty.nativ.camera;

public interface ICamera {
    void openImagePicker(CameraDTO dto, OpenImageCallBack callBack);
    void saveImageToAlbum(String imageData, String type, SaveCallBack callBack);
}

