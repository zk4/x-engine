package com.zkty.modules.loaded.jsapi;


import androidx.annotation.Nullable;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.XEngineApplication;


public class __xengine__module_share extends xengine__module_share {

    @Override
    public void _share(ShareReqDTO dto, CompletionHandler<ShareResDTO> handler) {
        ShareMaster.share(XEngineApplication.getApplication(), dto.channel, dto.type, dto.title, dto.desc, dto.link, dto.imageurl, dto.imageurl);
    }
}
