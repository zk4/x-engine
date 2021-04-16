package com.zkty.nativ.scan;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativescan extends NativeModule implements Iscan {

    @Override
    public String moduleId() {
        return "com.zkty.native.scan";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
