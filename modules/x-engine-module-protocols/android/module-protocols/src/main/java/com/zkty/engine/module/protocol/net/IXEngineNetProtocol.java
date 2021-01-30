package com.zkty.engine.module.protocol.net;

import java.util.Map;

public interface IXEngineNetProtocol {
    String CONTENT_TYPE_JSON = "application/json; charset=utf-8";
    String CONTENT_TYPE_OCTET = "application/octet-stream";


    enum Method {
        GET,
        POST,
        PUT,
        DELETE,
        PATCH,
        HEADER;
    }

    void doRequest(Method method,
                   final String url, final Map<String, String> header, final Map<String, String> params,
                   final Map<String, String> file, final IXEngineNetProtocolCallback callback);

    void cancelAll();

    /**
     * 监控网络驱动模块运行状况
     *
     * @return
     */
    String monitor();
}
