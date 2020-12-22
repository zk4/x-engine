package com.zkty.modules.engine.webview;

import android.content.Context;
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
import com.tencent.smtt.sdk.WebSettings;
import com.tencent.smtt.sdk.WebView;
import com.tencent.smtt.sdk.WebViewClient;
import com.zkty.modules.dsbridge.DWebView;
import com.zkty.modules.engine.XEngineContext;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.exception.NoModuleIdException;
import com.zkty.modules.engine.utils.ImageUtils;
import com.zkty.modules.engine.utils.UrlUtils;
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

        saveImg();
    }


    private void loadLocalImg() {
        setWebViewClient(new WebViewClient() {
            @Override
            public WebResourceResponse shouldInterceptRequest(WebView webView, String s) {
                InputStream inputStream = Utils.getLocalImage(s);
                Log.d("Xenging-url", s);
                if (inputStream != null) {
                    WebResourceResponse resourceResponse = new WebResourceResponse();
                    resourceResponse.setData(inputStream);
                    return resourceResponse;
                }

                return super.shouldInterceptRequest(webView, s);
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


    //清缓存
    public void cleanCache() {
        clearAnimation();
        stopLoading();
//        setWebChromeClient(null);
//      setWebViewClient(null);
        clearCache(true);
        clearHistory();
        loadUrl("about:blank");
        historyCount = 0;

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
                goBackOrForward(-backForwardList.getCurrentIndex() + 1);
            } else {
                goBackOrForward(-backForwardList.getCurrentIndex());
            }
            historyCount = 1;
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
            if (UrlUtils.equalsWithoutArgs(getOriginalUrl(), url)) {
                break;
            }
            goBack();
        }
    }



    /**
     * webview复用模式。
     * 此字段代表wevbiew 的历史url数量
     * 每加载一次+1;
     * 仅用于微应用跳转间的回退，>0时暂不清理缓存以免出现白屏
     */
    private int historyCount = 0;
    private String currentUrl = null;

    @Override
    public void loadUrl(String url) {
        if (url.startsWith("/data")) url = "file://" + url;
        if (getOriginalUrl() != null && getOriginalUrl().equals(url)) {
            url = url.replaceAll("\\'", "");
            if (url.contains("?")) {
                url = url + "&timestamp=" + System.currentTimeMillis();
            } else {
                url = url + "?timestamp=" + System.currentTimeMillis();
            }

        }

        Log.d("DWebView", "url=" + url);
        super.loadUrl(url);
        this.currentUrl = url;
        historyCount++;

    }

    public void goBack() {
        super.goBack();
        historyCount--;

    }

    /**
     *
     */
    public void historyBack() {
        historyCount--;
    }

    public int getHistoryCount() {
        return this.historyCount;
    }

    public String getCurrentUrl() {
        return this.currentUrl;
    }

    private void saveImg() {

        setOnLongClickListener(view -> {
            HitTestResult result = getHitTestResult();
            switch (result.getType()) {

//                    case WebView.HitTestResult.SRC_IMAGE_ANCHOR_TYPE: // 带有链接的图片类型
                case HitTestResult.IMAGE_TYPE: // 处理长按图片的菜单项 base64类型

                    new Thread(() -> ImageUtils.savePicture(mContext, result.getExtra())).start();
                    break;

            }
            return false;
        });
    }

}
