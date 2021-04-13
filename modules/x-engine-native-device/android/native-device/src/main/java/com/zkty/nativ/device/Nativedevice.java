package com.zkty.nativ.device;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativedevice extends NativeModule implements Idevice {

    @Override
    public String moduleId() {
        return "com.zkty.native.device";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
