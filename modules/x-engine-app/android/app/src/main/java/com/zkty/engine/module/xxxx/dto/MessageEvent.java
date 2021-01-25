package com.zkty.engine.module.xxxx.dto;

public class MessageEvent {

    private int type;
    private int position;
    private String msg;

    public MessageEvent(int type, int position) {
        this.type = type;
        this.position = position;
    }

    public MessageEvent(int type, String msg) {
        this.type = type;
        this.msg = msg;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }
}
