package com.zkty.modules.engine.utils;

import android.content.Context;

import java.io.File;

public class ResourceManager {
    private static final String TAG = ResourceManager.class.getSimpleName();


    private static Context mContext;

    public static void init(Context context) {
        mContext = context;
    }

    public static File getCacheDir() {
        return mContext.getCacheDir();
    }

}
