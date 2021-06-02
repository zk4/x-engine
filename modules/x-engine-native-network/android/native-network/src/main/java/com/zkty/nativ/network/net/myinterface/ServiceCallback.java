package com.zkty.nativ.network.net.myinterface;


import com.zkty.nativ.network.net.exception.ApiException;

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
