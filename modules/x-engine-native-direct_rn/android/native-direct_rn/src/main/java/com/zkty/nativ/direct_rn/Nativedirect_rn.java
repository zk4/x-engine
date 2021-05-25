package com.zkty.nativ.direct_rn;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativedirect_rn extends NativeModule implements Idirect_rn {

    @Override
    public String moduleId() {
        return "com.zkty.native.direct_rn";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
