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
import com.zkty.nativ.media.CameraRetDTO;
import com.zkty.nativ.media.Imedia;
import com.zkty.nativ.media.Nativemedia;
import com.zkty.nativ.media.OpenImageCallBack;
import com.zkty.nativ.media.PreImageCallBack;
import com.zkty.nativ.media.SaveCallBack;
import com.zkty.nativ.media.UpLoadImgCallback;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
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
    public void _openImagePicker(_5_com_zkty_jsi_media_DTO dto, CompletionHandler<_3_com_zkty_jsi_media_DTO> handler) {
        CameraDTO cameraDTO = new CameraDTO();
        cameraDTO.setAllowsEditing(dto.allowsEditing);
        cameraDTO.setCameraDevice(dto.cameraDevice);
        cameraDTO.setCameraFlashMode(dto.cameraFlashMode);
        cameraDTO.setIsbase64(dto.isbase64);
        cameraDTO.setPhotoCount(dto.photoCount);
        cameraDTO.setSavePhotosAlbum(dto.savePhotosAlbum);
        cameraDTO.setArgs(dto.args);
        XEngineApplication.getCurrentActivity().runOnUiThread(() -> {
            iMedia.openImagePicker(cameraDTO, new OpenImageCallBack() {
                @Override
                public void success(List<CameraRetDTO> data) {
                    ArrayList<_4_com_zkty_jsi_media_DTO> imglist = new ArrayList<>();
                    for (int i = 0; i < data.size(); i++) {
                        _4_com_zkty_jsi_media_DTO  dto4 = new _4_com_zkty_jsi_media_DTO();
                        dto4.imgID = data.get(i).getId();
                        dto4.thumbnail = data.get(i).getThumbnail();
                        dto4.type = data.get(i).getType();
                        imglist.add(dto4);
                    }
                    _3_com_zkty_jsi_media_DTO dto1 = new _3_com_zkty_jsi_media_DTO();
                    dto1.msg = "选择图片成功";
                    dto1.status = 0;
                    dto1.data = imglist;
                    handler.complete(dto1);
                }
            });
        });
    }

    @Override
    public void _uploadImage(_7_com_zkty_jsi_media_DTO dto, CompletionHandler<_6_com_zkty_jsi_media_DTO> handler) {
        iMedia.upLoadImgList(dto.url, dto.ids, new UpLoadImgCallback() {
            @Override
            public void onUpLoadSucces(int status, String id,String msg, String dataStr,boolean isCommplete) {
                try {
                    _6_com_zkty_jsi_media_DTO dto1 = new _6_com_zkty_jsi_media_DTO();
                    dto1.data = dataStr;
                    dto1.status = status;
                    dto1.imgID = id;
                    dto1.msg = msg;
                    if(isCommplete){
                        handler.complete(dto1);
                    }else{
                        handler.setProgressData(dto1);
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
