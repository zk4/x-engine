package com.zkty.nativ.direct;

import com.anthonynsimon.url.URL;
import com.anthonynsimon.url.exceptions.MalformedURLException;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.utils.UrlUtils;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;

import java.util.Map;

public class DirectManager {

    public static void push(String scheme, String host, String pathname, String fragment, Map<String, String> query, Map<String, String> params) {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IDirectManager.class);
        if (module instanceof NativeDirect) {
            NativeDirect director = (NativeDirect) module;
            director.push(scheme, host, pathname, fragment, query, params);
        }

    }

    public static void push(HistoryModel model) {
        if (model != null) {
            push(model.scheme, model.host, model.pathname, model.fragment, model.query, model.params);
        }
    }


    public static void push(String url, Map<String, String> params) {

        try {
            URL url1 = URL.parse(url);
            String scheme = url1.getScheme();
            //URL解析的 fragment 包含query，eg：/mall2/orderlist?selectedIndex=0，故query传null
            push(scheme, url1.getHost(), url1.getPath(), url1.getFragment(), UrlUtils.getQueryMapFormString(url1.getQuery()), params);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }


    }

    public static void push(String url) {

        try {
            URL url1 = URL.parse(url);
            String scheme = url1.getScheme();
            //URL解析的 fragment 包含query，eg：/mall2/orderlist?selectedIndex=0，故query传null
            push(scheme, url1.getHost(), url1.getPath(), url1.getFragment(), null, null);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }

    }
}
