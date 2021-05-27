package com.zkty.nativ.viewer_original;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.store.StoreUtils;
import com.zkty.nativ.viewer.IviewerStatus;
import com.zkty.nativ.viewer_original.activity.PreViewActivity;

import java.util.ArrayList;
import java.util.List;

import module.viewer_original.R;

public class Nativeviewer_original extends NativeModule implements IviewerStatus {

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer_original";
    }


    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public boolean isDefault() {
        return (boolean) StoreUtils.get(moduleId(),false);
    }

    @Override
    public boolean isOnlineOpen() {
        return false;
    }

    @Override
    public void setDefault(Boolean isDefault) {
        StoreUtils.put(moduleId(),isDefault);
    }

    @Override
    public String getModelPicUrl() {
        return "null";
    }

    @Override
    public int getModelPicRes() {
        return R.mipmap.ic_launcher;
    }

    @Override
    public String getModelName() {
        return "viewer_original";
    }

    @Override
    public List<String> typeList() {
        List<String> typeList = new ArrayList<>();
        typeList.add("pdf");
        typeList.add("ppt");
        typeList.add("pptx");
        typeList.add("doc");
        typeList.add("docx");
        typeList.add("xls");
        typeList.add("xlsx");
        typeList.add("txt");
        typeList.add("epub");
        return typeList;
    }

    @Override
    public void openFileReader(String filePath, String title, String fileType) {
        PreViewActivity.startAty(filePath,title,fileType);
    }

}
