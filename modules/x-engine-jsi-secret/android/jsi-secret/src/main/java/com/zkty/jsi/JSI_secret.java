package com.zkty.jsi;


import com.zkty.nativ.store.StoreUtils;

public class JSI_secret extends xengine_jsi_secret {
    @Override
    protected void afterAllJSIModuleInited() {

    }

    @Override
    public String _get(String dto) {
        //TODO权限


        return (String) StoreUtils.get(dto, null);
    }
}
