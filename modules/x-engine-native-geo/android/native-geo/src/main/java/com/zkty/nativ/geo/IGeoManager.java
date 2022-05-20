package com.zkty.nativ.geo;

public interface IGeoManager {

    void locate(CallBack callBack);

    void locatable(StatusCallBack callBack);

    interface CallBack {
        void onLocation(String location);
    }

    interface StatusCallBack {
        void onLocatable(int code);
    }

}
