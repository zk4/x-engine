package com.zkty.engine.module.xxxx.network;

public interface Constants {

    public static final String CLIENT_ID = "app_b";
    public static final String CLIENT_SECRET = "times";
    public static final String SCOPE = "all";


    String BUILD_TYPE_DEBUG = "debug";          //debug环境
    String BUILD_TYPE_DEBUG_NAME = "DEV";          //debug
//    String ROOT_URL_DEBUG = "http://dev.linli590.cn:16666";
    String ROOT_URL_DEBUG = "https://m-center-uat-linli.timesgroup.cn";//暂用uat方便开发调试


    String BUILD_TYPE_UAT = "uat";            //uat环境
    String BUILD_TYPE_UAT_NAME = "UAT";            //uat环境
    String ROOT_URL_UAT = "https://m-center-uat-linli.timesgroup.cn";

    String BUILD_TYPE_SIT = "sit";            //sit环境
    String BUILD_TYPE_SIT_NAME = "SIT";            //sit环境
    String ROOT_URL_SIT = "http://sit.linli590.cn:7777";

    String BUILD_TYPE_RELEASE = "release";      //生产环境
    String BUILD_TYPE_RELEASE_NAME = "PROD";      //生产环境
    String ROOT_URL_RELEASE = "https://m-center-prod-linli.timesgroup.cn";


    /**
     * App根目录名称 "DS"
     */
    String APP_ROOT_PATH = "DS";
    /**
     * 记录错误日志到本地的全路径 "/rainbow/log/"
     */
    String APP_ERROR_LOG = "/" + APP_ROOT_PATH + "/log/";


}
