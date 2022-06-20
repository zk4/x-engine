package com.zkty.nativ.browser;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativebrowser extends NativeModule implements Ibrowser {

    @Override
    public String moduleId() {
        return "com.zkty.native.browser";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
