package com.zkty.jsi.legacy.nav;

import android.webkit.JavascriptInterface;

import com.alibaba.fastjson.JSONObject;
import com.zkty.engine.nativ.protocol.IDirectManager;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.direct.NativeDirect;
import com.zkty.nativ.jsi.JSIModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;

import java.util.HashMap;
import java.util.Map;

public class JSIOldNavModule extends JSIModule {

    private NativeDirect directors;

    @Override
    public String moduleId() {
        return "com.zkty.module.nav";
    }

    @Override
    protected void afterAllJSIModuleInited() {

        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IDirectManager.class);
        if (module instanceof NativeDirect)
            directors = (NativeDirect) module;
    }

    @JavascriptInterface
    public void navigatorPush(JSONObject obj, final CompletionHandler<Object> handler) {
        String scheme = "microapp";
        if (directors != null) {
            Map<String, Object> map = new HashMap<>();
            map.put("hideNavbar", obj.get("hideNavbar"));
            directors.push(scheme, null, null,
                    obj.getString("url"), null, map);
        }
    }

    @JavascriptInterface
    public void navigatorBack(JSONObject obj, final CompletionHandler<Object> handler) {
        String scheme = "microapp";
        if (directors != null) {
            directors.back(scheme, null, obj.getString("url"));
        }

    }


}
