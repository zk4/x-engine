package com.zkty.nativ.direct_omp;

import android.app.Activity;
import android.os.Handler;
import android.text.TextUtils;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.direct.IDirect;
import com.zkty.nativ.jsi.exception.XEngineException;
import com.zkty.nativ.jsi.utils.KeyBoardUtils;
import com.zkty.nativ.jsi.view.XEngineWebActivity;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.jsi.webview.XWebViewPool;
import com.zkty.nativ.store.IStore;
import com.zkty.nativ.store.NativeStore;

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

        XEngineWebView xEngineWebView = XWebViewPool.sharedInstance().getCurrentWebView();
        if (TextUtils.isEmpty(host) && xEngineWebView != null) {

            host = xEngineWebView.getHistoryModel().host;
            pathname = xEngineWebView.getHistoryModel().pathname;
        }


        boolean hideNavbar = params != null && params.containsKey("hideNavbar") && Boolean.parseBoolean(String.valueOf(params.get("hideNavbar")));
        if (params != null && params.containsKey("nativeParams")) {
            NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IStore.class);
            NativeStore iStore = null;
            if (module instanceof NativeStore) {
                iStore = (NativeStore) module;
                iStore.set("__native__params__", params.get("nativeParams"));
            }
        }
        Activity mActivity = XEngineApplication.getCurrentActivity();

        if (mActivity instanceof XEngineWebActivity && KeyBoardUtils.isSoftKeyboardShowed(mActivity)) {
            ((XEngineWebActivity) mActivity).closeKeyboard();
            String finalPathname = pathname;
            String finalHost = host;
            String finalProtocol = protocol;
            new Handler().postDelayed(() -> {
                XEngineWebActivityManager.sharedInstance().startXEngineActivity(mActivity, finalProtocol, finalHost, finalPathname, fragment, query, hideNavbar);
            }, 100);

        } else {
            XEngineWebActivityManager.sharedInstance().startXEngineActivity(mActivity, protocol, host, pathname, fragment, query, hideNavbar);

        }
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
