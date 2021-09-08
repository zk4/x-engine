package com.zkty.nativ.localstorage__webproxy;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativelocalstorage__webproxy extends NativeModule implements Ilocalstorage__webproxy {

    @Override
    public String moduleId() {
        return "com.zkty.native.localstorage__webproxy";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
