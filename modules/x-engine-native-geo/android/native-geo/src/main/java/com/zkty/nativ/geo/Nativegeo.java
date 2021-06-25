package com.zkty.nativ.geo;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Nativegeo extends NativeModule implements IGeoManager {

    private List<NativeModule> modules;

    @Override
    public String moduleId() {
        return "com.zkty.native.geo";
    }

    @Override
    public void afterAllNativeModuleInited() {
        modules = NativeContext.sharedInstance().getModulesByProtocol(Igeo.class);

    }

    @Override
    public void locate(CallBack callBack) {
        if (modules == null || modules.size() == 0) {
            callBack.onLocation(null);
            return;
        }

        Igeo igeo = (Igeo) modules.get(0);
        igeo.locate(callBack);


    }
}
