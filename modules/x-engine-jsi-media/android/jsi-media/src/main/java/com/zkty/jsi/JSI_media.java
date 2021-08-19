package com.zkty.jsi;


import androidx.annotation.Nullable;

import com.zkty.jsi.xengine_jsi_media;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.media.CameraDTO;
import com.zkty.nativ.media.Imedia;
import com.zkty.nativ.media.Nativemedia;
import com.zkty.nativ.media.PreImageCallBack;
import com.zkty.nativ.media.SaveCallBack;

public class JSI_media extends xengine_jsi_media {
    private Nativemedia iMedia;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Imedia.class);
        if (module instanceof Nativemedia)
            iMedia = (Nativemedia) module;
    }



    @Override
    public void _previewImg(_0_com_zkty_jsi_media_DTO dto, CompletionHandler<Nullable> handler) {
        iMedia.preImage(dto.imgList, dto.index, new PreImageCallBack() {
            @Override
            public void closeCallBack() {
//                ToastUtils.showCenterToast("关闭");
            }
        });
    }

    @Override
    public void _openImagePicker(_1_com_zkty_jsi_media_DTO dto, CompletionHandler<String> handler) {
        CameraDTO cameraDTO = new CameraDTO();
        cameraDTO.setAllowsEditing(dto.allowsEditing);
        cameraDTO.setCameraDevice(dto.cameraDevice);
        cameraDTO.setCameraFlashMode(dto.cameraFlashMode);
        cameraDTO.setIsbase64(dto.isbase64);
        cameraDTO.setPhotoCount(dto.photoCount);
        cameraDTO.setSavePhotosAlbum(dto.savePhotosAlbum);
        cameraDTO.setArgs(dto.args);
        XEngineApplication.getCurrentActivity().runOnUiThread(() -> {
            iMedia.openImagePicker(cameraDTO, dto1 -> handler.complete(dto1));
        });
    }

    @Override
    public void _saveImageToPhotoAlbum(_2_com_zkty_jsi_media_DTO dto, CompletionHandler<String> handler) {
        iMedia.saveImageToAlbum(dto.imageData, dto.type, new SaveCallBack() {
            @Override
            public void saveCallBack() {
                handler.complete("success");
            }
        });
    }
}
