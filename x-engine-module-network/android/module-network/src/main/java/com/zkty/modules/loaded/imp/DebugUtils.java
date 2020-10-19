package com.zkty.modules.loaded.imp;

import android.text.TextUtils;
import android.util.Log;

public class DebugUtils {
    private static boolean debug = true;


    public static boolean isDebug() {
        return debug;
    }

    public static void setDebug(boolean debug) {
        DebugUtils.debug = debug;
    }

    public static void debug(String tag, String content) {
        if (debug) {
            if (!TextUtils.isEmpty(tag) && !TextUtils.isEmpty(content)) {
                Log.d(tag, content);
            }
        }
    }
}
