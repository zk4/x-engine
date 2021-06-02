package com.zkty.engine.module.network;

public class IMTokenInfoBean {

    private String appId;
    private long imUserId;
    private String imToken;
    private long tokenExpires;

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public long getImUserId() {
        return imUserId;
    }

    public void setImUserId(long imUserId) {
        this.imUserId = imUserId;
    }

    public String getImToken() {
        return imToken;
    }

    public void setImToken(String imToken) {
        this.imToken = imToken;
    }

    public long getTokenExpires() {
        return tokenExpires;
    }

    public void setTokenExpires(long tokenExpires) {
        this.tokenExpires = tokenExpires;
    }
}
