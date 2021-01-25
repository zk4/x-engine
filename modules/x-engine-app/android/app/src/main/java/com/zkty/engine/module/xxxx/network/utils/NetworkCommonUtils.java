package com.zkty.engine.module.xxxx.network.utils;


import com.zkty.engine.module.xxxx.network.Constants;

public class NetworkCommonUtils {

    public static String getHost(String buildType) {
        switch (buildType) {
            case Constants.BUILD_TYPE_DEBUG:
                return Constants.ROOT_URL_DEBUG;
            case Constants.BUILD_TYPE_SIT:
                return Constants.ROOT_URL_SIT;
            case Constants.BUILD_TYPE_UAT:
                return Constants.ROOT_URL_UAT;
            case Constants.BUILD_TYPE_RELEASE:
                return Constants.ROOT_URL_RELEASE;
            default:
                return Constants.ROOT_URL_RELEASE;
        }
    }

    public static String getBuildTypeName(String buildType) {
        switch (buildType) {
            case Constants.BUILD_TYPE_DEBUG:
                return Constants.BUILD_TYPE_DEBUG_NAME;
            case Constants.BUILD_TYPE_SIT:
                return Constants.BUILD_TYPE_SIT_NAME;
            case Constants.BUILD_TYPE_UAT:
                return Constants.BUILD_TYPE_UAT_NAME;
            case Constants.BUILD_TYPE_RELEASE:
                return Constants.BUILD_TYPE_RELEASE_NAME;
            default:
                return Constants.BUILD_TYPE_RELEASE_NAME;
        }
    }


}
