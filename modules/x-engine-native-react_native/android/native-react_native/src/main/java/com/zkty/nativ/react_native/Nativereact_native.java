package com.zkty.nativ.react_native;

import com.zkty.nativ.core.NativeModule;

public class Nativereact_native extends NativeModule implements Ireact_native {

    @Override
    public String moduleId() {
        return "com.zkty.native.react_native";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
