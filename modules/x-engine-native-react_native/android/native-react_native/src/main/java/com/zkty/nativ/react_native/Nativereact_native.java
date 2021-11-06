package com.zkty.nativ.react_native;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativereact_native extends NativeModule implements Ireact_native {

    @Override
    public String moduleId() {
        return "com.zkty.native.react_native";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
