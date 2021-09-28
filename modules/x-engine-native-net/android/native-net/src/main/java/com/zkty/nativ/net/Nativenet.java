package com.zkty.nativ.net;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativenet extends NativeModule implements Inet {

    @Override
    public String moduleId() {
        return "com.zkty.native.net";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
