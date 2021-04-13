package com.zkty.nativ.direct;

import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;

import java.util.Map;

public class DirectManager {

    public static void push(String scheme, String host, String pathname, String fragment, Map<String, Object> query, Map<String, Object> params) {
        String protocol = "https:";
        if ("omp".equals(scheme)) protocol = "https:";
        if ("http".equals(scheme)) protocol = "http:";
        if ("https".equals(scheme)) protocol = "https:";
        if ("microapp".equals(scheme)) protocol = "file:";

        boolean hideNavbar = params != null && params.containsKey("hideNavbar") && Boolean.parseBoolean(String.valueOf(params.get("hideNavbar")));
        XEngineWebActivityManager.sharedInstance().startXEngineActivity(XEngineApplication.getCurrentActivity(), protocol, host, pathname, fragment, hideNavbar);

    }
}
