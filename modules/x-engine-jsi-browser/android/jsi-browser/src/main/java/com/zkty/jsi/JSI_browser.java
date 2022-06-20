package com.zkty.jsi;


import com.zkty.jsi.xengine_jsi_browser;
import com.zkty.nativ.browser.Ibrowser;
import com.zkty.nativ.browser.Nativebrowser;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;

public class JSI_browser extends xengine_jsi_browser {
    private Nativebrowser iBrowser;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Ibrowser.class);
        if (module instanceof Nativebrowser)
            iBrowser = (Nativebrowser) module;


    }

    @Override
    public void _open(_1_com_zkty_jsi_browser_DTO dto, CompletionHandler<_0_com_zkty_jsi_browser_DTO> handler) {
        iBrowser.open(dto.url, (code, msg) -> {
            _0_com_zkty_jsi_browser_DTO dto1 = new _0_com_zkty_jsi_browser_DTO();
            dto1.code = code;
            dto1.msg = msg;
            handler.complete(dto1);
        });
    }
}
