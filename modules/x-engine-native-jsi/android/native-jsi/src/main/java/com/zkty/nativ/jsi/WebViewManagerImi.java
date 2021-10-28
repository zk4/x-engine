package com.zkty.nativ.jsi;

import android.webkit.WebView;

import com.zkty.nativ.jsi.webview.XEngineWebView;

/**
 * @author : MaJi
 * @time : (10/22/21)
 * dexc :
 */
public interface WebViewManagerImi {
    /**
     * Activity webview 创建
     * @param webView
     */
    void activityCreateWevView(XEngineWebView webView);
    /**
     * Activity webview 销毁
     * @param webView
     */
    void activityDestroyWebView(XEngineWebView webView);
    /**
     * fragment webview 创建
     * @param webView
     */
    void fragmentCreateWevView(XEngineWebView webView);
    /**
     * fragment webview 销毁
     * @param webView
     */
    void fragmentDestroyWebView(XEngineWebView webView);
    
}
