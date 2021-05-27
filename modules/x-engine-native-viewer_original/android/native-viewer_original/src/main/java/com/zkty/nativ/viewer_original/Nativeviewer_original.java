package com.zkty.nativ.viewer_original;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativeviewer_original extends NativeModule implements Iviewer_original {

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer_original";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
