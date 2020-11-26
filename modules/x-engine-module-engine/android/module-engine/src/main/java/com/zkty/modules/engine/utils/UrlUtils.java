package com.zkty.modules.engine.utils;

import android.text.TextUtils;

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
}
