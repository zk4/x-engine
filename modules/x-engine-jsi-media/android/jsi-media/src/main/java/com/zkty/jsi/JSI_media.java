package com.zkty.jsi;


import android.util.Log;

import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSON;
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
import com.zkty.nativ.media.UpLoadImgCallback;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.LinkedHashMap;
import java.util.Map;

public class JSI_media extends xengine_jsi_media {
    private Nativemedia iMedia;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Imedia.class);
        if (module instanceof Nativemedia)
            iMedia = (Nativemedia) module;
    }




    @Override
    public void _previewImg(_0_com_zkty_jsi_media_DTO dto) {
        iMedia.preImage(dto.imgList, dto.index, new PreImageCallBack() {
            @Override
            public void closeCallBack() {
//                ToastUtils.showCenterToast("关闭");
            }
        });
    }


    @Override
    public void _openImagePicker(_3_com_zkty_jsi_media_DTO dto, CompletionHandler<String> handler) {
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
    public void _saveImageToPhotoAlbum(_2_com_zkty_jsi_media_DTO dto, CompletionHandler<_1_com_zkty_jsi_media_DTO> handler) {
        iMedia.saveImageToAlbum(dto.imageData, dto.type, new SaveCallBack() {
            @Override
            public void saveCallBack() {
                _1_com_zkty_jsi_media_DTO com_zkty_jsi_media_dto = new _1_com_zkty_jsi_media_DTO();
                com_zkty_jsi_media_dto.status = 0;
                handler.complete(com_zkty_jsi_media_dto);
            }
        });
    }

    @Override
    public void _uploadImage(_4_com_zkty_jsi_media_DTO dto, CompletionHandler<String> handler) {

        iMedia.upLoadImgList(dto.url, dto.ids, new UpLoadImgCallback() {
            @Override
            public void onUpLoadSucces(String status, String id, String dataStr,boolean isCommplete) {
                try {
                    Map<String, String> jsonObject = new LinkedHashMap<>();
                    jsonObject.put("status", status);
                    jsonObject.put("id", id);
                    jsonObject.put("result", dataStr);
                    Log.d("Nativemedia",isCommplete + "   " +JSON.toJSONString(jsonObject));
                    if(isCommplete){
                        handler.complete(JSON.toJSONString(jsonObject));
                    }else{
                        handler.setProgressData(JSON.toJSONString(jsonObject));
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onUploadFail() {

            }
        });
    }
}
