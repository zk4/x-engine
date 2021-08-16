package com.zkty.nativ.updator;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativeupdator extends NativeModule implements Iupdator {

    @Override
    public String moduleId() {
        return "com.zkty.native.updator";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
