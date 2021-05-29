package com.zkty.jsi;


import androidx.appcompat.app.AlertDialog;

import com.zkty.jsi.xengine_jsi_globalstorage;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.webview.XWebViewPool;
import com.zkty.nativ.store.IStore;
import com.zkty.nativ.store.NativeStore;

public class JSI_globalstorage extends xengine_jsi_globalstorage {
    private NativeStore iStore;

    @Override
    protected void afterAllJSIModuleInited() {
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IStore.class);
        if (module instanceof NativeStore) {
            iStore = (NativeStore) module;
        }

    }

    @Override
    public String _get(String dto) {
        return (String) iStore.get(genKey(dto));
    }

    @Override
    public void _set(_0_com_zkty_jsi_globalstorage_DTO dto) {

        //如果 key 存在, 则无法存值. 弹框提示. 需要调用者主动 delete .
        if (iStore.has(genKey(dto.key))) {
            AlertDialog dialog = new AlertDialog.Builder(XEngineApplication.getCurrentActivity())
                    .setMessage(String.format("key: %s 已存在! 你正在覆盖全局数据! 请调用 del 后再重试.", dto.key))
                    .setCancelable(true)
                    .setPositiveButton("确定", (dialog1, which) -> dialog1.dismiss())
                    .create();
            dialog.show();
        } else {
            iStore.set(genKey(dto.key), dto.val);
        }

    }

    @Override
    public void _del(String dto) {
        iStore.del(genKey(dto));

    }

    private String genKey(String key) {
        return String.format("%s:%s", "__global__key__:", key);
    }
}
