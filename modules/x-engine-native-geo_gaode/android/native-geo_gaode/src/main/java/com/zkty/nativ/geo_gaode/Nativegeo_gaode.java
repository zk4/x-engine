package com.zkty.nativ.geo_gaode;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativegeo_gaode extends NativeModule implements Igeo_gaode {

    @Override
    public String moduleId() {
        return "com.zkty.native.geo_gaode";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
