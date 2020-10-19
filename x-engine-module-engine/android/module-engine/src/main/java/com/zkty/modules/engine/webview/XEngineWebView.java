package com.zkty.modules.engine.webview;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.tencent.smtt.sdk.WebBackForwardList;
import com.tencent.smtt.sdk.WebHistoryItem;
import com.tencent.smtt.sdk.WebSettings;
import com.zkty.modules.dsbridge.DWebView;
import com.zkty.modules.engine.XEngineContext;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.exception.NoModuleIdException;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.util.List;


public class XEngineWebView extends DWebView {
    private Context mContext;

    public XEngineWebView(Context context) {
        super(context);
        this.mContext = context;
        init();
    }

    public XEngineWebView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.mContext = context;
        init();
    }

    public void init() {
        getSettings().setJavaScriptEnabled(true);
        getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);  //设置 缓存模式(true);
        getSettings().setAppCacheEnabled(false);
        getSettings().setSupportZoom(false);
        getSettings().setUseWideViewPort(true);
        getSettings().setJavaScriptCanOpenWindowsAutomatically(true);
        getSettings().setAllowFileAccess(true);
        getSettings().setAllowContentAccess(true);
        getSettings().setDomStorageEnabled(true);
        ViewGroup.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT);
        setLayoutParams(params);
        addJavascript();
    }


    private void addJavascript() {
        List<String> modules = XEngineContext.getModules();
        for (String module : modules) {
            try {
                Class<?> classModule = Class.forName(module);
                Constructor<?> constructor = classModule.getDeclaredConstructor();
                constructor.setAccessible(true);
                Object object = constructor.newInstance();
                Method methodModule = classModule.getMethod("moduleId");
                methodModule.setAccessible(true);
                String tag = (String) methodModule.invoke(object);
                try {
                    Method setXEngineWebView = classModule.getMethod("setXEngineWebView", XEngineWebView.class);
                    setXEngineWebView.setAccessible(true);
                    setXEngineWebView.invoke(object, this);
                } catch (Exception e) {
                    Log.d("ZKWebView", e.toString());
                }
                if (tag == null) {
                    throw new NoModuleIdException("module: " + module + " moduleId cannot be null");
                } else {
                    addJavascriptObject(object, tag);
                    Log.d("ZKWebView", "module_id = " + tag);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

        }

    }

    /**
     * 回退
     */
    public void backUp() {
        if (XOneWebViewPool.IS_SINGLE) {
            XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
            activity.showScreenCapture(true);
            ViewGroup parent = (ViewGroup) getParent();
            if (parent != null) {
                parent.removeAllViews();
            }
        }

        if (canGoBack()) {
            goBack();
        }
    }

    //预加载
    public void preLoad(String url) {
        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        if (activity != null) {
            activity.showScreenCapture(true);
        }
        ViewGroup parent = (ViewGroup) getParent();
        if (parent != null) {
            parent.removeView(this);
        }
        loadUrl(url);

    }

    //清缓存
    public void cleanCache() {
        clearAnimation();
        stopLoading();
        setWebChromeClient(null);
//      setWebViewClient(null);
        clearCache(true);
        clearHistory();
        loadUrl("about:blank");

    }

    //回微应用首页
    public void goBackToIndexPage() {
        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        activity.showScreenCapture(true);

        ViewGroup parent = (ViewGroup) getParent();
        if (parent != null) {
            parent.removeAllViews();
        }
        while (canGoBack()) {
            WebBackForwardList backForwardList = copyBackForwardList();
            if (backForwardList != null && backForwardList.getSize() != 0) {
                int currentIndex = backForwardList.getCurrentIndex();
                WebHistoryItem historyItem =
                        backForwardList.getItemAtIndex(currentIndex - 1);
                if (historyItem != null) {
                    String backPageUrl = historyItem.getOriginalUrl();
                    if (canGoBack() && !"about:blank".equals(backPageUrl)) {//，可返回,非空白
                        goBack();
                    } else {
                        return;
                    }
                }
            }
        }
    }

    //回指定页面
    public void backToPage(String url) {
        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        activity.showScreenCapture(true);
        ViewGroup parent = (ViewGroup) getParent();
        if (parent != null) {
            parent.removeAllViews();
        }
        while (canGoBack()) {
            if (getOriginalUrl().contains(url)) {
                break;
            }
            goBack();
        }
    }
}
