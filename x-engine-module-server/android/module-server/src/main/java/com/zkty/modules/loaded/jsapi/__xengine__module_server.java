package com.zkty.modules.loaded.jsapi;

import android.webkit.JavascriptInterface;

import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.loaded.core.xengine__module_BaseModule;

import org.json.JSONObject;



public class __xengine__module_server extends xengine__module_BaseModule {


    @Override
    protected String moduleId() {
        return "com.zkty.module.server";
    }

    @Override
    protected void onAllModulesInited() {
        super.onAllModulesInited();
    }

    @JavascriptInterface
    public void showActionSheet(JSONObject obj, final CompletionHandler<String> handler) {
         //   handler.complete("success");

    }

}
