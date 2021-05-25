package com.zkty.nativ.network;

import android.content.Context;

import com.zkty.nativ.network.net.exception.ApiException;

import java.util.List;

import okhttp3.Interceptor;


public class NetworkMaster {
    private static String hostUrl;
    private static String buildTypeName;
    private static String appVerisonName;
    private static Context mContext;
    private static NetworkMaster mInstance;
    private static String mBuildType;
    private static String sessionToken;
    //token拦截
    private static Interceptor tokenInterceptor;


    private NetworkListener networkListener;

    public NetworkMaster(Context mContext,  String hostUrl, String mBuildType, String buildTypeName, String appVerisonName,String sessionToken, Interceptor interceptor) {
        NetworkMaster.mContext = mContext;
        NetworkMaster.mBuildType = mBuildType;
        NetworkMaster.hostUrl = hostUrl;
        NetworkMaster.buildTypeName = buildTypeName;
        NetworkMaster.appVerisonName = appVerisonName;
        NetworkMaster.tokenInterceptor = interceptor;
        NetworkMaster.sessionToken = sessionToken;
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
            throw new NullPointerException("请初始化 NetworkMaster");
        }
        return mInstance;
    }

    public String getHostUrl() {
        return hostUrl;
    }

    public String getSessionToken() {
        return sessionToken;
    }

    public Interceptor getTokenInterceptor() {
        return tokenInterceptor;
    }

    public interface NetworkListener {
        void onInvalid(ApiException apiException);

        void onError();
    }


    public static class SingletonBuilder {
        private Context mContext;
        private String mBuildType;
        private String hostUrl;
        private String buildTypeName;
        private String appVerisonName;
        private String sessionToken;
        private Interceptor interceptor;

        public SingletonBuilder(Context context) {
            mContext = context.getApplicationContext();
        }

        public SingletonBuilder setHostUrl(String hostUrl) {
            this.hostUrl = hostUrl;
            return this;
        }
        public SingletonBuilder setBuildType(String mBuildType) {
            this.mBuildType = mBuildType;
            return this;
        }
        public SingletonBuilder setBuildName(String buildTypeName) {
            this.buildTypeName = buildTypeName;
            return this;
        }

        public SingletonBuilder setAppVersionName(String appVerisonName) {
            this.appVerisonName = appVerisonName;
            return this;
        }
        public SingletonBuilder setTokenInterceptor(Interceptor interceptor) {
            this.interceptor = interceptor;
            return this;
        }
        public SingletonBuilder setSessionToken(String sessionToken) {
            this.sessionToken = sessionToken;
            return this;
        }

        public NetworkMaster build() {
            mInstance = new NetworkMaster(mContext,hostUrl,mBuildType,buildTypeName,appVerisonName,sessionToken,interceptor);
            return mInstance;
        }

    }

}
