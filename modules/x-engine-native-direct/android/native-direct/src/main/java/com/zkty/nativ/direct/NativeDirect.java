package com.zkty.nativ.direct;


import android.text.TextUtils;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.jsi.webview.XWebViewPool;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class NativeDirect extends NativeModule implements IDirectManager {


    {
        directors = new HashMap<>();
    }

    private Map<String, IDirect> directors;

    @Override
    public String moduleId() {
        return "com.zkty.native.direct";
    }

    @Override
    public int order() {
        return 0;
    }

    @Override
    public void afterAllNativeModuleInited() {
        List<NativeModule> modules = NativeContext.sharedInstance().getModulesByProtocol(IDirect.class);
        for (NativeModule iDirect : modules) {
            if (iDirect instanceof IDirect) {
                directors.put(((IDirect) iDirect).scheme(), (IDirect) iDirect);
            }
        }
    }

    @Override
    public void push(String scheme, String host, String pathname, String fragment, Map<String, String> query, Map<String, String> params) {

        IDirect iDirect = directors.get(scheme);
        iDirect.push(iDirect.protocol(), host, pathname, fragment, query, params);
    }

    @Override
    public void back(String scheme, String host, String fragment) {
        IDirect iDirect = directors.get(scheme);
        iDirect.back(host, fragment);
    }
}
