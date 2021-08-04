package com.zkty.nativ.cache;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativecache extends NativeModule implements Icache {

    @Override
    public String moduleId() {
        return "com.zkty.native.cache";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
