package com.zkty.modules.nativ.jsi.webview;

import android.content.Context;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.List;

public class XOneWebViewPool {

    public static boolean IS_SINGLE = true;
    public static boolean IS_WEB = false;
    public static boolean IS_ROUTER = false;


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

    }


    /**
     * 获取webview
     */
    public XEngineWebView getUnusedWebViewFromPool() {
        synchronized (lock) {
            XEngineWebView webView = null;
            if (IS_ROUTER || circleList.size() == 0) {

                webView = new XEngineWebView(mContext);
                circleList.add(webView);

            } else {
                webView = circleList.get(circleList.size() - 1);
                ViewGroup parent = (ViewGroup) webView.getParent();
                if (parent != null) {
                    parent.removeAllViews();
                }
            }
            return webView;
        }
    }

    public void cleanWebView() {
        circleList.clear();
        XOneWebViewPool.IS_ROUTER = false;
    }

    public void removeWebView(XEngineWebView webView) {
        if (circleList.contains(webView))
            circleList.remove(webView);

    }

    public void putWebViewBackToPool(XEngineWebView webView) {

    }

}
