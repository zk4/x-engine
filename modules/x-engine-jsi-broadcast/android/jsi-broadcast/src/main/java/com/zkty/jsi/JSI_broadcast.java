package com.zkty.jsi;


import com.zkty.nativ.broadcast.IBroadcast;
import com.zkty.nativ.broadcast.NativeBroadcast;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;

public class JSI_broadcast extends xengine_jsi_broadcast {
    private NativeBroadcast iBroadcast;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IBroadcast.class);
        if (module instanceof NativeBroadcast)
            iBroadcast = (NativeBroadcast) module;

    }

//    @Override
//    public void _triggerBroadcast(_0_com_zkty_jsi_broadcast_DTO dto) {
//        iBroadcast.broadcast(dto.type, dto.payload);
//    }
}
