package com.zkty.modules.engine.utils;

import java.util.List;

public class XEngineMessage {

    public static final String MSG_TYPE_SCOPE = "x_engine_msg_type_scope";//广播事件
    public static final String MSG_TYPE_ON = "x_engine_msg_type_on";//广播开
    public static final String MSG_TYPE_OFF = "x_engine_msg_type_off";//广播关闭

    private String type;

    private List<String> msg;

    public XEngineMessage() {
    }

    public XEngineMessage(String type, List<String> msg) {
        this.type = type;

        this.msg = msg;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<String> getMsg() {
        return msg;
    }

    public void setMsg(List<String> msg) {
        this.msg = msg;
    }
}
