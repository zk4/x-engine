package com.zkty.jsi;


import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.media2.CameraDTO;
import com.zkty.nativ.media2.CameraRetDTO;
import com.zkty.nativ.media2.Imedia2;
import com.zkty.nativ.media2.Nativemedia2;
import com.zkty.nativ.media2.OpenImageCallBack;
import com.zkty.nativ.media2.PreImageCallBack;
import com.zkty.nativ.media2.SaveCallBack;
import com.zkty.nativ.media2.UpLoadImgCallback;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class JSI_media2 extends xengine_jsi_media2 {

    private Nativemedia2 iMedia;

    private final static String CUSTOMID = "customId";

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Imedia2.class);
        if (module instanceof Nativemedia2)
            iMedia = (Nativemedia2) module;
    }


    @Override
    public void _previewImg(_0_com_zkty_jsi_media2_DTO dto) {
        for (int i = 0; i < dto.imgList.size(); i++) {
            String imgUrl = dto.imgList.get(i);
            //如果是存储的ID  则 从缓存中 获取 真是图片路径
            if(imgUrl.startsWith(CUSTOMID)){
                imgUrl = ImageCacheManager.get(imgUrl);
            }
            dto.imgList.set(i,imgUrl);
        }
        iMedia.preImage(dto.imgList, dto.index, new PreImageCallBack() {
            @Override
            public void closeCallBack() {
//                ToastUtils.showCenterToast("关闭");
            }
        });
    }

    @Override
    public void _saveImageToPhotoAlbum(_2_com_zkty_jsi_media2_DTO dto, CompletionHandler<_1_com_zkty_jsi_media2_DTO> handler) {
        _1_com_zkty_jsi_media2_DTO com_zkty_jsi_media_dto = new _1_com_zkty_jsi_media2_DTO();
        if ("url".equals(dto.type)) {
            iMedia.saveImageUrlToAlbum(dto.imageData,new SaveCallBack() {
                @Override
                public void saveCallBack(int status, String msg) {
                    com_zkty_jsi_media_dto.status = status;
                    com_zkty_jsi_media_dto.msg = msg;
                    handler.complete(com_zkty_jsi_media_dto);
                }
            });
        } else {
            iMedia.saveImageBase64ToAlbum( dto.imageData, new SaveCallBack() {
                @Override
                public void saveCallBack(int status, String msg) {
                    com_zkty_jsi_media_dto.status = status;
                    com_zkty_jsi_media_dto.msg = msg;
                    handler.complete(com_zkty_jsi_media_dto);
                }
            });
        }
    }

    @Override
    public void _openImagePicker(_5_com_zkty_jsi_media2_DTO dto, CompletionHandler<_3_com_zkty_jsi_media2_DTO> handler) {
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
                    ArrayList<_4_com_zkty_jsi_media2_DTO> imglist = new ArrayList<>();
                    for (int i = 0; i < data.size(); i++) {
                        _4_com_zkty_jsi_media2_DTO  dto4 = new _4_com_zkty_jsi_media2_DTO();
                        //转换key
                        String key = CUSTOMID + "//" +UUID.randomUUID().toString();
                        ImageCacheManager.put(key,data.get(i).getId());
                        dto4.imgID = key;
                        dto4.thumbnail = data.get(i).getThumbnail();
                        dto4.type = data.get(i).getType();
                        imglist.add(dto4);
                    }
                    _3_com_zkty_jsi_media2_DTO dto1 = new _3_com_zkty_jsi_media2_DTO();
                    dto1.msg = "选择图片成功";
                    dto1.status = 0;
                    dto1.data = imglist;
                    handler.complete(dto1);
                }
            });
        });
    }

    @Override
    public void _uploadImage(_7_com_zkty_jsi_media2_DTO dto, CompletionHandler<_6_com_zkty_jsi_media2_DTO> handler) {
        //获取 缓存中的 本体图片路径
        List<String> images = new ArrayList<>();
        for (int i = 0; i < dto.ids.size(); i++) {
            String imgpath = dto.ids.get(i);
            if(imgpath.startsWith(CUSTOMID)){
                imgpath = ImageCacheManager.get(imgpath);
            }
            images.add(imgpath);
        }
        //上传图片
        final int[] index = {0};
        iMedia.upLoadImgList(dto.url, images, dto.header,new UpLoadImgCallback() {
            @Override
            public void onUpLoadSucces(int status, String id,String msg, String dataStr,boolean isCommplete) {
                try {
                    _6_com_zkty_jsi_media2_DTO dto1 = new _6_com_zkty_jsi_media2_DTO();
                    dto1.data = dataStr;
                    dto1.status = status;
                    dto1.imgID = dto.ids.get(index[0]);
                    dto1.msg = msg;
                    index[0]++;
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
