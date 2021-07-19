package com.zkty.nativ.offline;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativeoffline extends NativeModule implements Ioffline {

    @Override
    public String moduleId() {
        return "com.zkty.native.offline";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
