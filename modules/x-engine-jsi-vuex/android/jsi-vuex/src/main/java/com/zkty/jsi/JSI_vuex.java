package com.zkty.jsi;


import com.zkty.nativ.broadcast.IBroadcast;
import com.zkty.nativ.broadcast.NativeBroadcast;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.jsi.webview.XWebViewPool;
import com.zkty.nativ.store.IStore;
import com.zkty.nativ.store.NativeStore;

public class JSI_vuex extends xengine_jsi_vuex {
    private NativeStore iStore;
    private NativeBroadcast iBroadcast;
    private static final String VUEX_STORE_KEY = "@@VUEX_STORE_KEY";
    private static final String BROADCAST_EVENT = "VUEX_STORE_EVENT";

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IStore.class);
        if (module instanceof NativeStore) {
            iStore = (NativeStore) module;
        }
        NativeModule module2 = NativeContext.sharedInstance().getModuleByProtocol(IBroadcast.class);
        if (module2 instanceof NativeBroadcast) {
            iBroadcast = (NativeBroadcast) module2;
        }

    }

    @Override
    public String _get(String dto) {

        return (String) iStore.get(genKey(dto));
    }

    @Override
    public void _set(_0_com_zkty_jsi_vuex_DTO dto) {
        iStore.set(genKey(dto.key), dto.val);
        iBroadcast.broadcast(BROADCAST_EVENT, dto.val);
    }

    private String genKey(String key) {

        HistoryModel hm = XWebViewPool.sharedInstance().getCurrentWebView().getHistoryModel();
        if (hm == null)
            return key;

        return String.format("%s%s%s:%s", VUEX_STORE_KEY, hm.host == null ? "" : hm.host, hm.pathname == null ? "" : hm.pathname, key);

    }
}
