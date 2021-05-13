package com.zkty.nativ.viewer-orgi;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativeviewer-orgi extends NativeModule implements Iviewer-orgi {

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer-orgi";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
