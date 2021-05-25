package com.zkty.engine.module.network;


import com.zkty.engine.module.network.net.utils.NetworkCommonUtils;
import com.zkty.engine.module.network.net.interceptor.TokenInterceptor;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.network.NetworkMaster;

public class networkApplication extends XEngineApplication {
    @Override
    public void onCreate() {
        super.onCreate();
//        NetworkMaster.init(this,BuildConfig.BUILD_TYPE, NetworkCommonUtils.getHost(BuildConfig.BUILD_TYPE),NetworkCommonUtils.getBuildTypeName(BuildConfig.BUILD_TYPE));
        new NetworkMaster.SingletonBuilder(this)
                .setBuildType(BuildConfig.BUILD_TYPE)
                .setHostUrl( NetworkCommonUtils.getHost(BuildConfig.BUILD_TYPE))
                .setBuildName(NetworkCommonUtils.getBuildTypeName(BuildConfig.BUILD_TYPE))
                .setTokenInterceptor(new TokenInterceptor())
                .setSessionToken("13242342423424")
                .build();
    }
}
