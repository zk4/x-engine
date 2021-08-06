package com.zkty.nativ.hms_scan;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativehms_scan extends NativeModule implements Ihms_scan {

    @Override
    public String moduleId() {
        return "com.zkty.native.hms_scan";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
