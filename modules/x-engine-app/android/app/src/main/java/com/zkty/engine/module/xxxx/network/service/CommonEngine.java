package com.zkty.engine.module.xxxx.network.service;

import com.zkty.engine.module.xxxx.network.callback.ServiceCallback;
import com.zkty.engine.module.xxxx.network.networkframe.api.CommonApi;
import com.zkty.engine.module.xxxx.network.networkframe.bean.BaseResp;
import com.zkty.engine.module.xxxx.network.networkframe.bean.TokenBean;
import com.zkty.engine.module.xxxx.network.networkframe.net.rx.RxService;
import com.zkty.engine.module.xxxx.network.networkframe.net.rx.RxUtil;


import java.util.ArrayList;
import java.util.List;

import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

public class CommonEngine {

    private static CommonEngine mInstance;
    private CommonService commonService;

    private List<String> imageUrlList = new ArrayList<>();
    private int currentNum = 0;

    private CommonEngine(CommonService commonService) {
        this.commonService = commonService;
    }

    public static CommonEngine getInstance(CommonService commonService) {
        if (mInstance == null) {
            mInstance = new CommonEngine(commonService);
        }
        return mInstance;
    }

    public void postLogin(String grant_type, final String username, String password, String clientId, String clientSecret, String scope, final ServiceCallback callback) {
        RxService.createBasicApi(CommonApi.class, commonService.HOST_OAUTH)
                .postLogin(grant_type, username, password, clientId, clientSecret, scope)
                .compose(RxUtil.<BaseResp<TokenBean>>handleRestfullResult())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(
                        responseBean -> {
                            callback.onSuccess(responseBean);
                        },
                        throwable -> commonService.handlerThrowable(throwable, callback)
                );
    }


}
