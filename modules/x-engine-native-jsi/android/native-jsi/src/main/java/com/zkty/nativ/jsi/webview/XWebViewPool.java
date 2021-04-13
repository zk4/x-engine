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

    public void setMultiMode(boolean mode) {
        this.IS_MULTI_MODE = mode;
    }


    /**
     * 获取webview
     */
    public XEngineWebView getUnusedWebViewFromPool(String host) {
        synchronized (lock) {
            XEngineWebView webView = null;
            if (IS_MULTI_MODE || circleList.size() == 0) {

                webView = new XEngineWebView(mContext);
                circleList.add(webView);

            } else {
                webView = circleList.get(circleList.size() - 1);
                if (!host.equals(circleList.get(circleList.size() - 1).getHistoryModels().get(0).host)) {
                    webView = new XEngineWebView(mContext);
                    circleList.add(webView);
                } else {
                    ViewGroup parent = (ViewGroup) webView.getParent();
                    if (parent != null) {
                        parent.removeAllViews();
                    }
                }
            }
            return webView;
        }
    }

    public void cleanWebView() {
        circleList.clear();
    }

    public void removeWebView(XEngineWebView webView) {
        if (circleList.contains(webView))
            circleList.remove(webView);

    }

    //返回最后一个webview 并清除其他
    public XEngineWebView getLastWebView() {
        if (circleList.size() > 0) {
            return circleList.get(circleList.size() - 1);
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


    //返回第一个webview 并清除其他
//    public XEngineWebView getFirstWebView() {
//        if (circleList.size() > 0) {
//            circleList.subList(0, 1);
//            return circleList.get(0);
//        }
//        return null;
//    }
//
//    //返回指定host webview 并清除其后面的
//    public XEngineWebView getWebViewFromPool(String host) {
//        if (TextUtils.isEmpty(host)) {
//            return circleList.get(circleList.size() - 1);
//        }
//
//
//        int index = -1;
//        for (int i = circleList.size() - 1; i > -1; i--) {
//            if (circleList.get(i).getHistoryModels().get(0).host.equals(host)) {
//                index = i;
//                break;
//            }
//        }
//        if (index == circleList.size() - 1) {
//            return circleList.get(circleList.size() - 1);
//        }
//        if (index > -1) {
//
//            circleList.subList(0, index + 1);
//            return circleList.get(circleList.size() - 1);
//
//        } else {
//            return null;
//        }
//
//    }

}
