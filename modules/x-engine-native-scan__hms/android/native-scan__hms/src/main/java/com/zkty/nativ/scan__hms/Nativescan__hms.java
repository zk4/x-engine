package com.zkty.nativ.scan__hms;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativescan__hms extends NativeModule implements Iscan__hms {

    @Override
    public String moduleId() {
        return "com.zkty.native.scan__hms";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
