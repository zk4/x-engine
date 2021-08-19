package com.zkty.nativ.media;

public interface Imedia {
    void openImagePicker(CameraDTO dto, OpenImageCallBack callBack);
    void saveImageToAlbum(String imageData, String type, SaveCallBack callBack);
}
