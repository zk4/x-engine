package com.zkty.modules.engine.webview;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class XOneWebViewPool {

    public static boolean IS_SINGLE = true;
    public static boolean IS_WEB = false;

    private static Map<String, XEngineWebView> circleMap;
    private static final byte[] lock = new byte[]{};
    private Context mContext;


    private XOneWebViewPool() {
        circleMap = new HashMap<>();
    }

    private static volatile XOneWebViewPool instance = null;

    public static XOneWebViewPool sharedInstance() {
        if (instance == null) {
            synchronized (XOneWebViewPool.class) {
                if (instance == null) {
                    instance = new XOneWebViewPool();
                }
            }
        }
        return instance;
    }

    /**
     * Webview 初始化
     * EngineSdk初始化时调用
     */
    public void init(Context context) {
        this.mContext = context;

    }


    /**
     * 获取webview
     */
    public XEngineWebView getUnusedWebViewFromPool(String microAppId) {
        synchronized (lock) {
            XEngineWebView webView = null;
            if (IS_WEB || IS_SINGLE) {
                if (TextUtils.isEmpty(microAppId)) {
                    microAppId = "h5";
                }
                if (circleMap.containsKey(microAppId)) {
                    webView = circleMap.get(microAppId);
                } else {
                    webView = new XEngineWebView(mContext);
                    circleMap.put(microAppId, webView);
                }

                ViewGroup parent = (ViewGroup) webView.getParent();
                if (parent != null) {
                    parent.removeAllViews();
                }
            } else {
                webView = new XEngineWebView(mContext);
                circleMap.put("common", webView);
            }
            return webView;
        }
    }

    public void cleanWebView() {
        circleMap.clear();
    }

    public void putWebViewBackToPool(XEngineWebView webView) {
        circleMap.put("common", webView);
    }

}
