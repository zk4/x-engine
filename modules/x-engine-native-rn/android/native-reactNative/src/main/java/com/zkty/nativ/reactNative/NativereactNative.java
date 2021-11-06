package com.zkty.nativ.reactNative;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class NativereactNative extends NativeModule implements IreactNative {

    @Override
    public String moduleId() {
        return "com.zkty.native.reactNative";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
