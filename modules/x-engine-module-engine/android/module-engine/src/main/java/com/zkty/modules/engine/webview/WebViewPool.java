package com.zkty.modules.engine.webview;

import android.content.Context;
import android.util.Log;
import android.view.ViewGroup;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.List;

public class WebViewPool {

    private static List<XEngineWebView> circleList;

    private static final byte[] lock = new byte[]{};
    private static int maxSize = 5;
    private int currentIndex = 0;
    private Context mContext;

    private WebViewPool() {
        circleList = new ArrayList<>();
    }

    private static volatile WebViewPool instance = null;

    public static WebViewPool sharedInstance() {
        if (instance == null) {
            synchronized (WebViewPool.class) {
                if (instance == null) {
                    instance = new WebViewPool();
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
            expandWebViewsBy(maxSize);
        }
    }

    private void expandWebViewsBy(int size) {
        long start = System.currentTimeMillis();
        for (int i = 0; i < size; i++) {
            XEngineWebView webView = new XEngineWebView(mContext);
            circleList.add(webView);
        }
        long duration = System.currentTimeMillis() - start;
        Log.d("EngineSdk", String.format(" webview pool 耗时%d毫秒,共创建%d个webView", duration, size));
    }

    public XEngineWebView peekNextUnusedWebViewFromPool() {
        return circleList.get(currentIndex);
    }


    /**
     * 获取webview
     */
    public XEngineWebView getUnusedWebViewFromPool() {
        synchronized (lock) {
            XEngineWebView webView = circleList.get(currentIndex);
            currentIndex++;
            if (circleList.size() - currentIndex < 2) {
//                new Thread(() -> { expandWebViewsBy(3); }).start();
                expandWebViewsBy(3);
            }
            Log.d("EngineSdk", String.format("get():circleList size = %d ,currentIndex = %d", circleList.size(), currentIndex));

            ViewGroup parent = (ViewGroup) webView.getParent();
            if (parent != null) {
                parent.removeAllViews();
            }
            return webView;
        }
    }

    /**
     * 将webView放回池中
     *
     * @param webView 需要被回收的webview
     */
    public void putBackWebViewIntoPool(@NonNull XEngineWebView webView) {

        webView.clearAnimation();
        webView.stopLoading();
        webView.setWebChromeClient(null);
//        webView.setWebViewClient(null);
        webView.clearCache(true);
        webView.clearHistory();
        webView.loadUrl("about:blank");
        ViewGroup parent = (ViewGroup) webView.getParent();
        if (parent != null) {
            parent.removeAllViews();
        }
        currentIndex--;
        synchronized (lock) {
            if (circleList.size() - currentIndex > 5) {
                circleList = circleList.subList(0, currentIndex + 3);
            }
        }
        Log.d("EngineSdk", String.format("put():circleList size = %d ,currentIndex = %d", circleList.size(), currentIndex));
    }

}