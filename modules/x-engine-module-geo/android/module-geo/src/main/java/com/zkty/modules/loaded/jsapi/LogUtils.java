package com.zkty.modules.loaded.jsapi;

import android.text.TextUtils;
import android.util.Log;

public class LogUtils {

    private static boolean isDebug = true;


    public static boolean isIsDebug() {
        return isDebug;
    }

    public static void setIsDebug(boolean isDebug) {
        LogUtils.isDebug = isDebug;
    }

    public static void d(String tag, String content) {
        if (isDebug && !TextUtils.isEmpty(tag)) {
            Log.d(tag, content);
        }
    }
}
