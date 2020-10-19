package com.zkty.modules.loaded.callback;

import java.io.InputStream;
import java.util.HashMap;

public class XEngineNetResponse {
    private int code;
    private long contentLength;
    private HashMap<String, String> header;
    private InputStream body;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public long getContentLength() {
        return contentLength;
    }

    public void setContentLength(long contentLength) {
        this.contentLength = contentLength;
    }

    public HashMap<String, String> getHeader() {
        return header;
    }

    public void setHeader(HashMap<String, String> header) {
        this.header = header;
    }

    public InputStream getBody() {
        return body;
    }

    public void setBody(InputStream body) {
        this.body = body;
    }

    @Override
    public String toString() {
        return "XEngineNetResponse{" +
                "code=" + code +
                ", contentLength=" + contentLength +
                ", header=" + header +
                '}';
    }
}
