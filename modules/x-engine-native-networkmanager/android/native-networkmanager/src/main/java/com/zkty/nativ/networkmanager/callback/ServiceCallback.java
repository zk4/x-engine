package com.zkty.nativ.networkmanager.callback;



public interface ServiceCallback<T> {

    /**
     * 成功-200
     */
    void onSuccess(T jsonObj);

    /**
     * 失败-400、404、500等
     */
    void onError(String msg);

}
