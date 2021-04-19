package com.zkty.jsi.camera;


import com.zkty.nativ.camera.CameraDTO;
import com.zkty.nativ.camera.CameraRetDTO;
import com.zkty.nativ.camera.ICamera;
import com.zkty.nativ.camera.NativeCamera;
import com.zkty.nativ.camera.OpenImageCallBack;
import com.zkty.nativ.camera.SaveCallBack;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;

public class JSI_camera extends xengine_jsi_camera {
    private NativeCamera iCamera;
    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(ICamera.class);
        if (module instanceof NativeCamera)
            iCamera = (NativeCamera) module;
    }

    @Override
    public void _openImagePicker(_0_com_zkty_jsi_camera_DTO dto, CompletionHandler<String> handler) {
        CameraDTO  cameraDTO = new CameraDTO();
        cameraDTO.setAllowsEditing(dto.allowsEditing);
        cameraDTO.setCameraDevice(dto.cameraDevice);
        cameraDTO.setCameraFlashMode(dto.cameraFlashMode);
        cameraDTO.setIsbase64(dto.isbase64);
        cameraDTO.setPhotoCount(dto.photoCount);
        cameraDTO.setSavePhotosAlbum(dto.savePhotosAlbum);
        cameraDTO.setArgs(dto.args);
        iCamera.openImagePicker(cameraDTO, new OpenImageCallBack() {
            @Override
            public void success(String dto) {
                handler.complete(dto);
            }
        });
    }

    @Override
    public void _saveImageToPhotoAlbum(_1_com_zkty_jsi_camera_DTO dto, CompletionHandler<String> handler) {
        iCamera.saveImageToAlbum(dto.imageData, dto.type, new SaveCallBack() {
            @Override
            public void saveCallBack() {
                handler.complete("succes");
            }
        });
    }
}
