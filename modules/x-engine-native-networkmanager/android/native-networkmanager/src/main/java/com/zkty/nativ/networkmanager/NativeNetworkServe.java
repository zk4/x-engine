package com.zkty.nativ.networkmanager;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.networkmanager.callback.OnDownloadListener;
import com.zkty.nativ.networkmanager.callback.OnUploadListener;
import com.zkty.nativ.networkmanager.callback.ServiceCallback;
import com.zkty.nativ.networkmanager.myinterface.Inetworkmanager;

import java.util.HashMap;

public class NativeNetworkServe extends NativeModule implements Inetworkmanager {


    @Override
    public String moduleId() {
        return "com.zkty.native.networkmanager";
    }
    private static NativeNetworkServe nativeNetworkManager;

    /**
     * 获取单例
     * @return
     */
    public static NativeNetworkServe getInstance() {
        if(nativeNetworkManager == null){
            synchronized (NativeNetworkServe.class){
                if(nativeNetworkManager == null){
                    nativeNetworkManager = new NativeNetworkServe();
                }
            }
        }
        return nativeNetworkManager;
    }

    @Override
    public void post(String requestType, String url, HashMap<String, Object> params, ServiceCallback callback) {
        post(requestType,url,params,new HashMap<>(),callback);
    }

    @Override
    public void post(String requestType, String url, HashMap<String, Object> params, HashMap<String, Object> heads, ServiceCallback callback) {
        NetworkManager.getiNetwork().post(requestType,url,params,heads,callback);
    }

    @Override
    public void get(String requestType, String url, ServiceCallback callback) {
        get(requestType,url,new HashMap<>(),callback);
    }

    @Override
    public void get(String requestType, String url, HashMap<String, Object> params, ServiceCallback callback) {
        get(requestType,url,new HashMap<>(),new HashMap<>(),callback);
    }

    @Override
    public void get(String requestType, String url, HashMap<String, Object> params, HashMap<String, Object> heads, ServiceCallback callback) {
        NetworkManager.getiNetwork().get(requestType,url,params,heads,callback);
    }

    @Override
    public void download(String url, String filePath, OnDownloadListener callback) {
        NetworkManager.getiNetwork().download(url,filePath,callback);
    }

    @Override
    public void upload(String url, String filePath, OnUploadListener callback) {
        NetworkManager.getiNetwork().upload(url,filePath,callback);
    }

}
