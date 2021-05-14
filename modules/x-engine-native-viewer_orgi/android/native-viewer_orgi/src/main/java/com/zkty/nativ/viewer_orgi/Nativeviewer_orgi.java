package com.zkty.nativ.viewer_orgi;

import android.content.Intent;
import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.store.StoreUtils;
import com.zkty.nativ.viewer.IviewerStatus;
import com.zkty.nativ.viewer_orgi.activity.PreViewActivity;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class Nativeviewer_orgi extends NativeModule implements IviewerStatus {

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer_orgi";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public boolean isDefault() {
        return (boolean) StoreUtils.get(moduleId(),false);
    }

    @Override
    public void setDefault(Boolean isDefault) {
        StoreUtils.put(moduleId(),isDefault);
    }

    @Override
    public String getModelPic() {
        return "null";
    }

    @Override
    public String getModelName() {
        return "viewer_orgi";
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
    public void openFileReader(String filePath, String fileName, String fileType) {
        PreViewActivity.startAty(filePath,fileName,fileType);
    }

}
