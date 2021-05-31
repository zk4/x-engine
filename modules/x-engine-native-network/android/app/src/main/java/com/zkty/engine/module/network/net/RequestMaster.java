package com.zkty.engine.module.network.net;

import android.annotation.SuppressLint;

import com.zkty.engine.module.network.net.callback.ServiceCallback;
import com.zkty.nativ.network.api.RetrofitHttpService;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.rx.RxUtil;
import com.zkty.nativ.network.utils.GsonUtil;
import com.zkty.nativ.network.utils.LogUtils;

import java.util.HashMap;
import java.util.Map;

import rx.Observable;
import rx.Observer;

/**
 * @author : MaJi
 * @time : (5/26/21)
 * dexc :
 */
public class RequestMaster {




    @SuppressLint("CheckResult")
    public static void postBody(String url, Map<String,Object> parmas,  final ServiceCallback callback) {
        Observable<String> observable = RxServiceManager.RetrofitServeApiFor()
                .ObpostBody(url, parmas, new HashMap<>());
        request(observable,callback);
    }
    @SuppressLint("CheckResult")
    public static void postQuery(String url, Map<String,String> parmas, Map<String,String> heads, final ServiceCallback callback) {
        Observable<String> observable = RxServiceManager.RetrofitServeApiFor()
                .ObpostQuery(url, parmas, heads);
        request(observable, callback);
    }

    public static void request(Observable<String> observable, ServiceCallback callback){
        observable.compose(RxUtil.<String>handleRestfullResult())
                .subscribe(new Observer<String>() {
                    @Override
                    public void onCompleted() {
                    }

                    @Override
                    public void onError(Throwable e) {

                    }

                    @Override
                    public void onNext(String s) {
                        BaseResp baseResp = GsonUtil.fromJson(s,BaseResp.class);

                        if(null == callback) return;
                        callback.onSuccess(baseResp);
                    }
                });
    }

}
