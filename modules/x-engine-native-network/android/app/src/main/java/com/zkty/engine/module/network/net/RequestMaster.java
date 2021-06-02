package com.zkty.engine.module.network.net;

import android.annotation.SuppressLint;

import com.zkty.nativ.network.api.RetrofitHttpService;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;
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






    public static void post_Body(String url, Map<String,Object> parmas,  final ServiceCallback callback) {
        Observable<String> observable = RxServiceManager.RetrofitServeApiFor()
                .ObpostBody(url, parmas, new HashMap<>());
        request(observable,callback);
    }


    public static void post_Query(String url, Map<String,Object> parmas,  final ServiceCallback callback) {
        Observable<String> observable = RxServiceManager.RetrofitServeApiFor()
                .ObpostQueryMap(url, parmas, new HashMap<>());
        request(observable, callback);
    }


    public static void get_Path(String url, Map<String,Object> parmas,  final ServiceCallback callback) {
        Observable<String> observable = RxServiceManager.RetrofitServeApiFor()
                .Obget(url, parmas, new HashMap<>());
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
