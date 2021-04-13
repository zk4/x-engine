package com.zkty.nativ.jsi.utils;

import java.util.List;

public class XEngineMessage {

    public static final String MSG_TYPE_SCOPE = "x_engine_msg_type_scope";//广播事件
    public static final String MSG_TYPE_ON = "x_engine_msg_type_on";//广播开
    public static final String MSG_TYPE_OFF = "x_engine_msg_type_off";//广播关闭

    public static final String MSG_TYPE_PAGE_CLOSE = "x_engine_msg_type_page_close";//通知某些页面关闭自己

    public static final String TYPE_SHOW_TABBAR = "type_show_tabbar";
    public static final String TYPE_HIDE_TABBAR = "type_hide_tabbar";

    public static final String MSG_TYPE_LOGIN = "x_engine_msg_type_login";//登录
    public static final String MSG_TYPE_LOGOUT = "x_engine_msg_type_loginout";//退出登录

    private String type;

    private List<String> msgList;

    private String msg;

    public XEngineMessage(String typeShowTabbar) {
        this.type = typeShowTabbar;
    }

    public XEngineMessage(String type, List<String> msgList) {
        this.type = type;

        this.msgList = msgList;
    }

    public XEngineMessage(String type, String msg) {
        this.type = type;
        this.msg = msg;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public List<String> getMsgList() {
        return msgList;
    }

    public void setMsgList(List<String> msgList) {
        this.msgList = msgList;
    }
}
