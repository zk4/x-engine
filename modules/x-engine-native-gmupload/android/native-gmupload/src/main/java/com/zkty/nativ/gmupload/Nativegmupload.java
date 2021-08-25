package com.zkty.nativ.gmupload;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativegmupload extends NativeModule implements Igmupload {

    @Override
    public String moduleId() {
        return "com.zkty.native.gmupload";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
