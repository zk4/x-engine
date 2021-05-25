package com.zkty.nativ.network.bean;

import java.util.List;

public class CommonNodeArrObjectRequestBean {

    /**
     * jsonrpc : 2.0
     * method : common_getRules
     * params : []
     * id : 1
     */

    private String jsonrpc;
    private String method;
    private int id;
    private List<Object> params;

    public String getJsonrpc() {
        return jsonrpc;
    }

    public void setJsonrpc(String jsonrpc) {
        this.jsonrpc = jsonrpc;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Object> getParams() {
        return params;
    }

    public void setParams(List<Object> params) {
        this.params = params;
    }
}
