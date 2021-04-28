package com.zkty.jsi;


import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.webview.XWebViewPool;
import com.zkty.nativ.store.IStore;
import com.zkty.nativ.store.NativeStore;
import com.zkty.nativ.store.StoreUtils;

public class JSI_localstorage extends xengine_jsi_localstorage {
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

        return (String) iStore.get(genKey(dto));
    }

    @Override
    public void _set(_0_com_zkty_jsi_localstorage_DTO dto) {
        iStore.set(dto.key, dto.val);
    }

    private String genKey(String key) {

        HistoryModel hm = XWebViewPool.sharedInstance().getCurrentWebView().getHistoryModel();
        if (hm == null)
            return key;

        return String.format("%s%s:%s", hm.host == null ? "" : hm.host, hm.pathname == null ? "" : hm.pathname, key);

    }
}
