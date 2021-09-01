package com.zkty.nativ.media2;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativemedia2 extends NativeModule implements Imedia2 {

    @Override
    public String moduleId() {
        return "com.zkty.native.media2";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
