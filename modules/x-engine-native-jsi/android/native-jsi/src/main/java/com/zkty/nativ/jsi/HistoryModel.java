package com.zkty.nativ.jsi;

import java.io.Serializable;
import java.util.Map;

public class HistoryModel implements Serializable {
    public boolean isResume;
    public String protocol;
    public String host;
    public String pathname;
    public String fragment;
    public Map<String, Object> query;
    public Map<String, Object> params;
}
