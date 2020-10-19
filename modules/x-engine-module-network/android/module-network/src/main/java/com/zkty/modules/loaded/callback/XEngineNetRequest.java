package com.zkty.modules.loaded.callback;

import java.util.Map;

public class XEngineNetRequest {
    private String url;
    private Map<String, String> header;
    private Map<String, String> params;
    private byte[] body;


    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Map<String, String> getHeader() {
        return header;
    }

    public void setHeader(Map<String, String> header) {
        this.header = header;
    }

    public Map<String, String> getParams() {
        return params;
    }

    public void setParams(Map<String, String> params) {
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
