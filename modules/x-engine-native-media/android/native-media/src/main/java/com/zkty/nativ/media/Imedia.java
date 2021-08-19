package com.zkty.nativ.media;

import com.zkty.nativ.media.cameraImpl.data.MediaFile;

import java.util.List;

public interface Imedia {
    void openImagePicker(CameraDTO dto, OpenImageCallBack callBack);
    void saveImageToAlbum(String imageData, String type, SaveCallBack callBack);
    void preImage(List<String> imageDataList, int index, PreImageCallBack callBack);
}
