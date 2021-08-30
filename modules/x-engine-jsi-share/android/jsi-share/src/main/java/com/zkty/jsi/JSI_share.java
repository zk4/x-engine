package com.zkty.jsi;


import androidx.annotation.Nullable;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.share.IShareManager;
import com.zkty.nativ.share.Ishare;
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
    public void _share(ShareDTO dto, CompletionHandler<_0_com_zkty_jsi_share_DTO> handler) {
        if (shares != null) {
            shares.share(dto.channel, dto.type, dto.info, new Ishare.CallBack() {
                @Override
                public void onResult(int code) {
                    _0_com_zkty_jsi_share_DTO dto1 = new _0_com_zkty_jsi_share_DTO();
                    dto1.code = code;
                    handler.complete(dto1);
                }
            });
        } else {
            _0_com_zkty_jsi_share_DTO dto1 = new _0_com_zkty_jsi_share_DTO();
            dto1.code = -1;
            handler.complete(dto1);

        }
    }
}
