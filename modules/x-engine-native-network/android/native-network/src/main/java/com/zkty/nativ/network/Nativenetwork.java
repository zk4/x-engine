package com.zkty.nativ.network;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.networkmanager.callback.OnDownloadListener;
import com.zkty.nativ.networkmanager.callback.OnUploadListener;
import com.zkty.nativ.networkmanager.callback.ServiceCallback;
import com.zkty.nativ.networkmanager.myinterface.Inetwork;

import java.util.HashMap;

public class Nativenetwork extends NativeModule implements Inetwork {

    @Override
    public String moduleId() {
        return "com.zkty.native.network";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public void post(String requestType, String url, HashMap<String, Object> params, HashMap<String, Object> heads, ServiceCallback callback) {

    }

    @Override
    public void get(String requestType, String url, HashMap<String, Object> params, HashMap<String, Object> heads, ServiceCallback callback) {

    }

    @Override
    public void download(String url, String filePath, OnDownloadListener callback) {

    }

    @Override
    public void upload(String url, String filePath, OnUploadListener callback) {

    }
}
