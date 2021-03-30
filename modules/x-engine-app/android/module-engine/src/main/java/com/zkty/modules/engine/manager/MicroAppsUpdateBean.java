package com.zkty.modules.engine.manager;

import java.util.ArrayList;

public class MicroAppsUpdateBean {
    private int code;
    private int version;
    private ArrayList<MicroAppVersionBean> data;

    public MicroAppsUpdateBean() {
    }

    public MicroAppsUpdateBean(int code, int version, ArrayList<MicroAppVersionBean> data) {
        this.code = code;
        this.version = version;
        this.data = data;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public ArrayList<MicroAppVersionBean> getData() {
        return data;
    }

    public void setData(ArrayList<MicroAppVersionBean> data) {
        this.data = data;
    }
}
