package com.zkty.engine.module.network.net.callback;


import com.zkty.nativ.network.net.myinterface.OnDownloadListener;
import com.zkty.nativ.network.net.myinterface.OnUploadListener;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;

import java.util.Map;

public interface Inetworkmanager {

    /**
     * post 请求
     */
    void sendPost(String interfaceName, Map<String, Object> params, ServiceCallback callback);

    /**
     * get 请求
     */
    void sendGet(String interfaceName, Map<String, Object> params,ServiceCallback callback);


    /**
     * 下载文件
     */
    void sendDownload(String downloadUrl, String filePath, OnDownloadListener onDownloadListener);

    /**
     * 上传文件
     */
    void sendUpload(String uploadUrl, String filePath, OnUploadListener onUploadListener);


}
