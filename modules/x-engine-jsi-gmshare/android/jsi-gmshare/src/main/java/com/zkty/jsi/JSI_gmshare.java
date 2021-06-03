package com.zkty.jsi;


import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.gmshare.Bean.OpenShareUiBean;
import com.zkty.nativ.gmshare.Bean.PosterInfoBean;
import com.zkty.nativ.gmshare.Bean.ResultDataBean;
import com.zkty.nativ.gmshare.Igmshare;
import com.zkty.nativ.gmshare.Nativegmshare;
import com.zkty.nativ.gmshare.ShareUiCallBack;
import com.zkty.nativ.jsi.bridge.CompletionHandler;

public class JSI_gmshare extends xengine_jsi_gmshare {

    private Nativegmshare iGmShare;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module =  NativeContext.sharedInstance().getModuleByProtocol(Igmshare.class);
        if (module instanceof Nativegmshare)
            iGmShare = (Nativegmshare) module;
    }


    @Override
    public void _openShareUi(OpenShareUiDTO dto, CompletionHandler<ChannelStatusDTO> handler) {
        String dataStr = JSON.toJSONString(dto);
        JSONObject jsonObject = JSON.parseObject(dataStr);
        OpenShareUiBean gmNativeShareDto = jsonObject.toJavaObject(OpenShareUiBean.class);
        iGmShare.openShareUi(gmNativeShareDto, new ShareUiCallBack() {
            @Override
            public void resultData(ResultDataBean resultDataBean) {
                ChannelStatusDTO channelStatusDTO = new ChannelStatusDTO();
                channelStatusDTO.channel = resultDataBean.getChannel();
                channelStatusDTO.shareType = resultDataBean.getShareType();
                channelStatusDTO.shareImgData = resultDataBean.getShareImgData();
                handler.complete(channelStatusDTO);
            }
        });
    }

    @Override
    public void _createPoster(PosterDTO dto, CompletionHandler<Nullable> handler) {
        String dataStr = JSON.toJSONString(dto);
        JSONObject jsonObject = JSON.parseObject(dataStr);
        PosterInfoBean posterInfoBean = jsonObject.toJavaObject(PosterInfoBean.class);
        iGmShare.createPoster(posterInfoBean);
    }
}
