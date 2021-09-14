package com.zkty.nativ.media;

import java.util.List;
import java.util.Map;

public interface Imedia {
    void openImagePicker(CameraDTO dto, OpenImageCallBack callBack);

    void saveImageUrlToAlbum(String imageData, SaveCallBack callBack);

    void saveImageBase64ToAlbum(String imageData, SaveCallBack callBack);

    void preImage(List<String> imageDataList, int index, PreImageCallBack callBack);

    void upLoadImgList(String url, List<String> filePathList, Map<String,String> header, UpLoadImgCallback callback);
}
