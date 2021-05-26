package com.zkty.engine.module.network.net;

public interface Constants {


    //微信appid
    public static final String WX_APP_ID = "wxa11a02e98f71d356";

    public static final String AUTHORITY = "com.lohashow.app.c";

    //IM相关


    String BUILD_TYPE_DEBUG = "debug";          //debug环境
    String BUILD_TYPE_DEBUG_NAME = "DEV";          //debug
    //    String ROOT_URL_DEBUG = "http://dev.linli590.cn:16666";
    String ROOT_URL_DEBUG = "http://10.115.91.40:30873";//暂用uat方便开发调试


    String BUILD_TYPE_UAT = "uat";            //uat环境
    String BUILD_TYPE_UAT_NAME = "UAT";            //uat环境
    String ROOT_URL_UAT = "http://10.115.91.76:9522";

    String BUILD_TYPE_SIT = "sit";            //sit环境
    String BUILD_TYPE_SIT_NAME = "SIT";            //sit环境
    String ROOT_URL_SIT = "http://10.115.91.71:32383";

    String BUILD_TYPE_RELEASE = "release";      //生产环境
    String BUILD_TYPE_RELEASE_NAME = "PROD";      //生产环境
    String ROOT_URL_RELEASE = "http://10.115.81.70:9000";

    /**
     * 首页弹窗广告
     */
    public static final String HOME_AD = "1";
    /**
     * 启动页广告
     **/
    public static final String OPEN_SCREEN_AD = "2";
    /**
     * 日程广告
     **/
    public static final String OPEN_SCHEDLUE_AD = "3";

    /**
     * 店铺ID
     */
    public static final String MALL_ID = "1";


    /**
     * App根目录名称 "DS"
     */
    String APP_ROOT_PATH = "DS";
    /**
     * 记录错误日志到本地的全路径 "/rainbow/log/"
     */
    String APP_ERROR_LOG = "/" + APP_ROOT_PATH + "/log/";


}
