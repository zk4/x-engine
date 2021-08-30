package com.zkty.nativ.core.utils;

import android.app.Activity;

import androidx.appcompat.app.AlertDialog;

import com.zkty.nativ.core.XEngineApplication;

import nativ.core.BuildConfig;

public class DebugAlert {


    private static boolean IS_DEBUG = "debug".equals(BuildConfig.BUILD_TYPE);

    public static void alert(Object obj, String msg) {

        if (IS_DEBUG && obj == null) {
            Activity activity = XEngineApplication.getCurrentActivity();
            activity.runOnUiThread(() -> {
                AlertDialog dialog = new AlertDialog.Builder(activity)
                        .setMessage(msg)
                        .setCancelable(true)
                        .setPositiveButton("确定", (dialog1, which) -> dialog1.dismiss())
                        .create();
                dialog.show();


            });


        }
    }
}
