package com.zkty.nativ.share;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativeshare extends NativeModule implements Ishare {

    @Override
    public String moduleId() {
        return "com.zkty.native.share";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
