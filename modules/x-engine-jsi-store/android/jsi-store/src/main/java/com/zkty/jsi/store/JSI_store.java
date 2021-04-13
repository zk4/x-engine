package com.zkty.jsi.store;

import androidx.annotation.Nullable;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.store.IStore;
import com.zkty.nativ.store.NativeStore;

public class JSI_store extends xengine_jsi_store {

    private NativeStore iStore;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IStore.class);
        if (module instanceof NativeStore)
            iStore = (NativeStore) module;
    }

    @Override
    public void _get(_0_com_zkty_jsi_store_DTO dto, CompletionHandler<String> handler) {
        iStore.get(dto.key);
        handler.complete();
    }

    @Override
    public String _get(_0_com_zkty_jsi_store_DTO dto) {
        return String.valueOf(iStore.get(dto.key));

    }

    @Override
    public void _set(ZKStoreEntryDTO dto, CompletionHandler<Nullable> handler) {
        iStore.set(dto.key, dto.val);
    }

    @Override
    public Object _set(ZKStoreEntryDTO dto) {
        iStore.set(dto.key, dto.val);
        return null;
    }
}
