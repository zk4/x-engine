package com.zkty.nativ.jsi;

import android.content.Context;

import com.zkty.nativ.jsi.webview.XEngineWebView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GlobalState {
    private XEngineWebView s_showing_webview;
    private Map<XEngineWebView, ArrayList<HistoryModel>> wv__vc_paths;

    private GlobalState() {
        wv__vc_paths = new HashMap<>();
    }

    private static volatile GlobalState instance = null;

    public static GlobalState sharedInstance() {
        if (instance == null) {
            synchronized (GlobalState.class) {
                if (instance == null) {
                    instance = new GlobalState();
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
    }

    public String getLastHost() {
        if (s_showing_webview != null) {
            ArrayList<HistoryModel> histories = wv__vc_paths.get(s_showing_webview);
            if (histories != null && histories.size() > 0) {
                return histories.get(histories.size() - 1).host;
            }
        }
        return null;
    }

    public void setCurrentWebView(XEngineWebView webView) {
        this.s_showing_webview = webView;
    }

    public XEngineWebView getCurrentWebView() {
        return s_showing_webview;
    }

    public List<HistoryModel> getCurrentWebViewHistories() {
        if (s_showing_webview != null) {
            return wv__vc_paths.get(s_showing_webview);
        }
        return new ArrayList<>();
    }

    public void clearHistory(XEngineWebView key) {
        List<HistoryModel> discardedItems = new ArrayList<>();
        List<HistoryModel> histories = wv__vc_paths.get(key);
        if (histories != null) {
            for (HistoryModel item : histories) {
                if (!item.isResume)
                    discardedItems.add(item);
            }
            wv__vc_paths.get(key).removeAll(discardedItems);
        }
    }

    public void addCurrentWebViewHistory(HistoryModel model) {
        List<HistoryModel> histories = wv__vc_paths.get(s_showing_webview);
        if (histories==null){
            histories = new ArrayList<>();
        }
        histories.add(model);
    }
}
