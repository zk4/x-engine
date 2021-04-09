package com.zkty.modules.engine.provider;

import androidx.core.content.FileProvider;

import com.zkty.modules.nativ.core.XEngineApplication;

public class XEngineProvider extends FileProvider {
    public static String getProvider() {
        return XEngineApplication.getApplication().getPackageName() + ".provider";
    }

}
