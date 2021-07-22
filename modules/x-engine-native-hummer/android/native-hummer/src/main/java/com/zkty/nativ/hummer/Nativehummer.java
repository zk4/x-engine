package com.zkty.nativ.hummer;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativehummer extends NativeModule implements Ihummer {

    @Override
    public String moduleId() {
        return "com.zkty.native.hummer";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
