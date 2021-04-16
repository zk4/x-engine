package com.zkty.jsi.scan;

import android.webkit.JavascriptInterface;

import com.alibaba.fastjson.JSONObject;
import com.zkty.nativ.jsi.JSIModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;


class StorageDTO {
    String key;

}


interface xengine_jsi_scan_protocol {

    <T> T _getSyn(StorageDTO dto);

    <T> void _getAsyn(StorageDTO dto, CompletionHandler<T> handler);
}


public abstract class xengine_jsi_scan extends JSIModule implements xengine_jsi_scan_protocol {
    @Override
    public String moduleId() {
        return "com.zkty.jsi.scan";
    }

    @JavascriptInterface
    public <T> T getSyn(JSONObject dto) {
        String defaultStr = "{\"key\":\"xx\"}";
        dto = mergeDefault(dto, defaultStr);
        StorageDTO storageDTO = convert(dto, StorageDTO.class);
        return _getSyn(storageDTO);
    }

    @JavascriptInterface
    public <T> void getAsyn(JSONObject dto, CompletionHandler<T> handler) {
        String defaultStr = "{}";
        dto = mergeDefault(dto, defaultStr);
        StorageDTO storageDTO = convert(dto, StorageDTO.class);
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
