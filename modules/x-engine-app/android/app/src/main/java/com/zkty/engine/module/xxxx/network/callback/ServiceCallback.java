package com.zkty.engine.module.xxxx.network.callback;


import com.zkty.engine.module.xxxx.network.networkframe.net.exception.ApiException;

public interface ServiceCallback<T> {

    /**
     * 成功-200
     */
    void onSuccess(T jsonObj);

    /**
     * 失败-400、404、500等
     */
    void onError(ApiException apiException);

    /**
     * 失效-401
     */
    void onInvalid();
}
