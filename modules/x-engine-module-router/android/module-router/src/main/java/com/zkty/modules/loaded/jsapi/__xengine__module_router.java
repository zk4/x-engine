package com.zkty.modules.loaded.jsapi;

import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSON;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.engine.webview.XOneWebViewPool;


public class __xengine__module_router extends xengine__module_router {

    @Override
    public void _openTargetRouter(RouterOpenAppDTO dto, CompletionHandler<Nullable> handler) {
        XOneWebViewPool.IS_ROUTER = true;
        RouterAspect.openTargetRouter(dto.type, dto.uri, dto.path, dto.args == null ? null : JSON.toJSONString(dto.args), dto.version == null ? null : String.valueOf(dto.version));
        handler.complete();
    }
}
