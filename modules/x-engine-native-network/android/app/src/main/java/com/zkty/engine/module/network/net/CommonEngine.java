package com.zkty.engine.module.network.net;

import com.zkty.engine.module.network.net.api.CommonApi;
import com.zkty.engine.module.network.net.callback.ServiceCallback;
import com.zkty.nativ.network.api.RetrofitHttpService;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.exception.ApiException;
import com.zkty.nativ.network.net.rx.RxUtil;
import com.zkty.nativ.network.utils.LogUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

public class CommonEngine {

    private static CommonEngine mInstance;

    private List<String> imageUrlList = new ArrayList<>();
    private int currentNum = 0;

    private CommonEngine() {
    }

    public static CommonEngine getInstance() {
        if (mInstance == null) {
            mInstance = new CommonEngine();
        }
        return mInstance;
    }


    public void handlerThrowable(Throwable throwable, ServiceCallback callback) {
        if (throwable instanceof ApiException) {
            callback.onError((ApiException) throwable);
        } else {
            LogUtils.e(throwable.getMessage(), throwable);
        }
    }

    public void getSmsCode(String phoneNum, final ServiceCallback callback) {
        RxServiceManager.LoginServeApiFor(CommonApi.class)
                .getSmsCode(phoneNum)
                .compose(RxUtil.<BaseResp>handleRestfullResult())
                .subscribe(
                        responseBean -> {
                            callback.onSuccess(responseBean);
                        },
                        throwable -> handlerThrowable(throwable, callback)
                );
    }

    public void getScheduleListById(final ServiceCallback callback) {
        RxServiceManager.ScheduleServeApiFor(CommonApi.class)
                .getScheduleAccomplishedInfo()
                .compose(RxUtil.<BaseResp>handleRestfullResult())
                .subscribe(
                        responseBean -> {
                            callback.onSuccess(responseBean);
                        },
                        throwable -> handlerThrowable(throwable, callback)
                );
    }
    public void post(final ServiceCallback callback) {
        RxServiceManager.ScheduleServeApiFor(RetrofitHttpService.class)
                .Obpost("login",new HashMap<>(),new HashMap<>())
//                .compose(RxUtil.<BaseResp>handleRestfullResult())
                .subscribe(
                        responseBean -> {
                            callback.onSuccess(responseBean);
                        },
                        throwable -> handlerThrowable(throwable, callback)
                );
    }

}
