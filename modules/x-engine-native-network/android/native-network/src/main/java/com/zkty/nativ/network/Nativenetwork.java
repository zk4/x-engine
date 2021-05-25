package com.zkty.nativ.network;

import com.zkty.nativ.core.NativeModule;

public class Nativenetwork extends NativeModule implements Inetwork {

    @Override
    public String moduleId() {
        return "com.zkty.native.network";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }
}
