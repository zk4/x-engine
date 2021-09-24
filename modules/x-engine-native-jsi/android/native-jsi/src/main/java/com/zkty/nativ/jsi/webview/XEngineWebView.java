package com.zkty.nativ.jsi.webview;

import android.content.Context;
import android.os.Handler;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.view.ViewGroup;
import android.widget.LinearLayout;

import com.tencent.smtt.export.external.interfaces.WebResourceRequest;
import com.tencent.smtt.export.external.interfaces.WebResourceResponse;
import com.tencent.smtt.sdk.WebSettings;
import com.tencent.smtt.sdk.WebView;
import com.tencent.smtt.sdk.WebViewClient;
import com.zkty.nativ.core.utils.ImageUtils;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.JSIContext;
import com.zkty.nativ.jsi.JSIModule;
import com.zkty.nativ.jsi.bridge.DWebView;
import com.zkty.nativ.jsi.bridge.WebResourceRequestAdapter;
import com.zkty.nativ.jsi.bridge.WebResourceResponseAdapter;
import com.zkty.nativ.jsi.utils.UrlUtils;
import com.zkty.nativ.jsi.view.MicroAppLoader;
import com.zkty.nativ.jsi.view.PermissionDto;
import com.zkty.nativ.webcache.lib.WebViewCacheInterceptorInst;

import java.util.ArrayList;
import java.util.List;

import nativ.jsi.BuildConfig;


public class XEngineWebView extends DWebView {
    private Context mContext;
    private String TAG = XEngineWebView.class.getSimpleName();

    //自定义webview 历史记录
    private List<HistoryModel> historyModels;
    private HistoryModel historyModel;

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
        historyModels = new ArrayList<>();
        getSettings().setJavaScriptEnabled(true);
        if (getX5WebViewExtension() != null) {
            getX5WebViewExtension().setHorizontalScrollBarEnabled(false);
            getX5WebViewExtension().setVerticalScrollBarEnabled(false);
        } else {
            setHorizontalScrollBarEnabled(false);
            setVerticalScrollBarEnabled(false);
        }
        getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);  //设置 缓存模式(true);
        getSettings().setAppCacheEnabled(true);
        getSettings().setAppCacheMaxSize(Long.MAX_VALUE);
        getSettings().setAppCachePath(mContext.getDir("appcache", 0).getPath());
        getSettings().setDatabasePath(mContext.getDir("databases", 0).getPath());
        getSettings().setSupportZoom(false);
        getSettings().setUseWideViewPort(true);
        getSettings().setJavaScriptCanOpenWindowsAutomatically(true);
        getSettings().setAllowFileAccess(true);
        // 设置是否允许通过 file url 加载的 Javascript 可以访问其他的源(包括http、https等源)
        getSettings().setAllowUniversalAccessFromFileURLs(true);
        getSettings().setAllowContentAccess(true);
        getSettings().setDomStorageEnabled(true);
        getSettings().setDatabaseEnabled(true);
        setWebContentsDebuggingEnabled(!"release".equals(BuildConfig.BUILD_TYPE));
        ViewGroup.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT);
        setLayoutParams(params);
        addJavascript();

        setWebViewClient();
        // setErrorPage();
        //屏蔽长按图片保存功能
