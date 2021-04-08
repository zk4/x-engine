package com.zkty.modules.loaded.jsapi;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.nativ.jsi.JSIModule;

class NavTitleDTO {
    String title;
    String titleColor;
    int titleSize;
}


interface xengine_jsi_xxxx_protocol {
    void _setNavTitle(NavTitleDTO dto, CompletionHandler completionHandler);

}


public abstract class xengine_jsi_xxxx extends JSIModule implements xengine_jsi_xxxx_protocol {

}
