package com.zkty.nativ.browser;

public interface Ibrowser {
    void open(String url, CallBack callBack);

    interface CallBack {
        void onResult(int code, String msg);
    }

}
