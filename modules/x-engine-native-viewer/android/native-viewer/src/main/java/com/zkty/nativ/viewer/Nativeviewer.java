package com.zkty.nativ.viewer;

import android.content.Intent;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.viewer.activity.PreViewActivity;
import com.zkty.nativ.viewer.bean.NativeViewerInfoBean;

import java.util.ArrayList;
import java.util.List;

public class Nativeviewer extends NativeModule implements Iviewer {

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public boolean isDefault() {
        return false;
    }

    @Override
    public String getModelPic() {
        return "pic";
    }

    @Override
    public String getModelName() {
        return "viewer";
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
    public void openFileReader(String filePath, CallBack callBack) {
        Intent intent = new Intent(XEngineApplication.getCurrentActivity(), PreViewActivity.class);
        intent.putExtra("filePath",filePath);
        XEngineApplication.getCurrentActivity().startActivity(intent);

    }

}
