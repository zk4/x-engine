package com.zkty.jsi;


import android.util.Log;

import com.zkty.jsi.xengine_jsi_dev;
import com.zkty.nativ.jsi.webview.XWebViewPool;

public class JSI_dev extends xengine_jsi_dev {
    @Override
    protected void afterAllJSIModuleInited() {

    }

    @Override
    public void _log(String dto) {
        Log.d("DWebView-Log", dto);
    }
}
