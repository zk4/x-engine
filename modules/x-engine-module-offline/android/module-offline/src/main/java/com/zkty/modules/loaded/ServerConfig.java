package com.zkty.modules.loaded;

import java.io.Serializable;

public class ServerConfig implements Serializable {
    private String appId;
    private String appSecret;
    private String offlineServerUrl;


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