//        setOnLongClickListener();
    }


    private void setWebViewClient() {
        setWebViewClient(new WebViewClient() {

            @Override
            public void onPageFinished(WebView webView, String s) {
                evaluateJavascript("window._dswk=true;");
                super.onPageFinished(webView, s);
                if (onPageStateListener != null) {
                    onPageStateListener.onPageFinished();
                }
            }

//            @Override
//            public boolean shouldOverrideUrlLoading(WebView webView, String s) {
//                Log.d("CacheWebView", "request url= " + s.replace("http://",""));
//
//                if (Build.VERSION.SDK_INT < 26) {
//                    webView.loadUrl(s);
//                    return true;
//                }
//                return false;
//            }

            @Override
            public WebResourceResponse shouldInterceptRequest(WebView webView, String s) {
                Log.d("CacheWebView", "shouldInterceptRequest url= " + s.replace("http://",""));
                return WebResourceResponseAdapter.adapter(WebViewCacheInterceptorInst.getInstance().
                        interceptRequest(s));
            }


            @Override
            public WebResourceResponse shouldInterceptRequest(WebView webView, WebResourceRequest webResourceRequest) {
                return WebResourceResponseAdapter.adapter(WebViewCacheInterceptorInst.getInstance().
                        interceptRequest(WebResourceRequestAdapter.adapter(webResourceRequest)));
            }

        });
    }


    private void addJavascript() {
        List<JSIModule> modules = JSIContext.sharedInstance().modules();
        for (JSIModule object : modules) {
            String tag = object.moduleId();
            object.setEngineWebView(this);
            addJavascriptObject(object, tag);
        }

    }


    //清缓存
    public void cleanCache() {
        clearAnimation();
        stopLoading();
//        setWebChromeClient(null);
//      setWebViewClient(null);
//        clearCache(true);
//        clearHistory();
//        loadUrl("about:blank");
//        this.destroy();

    }




    public void goBack() {
        super.goBack();
        if (historyModels.size() > 1) {
            historyModels.remove(historyModels.size() - 1);
        } else {
            historyModels.clear();
            XWebViewPool.sharedInstance().removeWebView(this);
        }
    }


    public void loadUrl(HistoryModel model) {
        evaluateJavascript("window._dswk=true;");
        String url = getUrlByHistoryModel(model);
        loadUrl(url);
        historyModels.add(model);
        this.historyModel = model;
    }

    public List<HistoryModel> getHistoryModels() {
        return this.historyModels;
    }

    @Override
    public void loadUrl(String url) {
        if (url.startsWith("/data")) url = "file://" + url;
        Log.d("DWebView", "url=" + url);
        super.loadUrl(url);


    }


    private void setOnLongClickListener() {

        setOnLongClickListener(view -> {
            HitTestResult result = getHitTestResult();
            switch (result.getType()) {

//                    case WebView.HitTestResult.SRC_IMAGE_ANCHOR_TYPE: // 带有链接的图片类型
                case HitTestResult.IMAGE_TYPE: // 处理长按图片的菜单项  base64类型
//                    new Thread(() -> {
                    if (result != null && result.getExtra() != null) {
                        if (result.getExtra().toLowerCase().startsWith("http")) {
                            ImageUtils.savePictureByUrl(mContext, result.getExtra());
                        } else {
                            ImageUtils.savePictureByBase64(mContext, result.getExtra());
                        }
                    }
//                    }).start();
                    break;
            }
            return false;
        });
    }

    int speed = 120;

    public void smoothScrollToTop(int scrollY) {

        if (scrollY < 1) return;
        if (scrollY < speed) {
            if (getX5WebViewExtension() != null) {
                getX5WebViewExtension().scrollTo(0, 0);
            } else {
                scrollTo(0, 0);
            }
            return;
        }
        if (getX5WebViewExtension() != null) {
            getX5WebViewExtension().scrollTo(0, scrollY - speed);
        } else {
            scrollTo(0, scrollY - speed);
        }

        new Handler().postDelayed(() -> smoothScrollToTop(scrollY - speed), 5);


    }

    public interface OnPageStateListener {
        void onPageFinished();

    }

    public interface OnScrollListener {
        void onScrollChange(int scrollX, int scrollY, int oldScrollX, int oldScrollY);
    }

    private OnScrollListener mScrollListener;
    private OnPageStateListener onPageStateListener;


    public void setOnScrollListener(OnScrollListener listener) {
        this.mScrollListener = listener;
    }

    public void setOnPageStateListener(OnPageStateListener listener) {
        this.onPageStateListener = listener;
    }

    public OnScrollListener getScrollListener() {
        return this.mScrollListener;
    }

    @Override
    protected void onScrollChanged(int l, int t, int oldl, int oldt) {
        super.onScrollChanged(l, t, oldl, oldt);
        if (mScrollListener != null) {
            mScrollListener.onScrollChange(l, t, oldl, oldt);
        }
    }

    private PermissionDto mPermission;

    public void setPermission(PermissionDto mPermission) {
        this.mPermission = mPermission;
    }

    public PermissionDto getPermission() {
        return this.mPermission;
    }

    private String getUrlByHistoryModel(HistoryModel model) {
        StringBuilder sb = new StringBuilder();
        String hostR = model.host;
        if ("file:".equals(model.protocol)) {
            hostR = MicroAppLoader.sharedInstance().getMicroAppUrl(model.host);
        }


        sb.append(model.protocol).append("//").append(TextUtils.isEmpty(hostR) ? "" : hostR);
        if (!TextUtils.isEmpty(model.pathname) && !model.pathname.equals("/")) {
            sb.append(model.pathname);
        }
        if (!TextUtils.isEmpty(model.fragment)) {
            sb.append("#").append(model.fragment);
        }

        String query = UrlUtils.getQueryStringFormMap(model.query);
        if (!TextUtils.isEmpty(query)) {
            sb.append("?").append(query);
        }

        return sb.toString();
    }

    public HistoryModel getHistoryModel() {
        return this.historyModel;
    }

}
