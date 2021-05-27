package com.zkty.engine.module.network.net;

import com.zkty.engine.module.network.net.api.CommonApi;
import com.zkty.engine.module.network.net.callback.ServiceCallback;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.exception.ApiException;
import com.zkty.nativ.network.net.rx.RxUtil;
import com.zkty.nativ.network.utils.LogUtils;

import java.util.ArrayList;
import java.util.List;

public class NetWorkManager {

    private static NetWorkManager mInstance;

    private List<String> imageUrlList = new ArrayList<>();
    private int currentNum = 0;

    private NetWorkManager() {
    }

    public static NetWorkManager getInstance() {
        if (mInstance == null) {
            mInstance = new NetWorkManager();
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
        RxServiceManager.LoginServeApiFor()
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
        RxServiceManager.ScheduleServeApiFor()
                .getScheduleAccomplishedInfo()
                .compose(RxUtil.<BaseResp>handleRestfullResult())
                .subscribe(
                        responseBean -> {
                            callback.onSuccess(responseBean);
                        },
                        throwable -> handlerThrowable(throwable, callback)
                );
    }


    public void downLoadFile(){

    }

}
