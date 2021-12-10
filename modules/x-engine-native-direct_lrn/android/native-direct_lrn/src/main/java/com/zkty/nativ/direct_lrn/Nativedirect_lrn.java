package com.zkty.nativ.direct_lrn;

import android.app.Activity;
import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.direct.IDirect;
import com.zkty.nativ.react_native.XEngineReactNativeActivity;

import java.io.File;
import java.util.Map;

public class Nativedirect_lrn extends NativeModule implements IDirect {

    @Override
    public String moduleId() {
        return  "com.zkty.native.direct_lrn";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public String scheme() {
        return "lrn";
    }

    @Override
    public String protocol() {
        return "file://";
    }

    @Override
    public void push(String protocol, String host, String pathname, String fragment, Map<String, String> query, Map<String, String> params) {
        Activity mActivity = XEngineApplication.getCurrentActivity();
        if(mActivity == null){
            return;
        }
        //应用名称
        String moduleName = params.get("moduleName");
        //本地 jsBundle 名称
        String bundleAssetName = params.get("bundleAssetName");
        //debug 本地 jsBundle Serve  jsMainModulePath 设置
        String jsMainModulePath = params.get("jsMainModulePath");

        XEngineReactNativeActivity.start(mActivity,moduleName,bundleAssetName,jsMainModulePath,query);
    }

    @Override
    public void back(String host, String fragment) {

    }
}
