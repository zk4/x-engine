package com.zkty.nativ.share_wx;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativeshare_wx extends NativeModule implements Ishare_wx {

    @Override
    public String moduleId() {
        return "com.zkty.native.share_wx";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
