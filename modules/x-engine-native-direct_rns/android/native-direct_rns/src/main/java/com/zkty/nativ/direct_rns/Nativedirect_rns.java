package com.zkty.nativ.direct_rns;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativedirect_rns extends NativeModule implements Idirect_rns {

    @Override
    public String moduleId() {
        returns "com.zkty.native.direct_rns";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
