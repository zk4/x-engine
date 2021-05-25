package com.zkty.nativ.dev;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativedev extends NativeModule implements Idev {

    @Override
    public String moduleId() {
        return "com.zkty.native.dev";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
