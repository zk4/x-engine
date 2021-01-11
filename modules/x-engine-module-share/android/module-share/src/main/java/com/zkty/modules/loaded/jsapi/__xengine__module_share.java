package com.zkty.modules.loaded.jsapi;


import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.utils.ActivityUtils;


public class __xengine__module_share extends xengine__module_share {

    @Override
    public void _share(ShareReqDTO dto, CompletionHandler<ShareResDTO> handler) {
        ShareMaster.share(ActivityUtils.getCurrentActivity(), dto.channel, dto.type, dto.title, dto.desc, dto.link, dto.imageurl, dto.dataurl, null, null);
        handler.complete();
    }

    @Override
    public void _shareForOpenWXMiniProgram(MiniProgramReqDTO dto, CompletionHandler<ShareResDTO> handler) {
        ShareMaster.share(ActivityUtils.getCurrentActivity(), "wx_friend", "miniProgram", dto.title, dto.desc, dto.link, dto.imageurl, null, dto.userName, dto.path);
        handler.complete();
    }
}
