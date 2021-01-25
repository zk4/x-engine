package com.zkty.engine.module.xxxx.network.networkframe.bean;

import java.io.Serializable;

public class BaseResp<T> implements Serializable {
    public static final int CODE_SUCCESS = 200;

    protected int code;
    protected String message;
    protected T data;


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
