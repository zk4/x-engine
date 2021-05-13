package com.zkty.nativ.viewer;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativeviewer extends NativeModule implements Iviewer {

    @Override
    public String moduleId() {
        return "com.zkty.native.viewer";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
