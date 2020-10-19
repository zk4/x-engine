package com.zkty.modules.loaded.jsapi;

import android.util.Log;

import com.zkty.modules.dsbridge.CompletionHandler;

public class __xengine__module_model extends xengine__module_model {

    public void _showActionSheet(ActionSheetDto dto, final CompletionHandler<String> handler) {
        Log.d("model", dto.itemList.toString());
        handler.complete("show");
    }

}