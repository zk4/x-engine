package com.zkty.modules.engine.utils;

import android.text.TextUtils;

import java.util.HashMap;
import java.util.Map;

public class UrlUtils {

    public static boolean equalsWithoutArgs(String url1, String url2) {
        if (TextUtils.isEmpty(url1) || TextUtils.isEmpty(url2)) {
            return false;
        }
        String temp1 = null;
        String temp2 = null;
        if (url1.contains("?"))
            temp1 = url1.substring(0, url1.indexOf("?"));
        else
            temp1 = url1;

        if (url2.contains("?"))
            temp2 = url2.substring(0, url2.indexOf("?"));
        else temp2 = url2;


        return temp1.endsWith(temp2);
    }


    public static String getRouterFormPath(String path) {

        if (TextUtils.isEmpty(path)) return null;

        if (path.startsWith("/index"))
            path = path.replace("/index#", "");
        if (path.contains("?"))
            return path.substring(0, path.indexOf("?"));
        return path;

    }


    public static String getRouterFormUrl(String url) {

        if (TextUtils.isEmpty(url)) return null;


        if (url.contains("#")) {
            String path = url.substring(url.indexOf("#") + 1);
            return getRouterFormPath(path);

        }
        return null;

    }


    /**
     * 解析url
     *
     * @param url
     * @return
     */
    public static Map<String, String> parseForParams(String url) {
        Map<String, String> map = new HashMap();
        if (url == null) {
            return map;
        }
        url = url.trim();
        if (url.equals("")) {
            return map;
        }
        if (url.contains("?")) {
            url = url.substring(url.indexOf("?") + 1);
        } else {
            return map;
        }

        //有参数
        String[] params = url.split("&");
        for (String param : params) {
            String[] keyValue = param.split("=");
            if (keyValue.length > 1)
                map.put(keyValue[0], keyValue[1]);
        }
        return map;
    }
}
