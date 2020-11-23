package com.zkty.modules.engine.utils;

import android.text.TextUtils;

public class UrlUtils {

    public static boolean equalsWithoutArgs(String url1, String url2) {
        if (TextUtils.isEmpty(url1) || TextUtils.isEmpty(url2)) {
            return false;
        }
        if (url1.contains("?")) {
            url1 = url1.substring(0, url1.charAt('?'));
        }
        if (url2.contains("?")) {
            url2 = url1.substring(0, url2.charAt('?'));
        }


        return url1.equals(url2);
    }
}
