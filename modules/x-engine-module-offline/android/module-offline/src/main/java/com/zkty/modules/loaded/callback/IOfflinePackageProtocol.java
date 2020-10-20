package com.zkty.modules.loaded.callback;

public interface IOfflinePackageProtocol {
    /**
     * @param baseUrl
     * @param appId
     * @param appSecret
     * @param microAppId
     * @param version
     * @param engineVersion
     */
    public void downLoadApp(String baseUrl, final String appId, String appSecret, final String microAppId, final int version, int engineVersion, final IXEngineNetProtocolCallback callback);


    /**
     * @param baseUrl
     * @param appId
     * @param appSecret
     * @param engineVersion
     */
    public void checkMicroAppsUpdate(String baseUrl, final String appId, final String appSecret, final int engineVersion, final IXEngineNetProtocolCallback callback);
}
