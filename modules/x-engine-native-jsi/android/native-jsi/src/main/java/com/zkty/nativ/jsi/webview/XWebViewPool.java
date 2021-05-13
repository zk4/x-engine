package com.zkty.nativ.jsi.webview;

import android.content.Context;
import android.view.ViewGroup;

import java.util.ArrayList;
import java.util.List;

public class XWebViewPool {
    //多WebView模式:每个页面一个webview
    //单微博View模式：每个微应用一个webview
    public static boolean IS_MULTI_MODE = true;

    //微应用webview
    private static List<XEngineWebView> circleList;
    //tab 上的webview ，一般不会被清理
    private static List<XEngineWebView> tabWebViewList;
    private static final byte[] lock = new byte[]{};
    private Context mContext;

    private XEngineWebView currentWebView;
    private XEngineWebView currentTabWebView;


    private XWebViewPool() {
        circleList = new ArrayList<>();
        tabWebViewList = new ArrayList<>();
    }

    private static volatile XWebViewPool instance = null;

    public static XWebViewPool sharedInstance() {
        if (instance == null) {
            synchronized (XWebViewPool.class) {
                if (instance == null) {
                    instance = new XWebViewPool();
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

//    public void setMultiMode(boolean mode) {
//        this.IS_MULTI_MODE = mode;
//    }


    /**
     * 获取webview
     */
    public XEngineWebView getUnusedWebViewFromPool(String host) {
        synchronized (lock) {
            XEngineWebView webView = null;
//            if (IS_MULTI_MODE || circleList.size() == 0) {

            webView = new XEngineWebView(mContext);
            circleList.add(webView);

//            } else {
//                webView = circleList.get(circleList.size() - 1);
//                if (!host.equals(circleList.get(circleList.size() - 1).getHistoryModels().get(0).host)) {
//                    webView = new XEngineWebView(mContext);
//                    circleList.add(webView);
//                } else {
//                    ViewGroup parent = (ViewGroup) webView.getParent();
//                    if (parent != null) {
//                        parent.removeAllViews();
//                    }
//                }
//            }
            currentWebView = webView;
            return currentWebView;
        }
    }

    public void cleanWebView() {
        circleList.clear();
    }

    public void removeWebView(XEngineWebView webView) {
        if (circleList.contains(webView))
            circleList.remove(webView);

    }

    //返回最后一个webview
    public XEngineWebView getLastWebView() {
        if (circleList.size() > 0) {
            currentWebView = circleList.get(circleList.size() - 1);
            return currentWebView;
        }
        return null;
    }


    public List<XEngineWebView> getWebViews() {
        return circleList;
    }

    public void initTabWebView(int count) {
        tabWebViewList.clear();
        for (int i = 0; i < count; i++) {
            tabWebViewList.add(new XEngineWebView(mContext));

        }
    }

    //获取tab上的webview(分开管理，不被回收)
    public XEngineWebView getTabWebViewByIndex(int index) {
        if (tabWebViewList.size() <= index) {
            initTabWebView(index + 1);
        }
        XEngineWebView webView = tabWebViewList.get(index);
        ViewGroup parent = (ViewGroup) webView.getParent();
        if (parent != null) {
            parent.removeAllViews();
        }

        return webView;
    }

    public List<XEngineWebView> getTabWebViewList() {
        return tabWebViewList;
    }

    public XEngineWebView getCurrentWebView() {
        return getLastWebView() == null ? currentTabWebView : currentWebView;
    }

    public void setCurrentTabWebView(XEngineWebView webView) {
        this.currentTabWebView = webView;
    }

}
