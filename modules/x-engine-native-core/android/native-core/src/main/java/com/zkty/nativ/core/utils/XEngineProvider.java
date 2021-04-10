package com.zkty.nativ.core.utils;

import androidx.core.content.FileProvider;

import com.zkty.nativ.core.XEngineApplication;


public class XEngineProvider extends FileProvider {
    public static String getProvider() {
        return XEngineApplication.getApplication().getPackageName() + ".provider";
    }

}
