package com.zkty.demo.pedestal.dto;

public class MessageEvent {
    public static final int ON_MICRO_APP_CLICK = 0x10;


    public int type;
    public int position;
    public String msg;

    public MessageEvent(int type, int position) {
        this.type = type;
        this.position = position;
    }

    public MessageEvent(int type, String msg) {
        this.type = type;
        this.msg = msg;
    }

    public MessageEvent(int type) {
        this.type = type;
    }
}
