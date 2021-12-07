package com.zkty.nativ.direct_orns;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativedirect_orns extends NativeModule implements Idirect_orns {

    @Override
    public String moduleId() {
        return  "com.zkty.native.direct_orns";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
