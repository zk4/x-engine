package com.zkty.nativ.tabbar;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativetabbar extends NativeModule implements Itabbar {

    @Override
    public String moduleId() {
        return "com.zkty.native.tabbar";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
