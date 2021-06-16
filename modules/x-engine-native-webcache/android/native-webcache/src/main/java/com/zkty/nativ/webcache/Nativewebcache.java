package com.zkty.nativ.webcache;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativewebcache extends NativeModule implements Iwebcache {

    @Override
    public String moduleId() {
        return "com.zkty.native.webcache";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
