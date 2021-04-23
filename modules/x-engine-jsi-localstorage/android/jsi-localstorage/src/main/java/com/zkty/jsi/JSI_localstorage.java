package com.zkty.jsi;


import com.zkty.nativ.store.StoreUtils;

public class JSI_localstorage extends xengine_jsi_localstorage {
    @Override
    protected void afterAllJSIModuleInited() {

    }

    @Override
    public String _get(String dto) {
        String nameSpace = "";
        if (xEngineWebView != null && xEngineWebView.getHistoryModel() != null) {
            nameSpace = String.format("%s%s", xEngineWebView.getHistoryModel().host, "_key_");
        }
        return (String) StoreUtils.get(String.format("%s%s", nameSpace, dto), null);
    }

    @Override
    public void _set(_0_com_zkty_jsi_localstorage_DTO dto) {
        String nameSpace = "";
        if (xEngineWebView != null && xEngineWebView.getHistoryModel() != null) {
            nameSpace = String.format("%s%s", xEngineWebView.getHistoryModel().host, "_key_");
        }
        StoreUtils.put(String.format("%s%s", nameSpace, dto.key), dto.val);
    }
}
