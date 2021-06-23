package com.zkty.nativ.geo;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativegeo extends NativeModule implements Igeo {

    @Override
    public String moduleId() {
        return "com.zkty.native.geo";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
