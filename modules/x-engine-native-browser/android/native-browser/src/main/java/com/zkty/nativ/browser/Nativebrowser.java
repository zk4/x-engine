package com.zkty.nativ.browser;

import android.content.Intent;
import android.net.Uri;
import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;

import java.io.File;

public class Nativebrowser extends NativeModule implements Ibrowser {

    @Override
    public String moduleId() {
        return "com.zkty.native.browser";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public void open(String url, CallBack callBack) {
        try {
            Intent intent = new Intent();
            intent.setAction(Intent.ACTION_VIEW);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            intent.setData(Uri.parse(url));
            XEngineApplication.getCurrentActivity().startActivity(intent);
            callBack.onResult(0, "success");
            return;
        } catch (Exception e) {
            e.printStackTrace();
        }
        callBack.onResult(-1, "链接解析失败，或找不到浏览器");

    }
}
