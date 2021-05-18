package com.zkty.jsi;


import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.share.IShareManager;
import com.zkty.nativ.share.NativeShare;

public class JSI_share extends xengine_jsi_share {
    private NativeShare shares;

    @Override
    protected void afterAllJSIModuleInited() {

        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IShareManager.class);
        if (module instanceof NativeShare)
            shares = (NativeShare) module;

    }

    @Override
    public void _share(_0_com_zkty_jsi_share_DTO dto, CompletionHandler<String> handler) {
        if (shares != null) {
            shares.share(dto.channel, dto.type, dto.text, dto.title, dto.desc, dto.imgUrl, dto.imgData, dto.url, dto.userName, dto.path, dto.link, dto.miniProgramType);
        }

    }

}
