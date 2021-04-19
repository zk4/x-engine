package com.zkty.jsi;

import android.webkit.JavascriptInterface;

import com.alibaba.fastjson.JSONObject;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.direct.NativeDirect;
import com.zkty.nativ.jsi.JSIModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.store.IStore;
import com.zkty.nativ.store.NativeStore;

import java.util.HashMap;
import java.util.Map;

public class JSIOldLocalstorageModule extends JSIModule {

    private NativeStore iStore;

    @Override
    public String moduleId() {
        return "com.zkty.module.localstorage";
    }

    @Override
    protected void afterAllJSIModuleInited() {

        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IStore.class);
        if (module instanceof NativeStore)
            iStore = (NativeStore) module;
    }

    @JavascriptInterface
    final public void set(JSONObject obj, final CompletionHandler<Object> handler) {
        if (iStore != null)
            iStore.set(obj.getString("key"), obj.get("value"));
        handler.complete();
    }

    @JavascriptInterface
    final public void get(JSONObject obj, final CompletionHandler<Object> handler) {
        Map<String, Object> map = new HashMap<>();
        if (iStore != null) {
            map.put("result", iStore.get(obj.getString("key")));
        }
        handler.complete(map);
    }

    @JavascriptInterface
    final public void remove(JSONObject obj, final CompletionHandler<Object> handler) {
        if (iStore != null) {
            iStore.del(obj.getString("key"));
        }
        handler.complete();
    }

}
