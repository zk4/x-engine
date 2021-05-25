package com.zkty.nativ.direct_native;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativedirect_native extends NativeModule implements Idirect_native {

    @Override
    public String moduleId() {
        return "com.zkty.native.direct_native";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
