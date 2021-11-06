package com.zkty.nativ.rn;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativern extends NativeModule implements Irn {

    @Override
    public String moduleId() {
        return "com.zkty.native.rn";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
