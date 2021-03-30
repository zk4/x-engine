package com.zkty.modules.engine.manager;

/**
 * 微应用信息
 */
public class MicroAppVersionBean {
    private boolean forceUpdate;    // 是否强制更新
    private String microAppName;
    private String microAppId;
    private String microAppVersion;

    public MicroAppVersionBean() {

    }

    public MicroAppVersionBean(boolean forceUpdate, String microAppName, String microAppId, String microAppVersion) {
        this.forceUpdate = forceUpdate;
        this.microAppName = microAppName;
        this.microAppId = microAppId;
        this.microAppVersion = microAppVersion;
    }



    public boolean isForceUpdate() {
        return forceUpdate;
    }

    public void setForceUpdate(boolean forceUpdate) {
        this.forceUpdate = forceUpdate;
    }

    public String getMicroAppName() {
        return microAppName;
    }

    public void setMicroAppName(String microAppName) {
        this.microAppName = microAppName;
    }

    public String getMicroAppId() {
        return microAppId;
    }

    public void setMicroAppId(String microAppId) {
        this.microAppId = microAppId;
    }

    public String getMicroAppVersion() {
        return microAppVersion;
    }

    public void setMicroAppVersion(String microAppVersion) {
        this.microAppVersion = microAppVersion;
    }
}
