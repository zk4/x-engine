package com.zkty.nativ.webcache.lib;

import android.util.Log;

class CacheWebViewLog {
    private static final String TAG = "CacheWebView";


    public static void d(String log) {
        Log.d(TAG, log);
    }
    public static void d(String log,boolean show) {
        if (show){
            d(log);
        }
    }
}
