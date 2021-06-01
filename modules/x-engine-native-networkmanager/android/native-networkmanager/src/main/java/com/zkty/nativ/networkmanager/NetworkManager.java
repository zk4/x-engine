package com.zkty.nativ.networkmanager;

import android.content.Context;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.networkmanager.myinterface.Inetwork;

import java.util.HashMap;

/**
 * @author : MaJi
 * @time : (6/1/21)
 * dexc : 网络配置
 */
public class NetworkManager {
    /**
     * 传参数类型
     */
    private static final String REQUEST_TYPE_BODY = "body";
    private static final String REQUEST_TYPE_QUERT = "query";
    private static final String REQUEST_TYPE_PATH = "path";

    //NetworkManager 实例
    private static NetworkManager mInstance;

    //实例
    private static Context mContext;
    //接口host地址
    private static String baseUrl;

    //通用参数
    private static HashMap<String,Object> params;

    //通用Handelr
    private static HashMap<String,Object> headers;


    /**
     * 获取网络的实例
     * @return
     */
    public static NetworkManager getInstance() {
        if (mInstance == null) {
            throw new NullPointerException("请初始化 NetworkManager");
        }
        return mInstance;
    }

    public NetworkManager(Context mContext, String baseUrl, HashMap<String, Object> params, HashMap<String, Object> headers) {
        this.mContext = mContext;
        this.baseUrl = baseUrl;
        this.params = params;
        this.headers = headers;


    }


    /**
     * 网络请求模块
     * @return
     */
    private static Inetwork iNetwork = null;
    public static Inetwork getiNetwork() {
        if(iNetwork == null){
            synchronized (Inetwork.class){
                if(iNetwork == null){
                    NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Inetwork.class);
                    if (module instanceof Inetwork)
                        iNetwork = (Inetwork) module;
                }
            }
        }
        return iNetwork;
    }



    public static NetworkManager getmInstance() {
        return mInstance;
    }

    public static void setmInstance(NetworkManager mInstance) {
        NetworkManager.mInstance = mInstance;
    }

    public static Context getmContext() {
        return mContext;
    }

    public static void setmContext(Context mContext) {
        NetworkManager.mContext = mContext;
    }

    public static String getBaseUrl() {
        return baseUrl;
    }

    public static void setBaseUrl(String baseUrl) {
        NetworkManager.baseUrl = baseUrl;
    }

    public static HashMap<String, Object> getParams() {
        return params;
    }

    public static void setParams(HashMap<String, Object> params) {
        NetworkManager.params = params;
    }

    public static HashMap<String, Object> getHeaders() {
        return headers;
    }

    public static void setHeaders(HashMap<String, Object> headers) {
        NetworkManager.headers = headers;
    }

    public static class Builder {
        private Context mContext;
        private String baseUrl;
        private HashMap<String,Object> params;
        private HashMap<String,Object> headers;

        public Builder setmContext(Context mContext) {
            this.mContext = mContext;
            return this;
        }

        public Builder setBaseUrl(String baseUrl) {
            this.baseUrl = baseUrl;
            return this;
        }

        public Builder setParams(HashMap<String, Object> params) {
            this.params = params;
            return this;
        }

        public Builder setHeaders(HashMap<String, Object> headers) {
            this.headers = headers;
            return this;
        }

        public NetworkManager build() {
            mInstance = new NetworkManager(mContext,baseUrl,params,headers);
            return mInstance;
        }

    }


}
