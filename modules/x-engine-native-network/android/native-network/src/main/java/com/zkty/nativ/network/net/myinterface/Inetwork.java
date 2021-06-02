package com.zkty.nativ.network.net.myinterface;


import java.util.HashMap;
import java.util.Map;

/**
 * @author : MaJi
 * @time : (6/1/21)
 * dexc : 网络模块接口
 */
public interface Inetwork {

    /**
     * post 请求
     * @param requestType  请求类型
     * @param url //请求地址方法名
     * @param params
     * @param callback
     */
    void post(String requestType, String baseUrl, String url, Map<String, Object> params, Map<String, String> heads, ServiceCallback callback);


    /**
     * get 请求
     * @param requestType  请求类型
     * @param url //请求地址方法名
     * @param callback
     */

    void get(String requestType, String baseUrl, String url, Map<String, Object> params, Map<String, String> heads, ServiceCallback callback);


    /**
     * 下载文件
     * @param url
     * @param filePath
     * @param callback
     */
    void download(String url, String filePath, OnDownloadListener callback);

    /**
     * 上传文件
     * @param url
     * @param filePath
     * @param callback
     */
    void upload(String url, String filePath, OnUploadListener callback);
}
