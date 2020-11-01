package com.zkty.modules.loaded.jsapi;

import androidx.annotation.Nullable;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;


public class __xengine__module_router extends xengine__module_router {

    @Override
    public void _openTargetRouter(RouterOpenAppDTO dto, CompletionHandler<Nullable> handler) {

        RouterMaster.openTargetRouter(XEngineWebActivityManager.sharedInstance().getCurrent(), dto.type, dto.uri, dto.path, dto.agrs, null);
    }
}
