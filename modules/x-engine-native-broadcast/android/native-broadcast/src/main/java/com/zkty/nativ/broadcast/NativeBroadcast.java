package com.zkty.nativ.broadcast;

import android.util.Log;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.jsi.webview.XOneWebViewPool;

import java.util.List;

public class NativeBroadcast extends NativeModule {

    @Override
    public String moduleId() {
        return "com.zkty.native.broadcast";
    }

    public void broadcast(String payload) {
        List<XEngineWebView> total = XOneWebViewPool.sharedInstance().getWebViews();
        total.addAll(XOneWebViewPool.sharedInstance().getTabWebViewList());

        for (XEngineWebView webView : total) {
            webView.callHandler("com.zkty.module.engine.broadcast", new Object[]{payload}, retValue -> Log.d("NativeBroadcast", "broadcast:" + payload));
        }
    }
}
