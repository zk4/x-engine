package com.zkty.nativ.media2;

import android.graphics.Bitmap;

import java.util.List;

public interface Imedia2 {
    void openImagePicker(CameraDTO dto, OpenImageCallBack callBack);

    void saveImageUrlToAlbum(String imageData, SaveCallBack callBack);

    void saveImageBase64ToAlbum(String imageData, SaveCallBack callBack);

    void preImage(List<String> imageDataList, int index, PreImageCallBack callBack);

    void upLoadImgList(String url, List<String> filePathList, UpLoadImgCallback callback);
}
