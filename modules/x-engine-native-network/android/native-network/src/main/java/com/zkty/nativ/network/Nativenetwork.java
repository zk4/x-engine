package com.zkty.nativ.network;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.network.api.RetrofitHttpService;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.exception.ApiException;
import com.zkty.nativ.network.net.myinterface.Inetwork;
import com.zkty.nativ.network.net.myinterface.OnDownloadListener;
import com.zkty.nativ.network.net.myinterface.OnUploadListener;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;
import com.zkty.nativ.network.net.rx.RxService;
import com.zkty.nativ.network.net.rx.RxUtil;
import com.zkty.nativ.network.utils.GsonUtil;
import com.zkty.nativ.network.utils.LogUtils;

import java.util.HashMap;
import java.util.Map;

import rx.Observable;
import rx.Observer;

public class Nativenetwork extends NativeModule implements Inetwork {

    @Override
    public String moduleId() {
        return "com.zkty.native.network";
    }

    public void handlerThrowable(Throwable throwable, ServiceCallback callback) {
        if (throwable instanceof ApiException) {
            callback.onError((ApiException) throwable);
        } else {
            LogUtils.e(throwable.getMessage(), throwable);
        }
    }


    @Override
    public void post(String requestType, String baseUrl, String url, Map<String, Object> params, Map<String, String> heads, ServiceCallback callback) {
        params = params == null ? new HashMap<>() : params;
        heads = heads == null ? new HashMap<>() : heads;

        RetrofitHttpService retrofitHttpService = RxService.createBasicApi(RetrofitHttpService.class, baseUrl, true);
        //默认body请求
        Observable<String> observable = retrofitHttpService.ObpostBody(url, params, heads);
        if(requestType.equals(NetworkConfig.REQUEST_TYPE_BODY)){
            observable = retrofitHttpService.ObpostBody(url, params, heads);
        }else if(requestType.equals(NetworkConfig.REQUEST_TYPE_QUERY_MAP)){
            observable = retrofitHttpService.ObpostQueryMap(url, params, heads);
        }else if(requestType.equals(NetworkConfig.REQUEST_TYPE_FILE_MAP)){
            observable = retrofitHttpService.ObpostFileMap(url, params, heads);
        }
        observable.compose(RxUtil.<String>handleRestfullResult())
                .subscribe(new Observer<String>() {
                    @Override
                    public void onCompleted() {
                    }

                    @Override
                    public void onError(Throwable e) {
                        handlerThrowable(e,callback);
                    }

                    @Override
                    public void onNext(String s) {
                        BaseResp baseResp = GsonUtil.fromJson(s,BaseResp.class);

                        if(null == callback) return;
                        callback.onSuccess(baseResp);
                    }
                });
    }

    @Override
    public void get(String requestType, String baseUrl, String url, Map<String, Object> params, Map<String, String> heads, ServiceCallback callback) {
        params = params == null ? new HashMap<>() : params;
        heads = heads == null ? new HashMap<>() : heads;
        RetrofitHttpService retrofitHttpService = RxService.createBasicApi(RetrofitHttpService.class, baseUrl, false);
        //默认body请求
        retrofitHttpService.Obget(url, params, heads).compose(RxUtil.<String>handleRestfullResult())
                .subscribe(new Observer<String>() {
                    @Override
                    public void onCompleted() {
                    }

                    @Override
                    public void onError(Throwable e) {
                        handlerThrowable(e,callback);
                    }

                    @Override
                    public void onNext(String s) {
                        BaseResp baseResp = GsonUtil.fromJson(s,BaseResp.class);

                        if(null == callback) return;
                        callback.onSuccess(baseResp);
                    }
                });
    }

    @Override
    public void download(String url, String filePath, OnDownloadListener callback) {

    }

    @Override
    public void upload(String url, String filePath, OnUploadListener callback) {

    }
}
