package com.zkty.modules.nativ.core;


public abstract class NativeModule {

    public abstract String moduleId();

    public int order() {
        return 0;
    }

    public void afterAllNativeModuleInited() {
    }
}