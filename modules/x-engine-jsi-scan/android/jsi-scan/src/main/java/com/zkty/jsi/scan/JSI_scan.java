package com.zkty.jsi.scan;


import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.scan.CallBack;
import com.zkty.nativ.scan.Iscan;
import com.zkty.nativ.scan.Nativescan;

public class JSI_scan extends xengine_jsi_scan {


    private Nativescan iScan;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Iscan.class);
        if (module instanceof Nativescan)
            iScan = (Nativescan) module;
    }

    @Override
    public void _openScanView(CompletionHandler<String> handler) {
        iScan.openScanView(new CallBack() {
            @Override
            public void succes(String code) {
                handler.complete(code);
            }
        });
    }
}
