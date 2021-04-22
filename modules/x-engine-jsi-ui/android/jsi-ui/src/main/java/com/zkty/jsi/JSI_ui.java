package com.zkty.jsi;

import androidx.annotation.Nullable;

import com.zkty.engine.nativ.protocol.IUI;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.ui.NativeUI;


public class JSI_ui extends xengine_jsi_ui{
    private NativeUI iUi;
    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IUI.class);
        if (module instanceof NativeUI)
            iUi = (NativeUI) module;
    }

    @Override
    public void _setNavTitle(NavTitleDTO dto, CompletionHandler<Nullable> handler) {
        iUi.setNavTitle(dto.title,dto.titleColor,dto.titleSize);
    }

    @Override
    public void _setNavBarHidden(NavHiddenBarDTO dto, CompletionHandler<Nullable> handler) {
        iUi.setNavBarHidden(dto.isHidden,dto.isAnimation);
    }


}
