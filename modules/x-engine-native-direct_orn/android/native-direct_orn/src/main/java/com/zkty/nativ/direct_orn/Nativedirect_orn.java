package com.zkty.nativ.direct_orn;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativedirect_orn extends NativeModule implements Idirect_orn {

    @Override
    public String moduleId() {
        return  "com.zkty.native.direct_orn";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
