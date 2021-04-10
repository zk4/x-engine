package com.zkty.jsi;

import androidx.annotation.Nullable;

import com.zkty.modules.nativ.core.NativeContext;
import com.zkty.modules.nativ.jsi.bridge.CompletionHandler;

public class JSI_ui extends xengine_jsi_ui{
    private JSI_ui ui;
    @Override
    protected void afterAllJSIModuleInited() {
//this.ui = NativeContext.sharedInstance().getModuleByProtocol()
    }

    @Override
    public void _setNavTitle(NavTitleDTO dto, CompletionHandler<Nullable> handler) {

    }

    @Override
    public void _setNavBarHidden(NavHiddenBarDTO dto, CompletionHandler<Nullable> handler) {

    }


}
