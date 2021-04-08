package com.zkty.engine.nativ.protocol;

import com.zkty.modules.nativ.core.Protocol;

import java.util.Map;

public interface IDirect extends Protocol {
    /**
     * scheme 形如
     * 1. omp   使用(protocol) http:     协议，webview 带原生 api 功能
     * 2. omps  使用(protocol) https:    协议，webview 带原生 api 功能
     * 3. http  普通(protocol) http:     协议，webview 不带原生 api 功能
     * 4. https 普通(protocol) https:    协议，webview 不带原生 api 功能
     * 5. microapp 普通(protocol) file:  协议，打开本地微应用文件
     * 注意 protocol 带:, 形如 http: https:
     * fragment 一定以 / 开头
     **/


    String scheme();

    String protocol();

    void push(
            String protocol,
            String host,
            String pathname,
            String fragment,
            Map<String, Object> query,
            Map<String, Object> params
    );

    void back(String host, String fragment);

}
