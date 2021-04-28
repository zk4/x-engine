package com.zkty.jsi;


import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.store.IStore;
import com.zkty.nativ.store.NativeStore;
import com.zkty.nativ.store.StoreUtils;

public class JSI_secret extends xengine_jsi_secret {
    private NativeStore iStore;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IStore.class);
        if (module instanceof NativeStore) {
            iStore = (NativeStore) module;
        }

    }

    @Override
    public String _get(String dto) {
        //TODO权限


        return (String) iStore.get(dto);
    }
}
