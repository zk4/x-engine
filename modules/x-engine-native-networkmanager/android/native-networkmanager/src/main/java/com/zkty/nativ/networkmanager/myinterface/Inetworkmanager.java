package com.zkty.nativ.networkmanager.myinterface;

import com.zkty.nativ.networkmanager.callback.OnDownloadListener;
import com.zkty.nativ.networkmanager.callback.OnUploadListener;
import com.zkty.nativ.networkmanager.callback.ServiceCallback;

import java.util.HashMap;

public interface Inetworkmanager {

    /**
     * post 请求
     * @param requestType  请求类型
     * @param url //请求地址方法名
     * @param params
     * @param callback
     */
    void post(String requestType, String url, HashMap<String,Object> params, ServiceCallback callback);

    void post(String requestType, String url, HashMap<String,Object> params, HashMap<String,Object> heads, ServiceCallback callback);



    /**
     * get 请求
     * @param requestType  请求类型
     * @param url //请求地址方法名
     * @param callback
     */
    void get(String requestType, String url,  ServiceCallback callback);

    void get(String requestType, String url, HashMap<String,Object> params, ServiceCallback callback);

    void get(String requestType, String url, HashMap<String,Object> params, HashMap<String,Object> heads, ServiceCallback callback);


    /**
     * 下载文件
     * @param url
     * @param filePath
     * @param callback
     */
    void download(String url,String filePath, OnDownloadListener callback);

    /**
     * 上传文件
     * @param url
     * @param filePath
     * @param callback
     */
    void upload(String url,String filePath, OnUploadListener callback);


}
