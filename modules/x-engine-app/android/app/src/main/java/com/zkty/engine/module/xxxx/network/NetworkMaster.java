package com.zkty.engine.module.xxxx.network;

import android.content.Context;

import com.zkty.engine.module.xxxx.network.networkframe.net.exception.ApiException;
import com.zkty.engine.module.xxxx.network.service.CommonService;
import com.zkty.engine.module.xxxx.network.utils.NetworkCommonUtils;


public class NetworkMaster {
    private static String hostUrl;
    private static String buildTypeName;
    private static String appVerisonName;
    private static Context mContext;
    private static NetworkMaster mInstance;
    private static String mBuildType;


    private static NetworkListener networkListener;

    public static void init(Context context, String buildType) {
        mContext = context;
        mBuildType = buildType;
        hostUrl = NetworkCommonUtils.getHost(mBuildType);
        buildTypeName = NetworkCommonUtils.getBuildTypeName(mBuildType);


    }



    public void setNetworkLinstener(NetworkListener linstener) {
        this.networkListener = linstener;
    }

    public NetworkListener getNetworkListener() {
        return networkListener;
    }

    public static Context getContext() {
        return mContext;
    }

    public static NetworkMaster getInstance() {
        if (mInstance == null) {
            mInstance = new NetworkMaster();
        }
        return mInstance;
    }

    public String getHostUrl() {
        return hostUrl;
    }


    public CommonService getCommonService() {
        return CommonService.getInstance();
    }

    public interface NetworkListener {
        void onInvalid(ApiException apiException);

        void onError();
    }
}
