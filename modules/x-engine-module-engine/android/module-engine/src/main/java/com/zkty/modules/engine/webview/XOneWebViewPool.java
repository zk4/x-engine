package com.zkty.modules.engine.webview;

import android.content.Context;
import android.util.Log;
import java.util.ArrayList;
import java.util.List;

public class XOneWebViewPool {

    public static final boolean IS_SINGLE = true;

    private static List<XEngineWebView> circleList;
    private static final byte[] lock = new byte[]{};
    private Context mContext;

    private XOneWebViewPool() {
        circleList = new ArrayList<>();
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
        synchronized (lock) {
            expandWebView();
        }
    }

    private void expandWebView() {
        long start = System.currentTimeMillis();
        XEngineWebView webView = new XEngineWebView(mContext);
        circleList.add(webView);
        long duration = System.currentTimeMillis() - start;
        Log.d("EngineSdk", String.format(" webview pool 耗时%d毫秒,共创建%d个webView", duration, circleList.size()));
    }


    /**
     * 获取webview
     */
    public XEngineWebView getUnusedWebViewFromPool() {
        synchronized (lock) {
            XEngineWebView webView = null;
            if (IS_SINGLE) {
                webView = circleList.get(0);
            } else {
                webView = new XEngineWebView(mContext);
                circleList.add(0, webView);
            }
            return webView;
        }
    }

    /**
     * 获取当前webview
     */
    public XEngineWebView peekUnusedWebViewFromPool() {
        return circleList.get(0);
    }

    public void putWebViewBackToPool(XEngineWebView webView) {
        circleList.add(0, webView);
    }

}
