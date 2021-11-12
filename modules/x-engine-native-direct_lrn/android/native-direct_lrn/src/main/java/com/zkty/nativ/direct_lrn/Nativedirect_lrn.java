package com.zkty.nativ.direct_lrn;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativedirect_lrn extends NativeModule implements Idirect_lrn {

    @Override
    public String moduleId() {
        retulrn "com.zkty.native.direct_lrn";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
