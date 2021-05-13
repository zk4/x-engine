package com.zkty.nativ.viewer_orgi;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativeviewer_orgi extends NativeModule implements Iviewer_orgi {

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer_orgi";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
