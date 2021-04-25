package com.zkty.nativ.direct_omp;

import android.app.Activity;
import android.text.TextUtils;

import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.direct.IDirect;
import com.zkty.nativ.jsi.exception.XEngineException;
import com.zkty.nativ.jsi.view.XEngineWebActivity;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;

import java.util.Map;
import java.util.regex.Pattern;

public class NativeDirectOmp extends NativeModule implements IDirect {


    @Override
    public String moduleId() {
        return "com.zkty.native.direct_omp";
    }

    @Override
    public int order() {
        return 0;
    }

    @Override
    public void afterAllNativeModuleInited() {

    }


    @Override
    public String scheme() {
        return "omp";
    }

    @Override
    public String protocol() {
        return "http:";
    }

    @Override
    public void push(String protocol, String host, String pathname, String fragment, Map<String, String> query, Map<String, String> params) {
        if (TextUtils.isEmpty(protocol)) {
            protocol = protocol();
        }
        Activity currentActivity = XEngineApplication.getCurrentActivity();

        boolean hideNavbar = params != null && params.containsKey("hideNavbar") && Boolean.parseBoolean(String.valueOf(params.get("hideNavbar")));
        XEngineWebActivityManager.sharedInstance().startXEngineActivity(currentActivity, protocol, host, pathname, fragment, query, hideNavbar);
    }

    @Override
    public void back(String host, String fragment) {
        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        if (mActivity == null) {
            return;
        }
        boolean isMinusHistory = Pattern.compile("^-\\d+$").matcher(fragment).matches();
        boolean isNamedHistory = Pattern.compile("^/\\w+$").matcher(fragment).matches();

        mActivity.runOnUiThread(() -> {
            if (TextUtils.isEmpty(fragment) || "-1".equals(fragment)) {
                mActivity.backUp();
            } else if ("0".equals(fragment)) {
                XEngineWebActivityManager.sharedInstance().exitAllXWebPage();
            } else if ("/".equals(fragment)) {
                XEngineWebActivityManager.sharedInstance().backToIndexPage();
            } else if (isMinusHistory) {// -2
                XEngineWebActivityManager.sharedInstance().backToHistoryPage(Integer.parseInt(fragment));
            } else if (isNamedHistory) {// /pageA
                XEngineWebActivityManager.sharedInstance().backToHistoryPage(fragment);
            } else {
                throw new XEngineException("fragment 格式错误");
            }
        });


    }


}
