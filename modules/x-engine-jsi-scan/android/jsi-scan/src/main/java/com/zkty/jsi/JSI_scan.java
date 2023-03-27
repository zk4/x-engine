package com.zkty.jsi;


import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.scan.CallBack;
import com.zkty.nativ.scan.IScan;
import com.zkty.nativ.scan.NativeScan;
import com.zkty.nativ.scan.ScanExtDto;

public class JSI_scan extends xengine_jsi_scan {


    private NativeScan iScan;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IScan.class);
        if (module instanceof NativeScan)
            iScan = (NativeScan) module;
    }


    @Override
    public void _openScanView(_0_com_zkty_jsi_scan_DTO dto, CompletionHandler<String> handler) {
        ScanExtDto dto1 = new ScanExtDto();
        if (dto != null) {
            dto1.routerUrl = dto.routerUrl;
        }

        iScan.openScanView(dto1, new CallBack() {
            @Override
            public void succes(String code) {
                handler.complete(code);
            }
        });
    }
}
