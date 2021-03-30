package com.zkty.modules.engine.manager;

public class MicroAppsServerUrlConfig {
    private String appId;                   //微应用包名
    private String appSecret;               //app微应用请求数据用
    private String offlineServerUrl;        //服务器下载地址

    public MicroAppsServerUrlConfig(){

    }

    public MicroAppsServerUrlConfig(String appId, String appSecret, String offlineServerUrl) {
        this.appId = appId;
        this.appSecret = appSecret;
        this.offlineServerUrl = offlineServerUrl;
    }


    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getAppSecret() {
        return appSecret;
    }

    public void setAppSecret(String appSecret) {
        this.appSecret = appSecret;
    }

    public String getOfflineServerUrl() {
        return offlineServerUrl;
    }

    public void setOfflineServerUrl(String offlineServerUrl) {
        this.offlineServerUrl = offlineServerUrl;
    }
}
