package com.zkty.jsi;


import com.alibaba.fastjson.JSON;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.geo.IGeoManager;
import com.zkty.nativ.geo.Nativegeo;
import com.zkty.nativ.jsi.bridge.CompletionHandler;

public class JSI_geo extends xengine_jsi_geo {
    Nativegeo igeo;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IGeoManager.class);
        if (module instanceof Nativegeo)
            igeo = (Nativegeo) module;

    }

    @Override
    public void _locate(CompletionHandler<LocationDTO> handler) {
        igeo.locate(location -> {
            LocationDTO dto = JSON.parseObject(location, LocationDTO.class);
            handler.complete(dto);
        });
    }
}
