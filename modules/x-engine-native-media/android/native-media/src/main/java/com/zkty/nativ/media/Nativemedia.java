package com.zkty.nativ.media;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativemedia extends NativeModule implements Imedia {

    @Override
    public String moduleId() {
        return "com.zkty.native.media";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
