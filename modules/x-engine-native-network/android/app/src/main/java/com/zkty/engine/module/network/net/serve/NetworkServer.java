package com.zkty.engine.module.network.net.serve;

import com.zkty.engine.module.network.BuildConfig;
import com.zkty.engine.module.network.net.callback.Inetworkmanager;
import com.zkty.engine.module.network.net.utils.NetworkCommonUtils;
import com.zkty.nativ.network.NetworkConfig;
import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.net.exception.ApiException;
import com.zkty.nativ.network.net.myinterface.OnDownloadListener;
import com.zkty.nativ.network.net.myinterface.OnUploadListener;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;

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
     * header 参数
     */
    private Map<String, String> heads;

    /**
     * 是否拦截token
     */
    private boolean isIntercepToken;


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
        //设置默认
        networkServer.setDefault();
        return networkServer;
    }

    /**
     * 设置默认 配置
     */
    public void setDefault(){
        //默认的请求 host
        setBaseurl(NetworkCommonUtils.getHost(BuildConfig.BUILD_TYPE));
        //默认的请求传惨方式
        setRequestType(NetworkConfig.REQUEST_TYPE_BODY);
        //默认请求头
        setHeads(new HashMap<>());
        //默认拦截token
        setIntercepToken(true);
    }

    /**
     * 设置传惨类型
     * @param requestType
     * @return
     */
    public NetworkServer setRequestType(String requestType) {
        this.requestType = requestType;
        return this;
    }

    /**
     * 设置 baseurl
     * @param baseurl
     * @return
     */
    public NetworkServer setBaseurl(String baseurl) {
        this.baseurl = baseurl;
        return this;
    }

    /**
     * 设置header参数
     * @param heads
     * @return
     */
    public NetworkServer setHeads(Map<String, String> heads) {
        this.heads =  heads;
        return this;
    }


    public NetworkServer setIntercepToken(boolean intercepToken) {
        isIntercepToken = intercepToken;
        return this;
    }

    /**
     * post请求
     * @param interfaceName
     * @param params
     * @param callback
     */
    @Override
    public void sendPost(String interfaceName, Map<String, Object> params,ServiceCallback callback){
        NetworkMaster.getInstance().post(requestType, baseurl, interfaceName, params, heads, isIntercepToken, callback);
    }


    /**
     * post请求
     * @param interfaceName
     * @param params
     * @param callback
     */
    @Override
    public void sendGet(String interfaceName, Map<String, Object> params,ServiceCallback callback){
        NetworkMaster.getInstance().get(requestType, baseurl, interfaceName, params, heads, isIntercepToken, new ServiceCallback() {
            @Override
            public void onSuccess(Object jsonObg) {

            }

            @Override
            public void onError(ApiException apiException) {

            }

            @Override
            public void onInvalid() {

            }
        });
    }


    /**
     * 下载文件
     * @param downloadUrl
     * @param filePath
     * @param onDownloadListener
     */
    @Override
    public void sendDownload(String downloadUrl, String filePath,OnDownloadListener onDownloadListener) {
        NetworkMaster.getInstance().download(downloadUrl,filePath,onDownloadListener);
    }

    /**
     * 上传文件
     * @param uploadUrl
     * @param filePath
     * @param onUploadListener
     */
    @Override
    public void sendUpload(String uploadUrl, String filePath,OnUploadListener onUploadListener) {
        NetworkMaster.getInstance().upload(uploadUrl,filePath,onUploadListener);
    }
}
