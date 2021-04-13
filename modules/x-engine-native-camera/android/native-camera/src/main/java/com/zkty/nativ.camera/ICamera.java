package com.zkty.nativ.camera;

public interface ICamera {
    void openImagePicker(CameraDTO dto, CallBack callBack);
}

interface CallBack {

    void success(CameraRetDTO dto);
}
