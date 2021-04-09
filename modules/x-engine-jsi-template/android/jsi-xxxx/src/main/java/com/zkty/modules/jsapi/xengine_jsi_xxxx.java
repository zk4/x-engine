package com.zkty.jsi;

import android.webkit.JavascriptInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.nativ.jsi.JSIModule;

class StorageDTO {
    String key;

}


interface xengine_jsi_xxxx_protocol {

    <T> T _getSyn(StorageDTO dto);

    <T> void _getAsyn(StorageDTO dto, CompletionHandler<T> handler);
}


public abstract class xengine_jsi_xxxx extends JSIModule implements xengine_jsi_xxxx_protocol {
    @Override
    public String moduleId() {
        return "com.zkty.jsi.xxxx";
    }

    @JavascriptInterface
    public <T> T getSyn(JSONObject dto) {
        String defaultStr = ;
        StorageDTO storageDTO = convert(defaultStr, dto, StorageDTO.class);
        return _getSyn(storageDTO);
    }

    @JavascriptInterface
    public <T> void getAsyn(JSONObject dto, CompletionHandler<T> handler) {
        String defaultStr = "{}";
        StorageDTO storageDTO = convert(defaultStr, dto, StorageDTO.class);
        _getAsyn(storageDTO, new CompletionHandler<T>() {

            @Override
            public void complete(T retValue) {
                handler.complete(retValue);
            }

            @Override
            public void complete() {
                handler.complete();
            }

            @Override
            public void setProgressData(T value) {
                handler.setProgressData(value);
            }
        });
    }
}
