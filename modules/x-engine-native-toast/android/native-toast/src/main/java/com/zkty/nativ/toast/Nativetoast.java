package com.zkty.nativ.toast;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativetoast extends NativeModule implements Itoast {

    @Override
    public String moduleId() {
        return "com.zkty.native.toast";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
