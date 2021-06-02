package com.zkty.engine.module.network.net.serve;

import android.text.TextUtils;

import com.zkty.engine.module.network.net.NetWorkManager;
import com.zkty.engine.module.network.net.callback.Inetworkmanager;
import com.zkty.nativ.network.net.myinterface.OnDownloadListener;
import com.zkty.nativ.network.net.myinterface.OnUploadListener;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;
import com.zkty.nativ.network.utils.LogUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * @author : MaJi
 * @time : (6/2/21)
 * dexc :
 */
public class NetworkServer implements Inetworkmanager {

    /**
     * 请求参数类型
     */
    private String requestType;
    /**
     * 请求url
     */
    private String baseurl;
    /**
     * 请求方法名
     */
    private String url;

    /**
     *  文件路径
     */
    private String filePath;
    /**
     * 请求参数
     */
    private HashMap<String, Object> params;

    /**
     * header 参数
     */
    private Map<String, String> heads;

    /**
     * 请求回调
     */
    private ServiceCallback callback;

    /**
     * 下载回调
     */
    private OnDownloadListener onDownloadListener;

    /**
     * 上传回调
     */
    private OnUploadListener onUploadListener;

    private static NetworkServer networkServer;
    /**
     * 获取单例
     * @return
     */
    public static NetworkServer getInstance() {
        if(networkServer == null){
            synchronized (NetworkServer.class){
                if(networkServer == null){
                    networkServer = new NetworkServer();
                }
            }
        }
        return networkServer;
    }


    public NetworkServer setRequestType(String requestType) {
        this.requestType = requestType;
        return this;
    }

    public NetworkServer setBaseurl(String baseurl) {
        this.baseurl = baseurl;
        return this;
    }

    public NetworkServer setUrl(String url) {
        this.url = url;
        return this;
    }

    public NetworkServer setParams(Map<String, Object> params) {
        this.params = (HashMap<String, Object>) params;
        return this;
    }

    public NetworkServer setHeads(Map<String, String> heads) {
        this.heads =  heads;
        return this;
    }

    public NetworkServer setCallback(ServiceCallback callback) {
        this.callback = callback;
        return this;
    }

    public static void setNetworkServer(NetworkServer networkServer) {
        NetworkServer.networkServer = networkServer;
    }

    public NetworkServer setFilePath(String filePath) {
        this.filePath = filePath;
        return this;
    }

    public NetworkServer setOnDownloadListener(OnDownloadListener onDownloadListener) {
        this.onDownloadListener = onDownloadListener;
        return this;
    }

    public NetworkServer setOnUploadListener(OnUploadListener onUploadListener) {
        this.onUploadListener = onUploadListener;
        return this;
    }

    @Override
    public void post() {
        if(TextUtils.isEmpty(requestType)){
            LogUtils.d("请求类型为空");
            return;
        }
        if(TextUtils.isEmpty(url)){
            LogUtils.d("请求地址为空");
            return;
        }


        NetWorkManager.getiNetwork().post(requestType,baseurl,url,params,heads,callback);
    }

    @Override
    public void get() {
        if(TextUtils.isEmpty(requestType)){
            LogUtils.d("请求类型为空");
            return;
        }
        if(TextUtils.isEmpty(url)){
            LogUtils.d("请求地址为空");
            return;
        }
        NetWorkManager.getiNetwork().get(requestType,baseurl,url,params,heads,callback);
    }

    @Override
    public void download() {
        if(TextUtils.isEmpty(filePath)){
            LogUtils.d("文件路晋为空");
            return;
        }
        if(TextUtils.isEmpty(url)){
            LogUtils.d("请求地址为空");
            return;
        }
        NetWorkManager.getiNetwork().download(url,filePath,onDownloadListener);
    }

    @Override
    public void upload() {
        if(TextUtils.isEmpty(filePath)){
            LogUtils.d("文件路晋为空");
            return;
        }
        if(TextUtils.isEmpty(url)){
            LogUtils.d("请求地址为空");
            return;
        }
        NetWorkManager.getiNetwork().upload(url,filePath,onUploadListener);
    }
}
