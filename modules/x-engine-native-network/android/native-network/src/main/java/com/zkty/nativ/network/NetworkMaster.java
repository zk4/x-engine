package com.zkty.nativ.network;

import android.content.Context;

import com.zkty.nativ.network.net.exception.ApiException;

import java.util.ArrayList;
import java.util.List;

import okhttp3.Interceptor;


public class NetworkMaster {
    private static NetworkMaster mInstance;
    private static Context mContext;
    //接口host地址
    private static String hostUrl;
    //环境名称
    private static String buildTypeName;
    //环境类型
    private static String mBuildType;
    //app版本号
    private static String appVerisonName;
    //网络监听
    private NetworkListener networkListener;

    private static List<Interceptor> interceptorList = new ArrayList<>();

    public static NetworkMaster getInstance() {
        if (mInstance == null) {
            throw new NullPointerException("请初始化 NetworkMaster");
        }
        return mInstance;
    }

    public NetworkMaster(Context mContext,  String hostUrl, String mBuildType, String buildTypeName, String appVerisonName, List<Interceptor> interceptorList) {
        NetworkMaster.mContext = mContext;
        NetworkMaster.mBuildType = mBuildType;
        NetworkMaster.hostUrl = hostUrl;
        NetworkMaster.buildTypeName = buildTypeName;
        NetworkMaster.appVerisonName = appVerisonName;
        NetworkMaster.interceptorList.clear();
        NetworkMaster.interceptorList.addAll(interceptorList);

    }

    public static Context getContext() {
        return mContext;
    }

    public void setNetworkLinstener(NetworkListener linstener) {
        this.networkListener = linstener;
    }

    public NetworkListener getNetworkListener() {
        return networkListener;
    }


    public String getHostUrl() {
        return hostUrl;
    }

    public static List<Interceptor> getInterceptorList() {
        return interceptorList;
    }

    public static void setInterceptorList(List<Interceptor> interceptorList) {
        NetworkMaster.interceptorList = interceptorList;
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
        private List<Interceptor> interceptorList = new ArrayList<>();

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
        public SingletonBuilder setInterceptor(Interceptor interceptor) {
            this.interceptorList.add(interceptor);
            return this;
        }

        public NetworkMaster build() {
            mInstance = new NetworkMaster(mContext,hostUrl,mBuildType,buildTypeName,appVerisonName,interceptorList);
            return mInstance;
        }

    }

}
