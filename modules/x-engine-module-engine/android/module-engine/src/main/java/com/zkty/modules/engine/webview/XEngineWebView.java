package com.zkty.modules.engine.webview;

import android.content.Context;
import android.os.Build;
import android.provider.Settings;
import android.util.AttributeSet;
import android.util.Log;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import com.tencent.smtt.export.external.interfaces.WebResourceError;
import com.tencent.smtt.export.external.interfaces.WebResourceRequest;
import com.tencent.smtt.export.external.interfaces.WebResourceResponse;
import com.tencent.smtt.sdk.WebBackForwardList;
import com.tencent.smtt.sdk.WebHistoryItem;
import com.tencent.smtt.sdk.WebSettings;
import com.tencent.smtt.sdk.WebView;
import com.tencent.smtt.sdk.WebViewClient;
import com.zkty.modules.dsbridge.DWebView;
import com.zkty.modules.engine.XEngineContext;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.exception.NoModuleIdException;
import com.zkty.modules.engine.utils.Utils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.util.List;

import module.engine.R;


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

         loadLocalImg();
        // setErrorPage();
    }

    private void loadLocalImg() {
        setWebViewClient(new WebViewClient() {
            @Override
            public WebResourceResponse shouldInterceptRequest(WebView webView, String s) {
                InputStream inputStream = Utils.getLocalImage(s);
                if (inputStream != null) {
                    WebResourceResponse resourceResponse = new WebResourceResponse();
                    resourceResponse.setData(inputStream);
                    return resourceResponse;
                }
                return super.shouldInterceptRequest(webView, s);
            }

            @Override
            public boolean shouldOverrideUrlLoading(WebView webView, String s) {
                if (Build.VERSION.SDK_INT < 26) {
                    webView.loadUrl(s);
                    return true;
                }
                return false;
            }
        });
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
//        setWebChromeClient(null);
//      setWebViewClient(null);
        clearCache(true);
        clearHistory();
        loadUrl("about:blank");

    }

    //回微应用首页
    public void goBackToIndexPage() {
        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        if (activity != null) {
            activity.showScreenCapture(true);
            ViewGroup parent = (ViewGroup) getParent();
            if (parent != null) {
                parent.removeAllViews();
            }
        }
        WebBackForwardList backForwardList = copyBackForwardList();
        if (backForwardList != null && backForwardList.getSize() != 0) {
            if ("about:blank".equals(backForwardList.getItemAtIndex(0).getOriginalUrl())) {
                goBackOrForward(-backForwardList.getSize() + 2);
            } else {
                goBackOrForward(-backForwardList.getSize() + 1);
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


    public void setErrorPage() {

        setWebViewClient(new WebViewClient() {


            @Override
            public void onReceivedError(WebView webView, WebResourceRequest webResourceRequest, WebResourceError webResourceError) {
                super.onReceivedError(webView, webResourceRequest, webResourceError);

                if (webResourceRequest.isForMainFrame()) {
                    webView.loadUrl("about:blank");
                    setErrorImg(webView);
                }
            }

            @Override
            public void onReceivedHttpError(WebView webView, WebResourceRequest webResourceRequest, WebResourceResponse webResourceResponse) {
                super.onReceivedHttpError(webView, webResourceRequest, webResourceResponse);
                int stateCode = webResourceResponse.getStatusCode();
                if (stateCode >= 400) {
                    webView.loadUrl("about:blank");
                    setErrorImg(webView);
                }

            }
        });

    }

    private void setErrorImg(WebView webView) {

        RelativeLayout layout = new RelativeLayout(mContext);
        View view = LayoutInflater.from(mContext).inflate(R.layout.layout_error_page, null);
        layout.addView(view);
        layout.setGravity(Gravity.CENTER);
        RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
        lp.addRule(RelativeLayout.CENTER_IN_PARENT);
        if (webView.getParent() != null && webView.getParent() instanceof RelativeLayout) {
            ((RelativeLayout) webView.getParent()).removeAllViews();
            ((RelativeLayout) webView.getParent()).addView(layout, lp);
        }
    }
}
