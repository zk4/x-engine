package com.zkty.jsi;

import androidx.annotation.Nullable;

import com.zkty.engine.nativ.protocol.IDirectManager;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.direct.NativeDirect;
import com.zkty.nativ.jsi.bridge.CompletionHandler;

public class JSI_direct extends xengine_jsi_direct {

    private NativeDirect directors;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IDirectManager.class);
        if (module instanceof NativeDirect)
            directors = (NativeDirect) module;
    }

    @Override
    public void _push(DirectPushDTO dto, CompletionHandler<Nullable> handler) {
        if (directors != null) {
            directors.push(dto.scheme, dto.host, dto.pathname, dto.fragment, dto.query, dto.params);
        }

    }

    @Override
    public void _back(DirectBackDTO dto, CompletionHandler<Nullable> handler) {
        if (directors != null) {
            directors.back(dto.scheme, null, dto.fragment);
        }
    }


}
