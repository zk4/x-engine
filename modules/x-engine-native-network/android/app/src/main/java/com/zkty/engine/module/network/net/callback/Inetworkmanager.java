package com.zkty.engine.module.network.net.callback;


import java.util.HashMap;

public interface Inetworkmanager {

    /**
     * post 请求
     */
    void post();

    /**
     * get 请求
     */
    void get();


    /**
     * 下载文件
     */
    void download();

    /**
     * 上传文件
     */
    void upload();


}
