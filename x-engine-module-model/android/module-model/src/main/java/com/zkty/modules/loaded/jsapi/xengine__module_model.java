package com.zkty.modules.loaded.jsapi;

import android.webkit.JavascriptInterface;

import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.annotation.Optional;

import com.zkty.modules.engine.core.xengine__module_BaseModule;



import java.util.List;


class ActionSheetDto {
    public List<String> itemList;
    @Optional
    public String desc;
    @Optional
    public TestDto test;

}


class TestDto {
    public String test1;
    @Optional
    public List<String> test2;
}

interface xengine__module_model_i {

    void _showActionSheet(ActionSheetDto dto, final CompletionHandler<String> handler);

}

public abstract class xengine__module_model extends xengine__module_BaseModule implements xengine__module_model_i {


    @Override
    public String moduleId() {
        return "com.zkty.module.model";
    }


    @JavascriptInterface
    public void showActionSheet(JSONObject obj, final CompletionHandler<String> handler) {
        _showActionSheet(convert(obj, ActionSheetDto.class), handler);
    }

}


