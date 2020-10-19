package com.zkty.engine.module.protocol.net;

import java.util.HashMap;

/**
 *
 */
public class XEngineNetRequest {
    private String url;
    private HashMap<String, String> header;
    private HashMap<String, String> params;
    private byte[] body;


    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public HashMap<String, String> getHeader() {
        return header;
    }

    public void setHeader(HashMap<String, String> header) {
        this.header = header;
    }

    public HashMap<String, String> getParams() {
        return params;
    }

    public void setParams(HashMap<String, String> params) {
        this.params = params;
    }

    public byte[] getBody() {
        return body;
    }

    public void setBody(byte[] body) {
        this.body = body;
    }

    @Override
    public String toString() {
        return "XEngineNetRequest{" +
                "url='" + url + '\'' +
                ", header=" + header +
                ", params=" + params +
                '}';
    }
}
