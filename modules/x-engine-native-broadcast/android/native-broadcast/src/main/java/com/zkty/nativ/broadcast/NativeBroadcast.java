package com.zkty.nativ.broadcast;

import android.util.Log;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.jsi.webview.XWebViewPool;

import java.util.HashMap;
import java.util.Map;

public class NativeBroadcast extends NativeModule implements IBroadcast {

    @Override
    public String moduleId() {
        return "com.zkty.native.broadcast";
    }

    @Override
    public void broadcast(String type, String payload) {

        Map<String, String> bro = new HashMap<>();
        bro.put("type", type);
        bro.put("payload", payload);

        for (XEngineWebView webView : XWebViewPool.sharedInstance().getWebViews()) {
            webView.callHandler("com.zkty.module.engine.broadcast", new Object[]{bro}, retValue -> Log.d("NativeBroadcast", "broadcast:" + payload));
        }
        for (XEngineWebView webView : XWebViewPool.sharedInstance().getTabWebViewList()) {
            webView.callHandler("com.zkty.module.engine.broadcast", new Object[]{bro}, retValue -> Log.d("NativeBroadcast", "broadcast:" + payload));
        }
    }
}
