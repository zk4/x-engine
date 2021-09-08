package com.zkty.nativ.jsi.webview;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.util.Log;
import android.view.ViewGroup;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.LinearLayout;

import com.alibaba.fastjson.JSONObject;
import com.anthonynsimon.url.URL;
import com.zkty.nativ.core.utils.ImageUtils;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.core.utils.Utils;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.JSIContext;
import com.zkty.nativ.jsi.JSIModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.jsi.bridge.DWebView;
import com.zkty.nativ.jsi.exception.XEngineException;
import com.zkty.nativ.jsi.utils.UrlUtils;
import com.zkty.nativ.jsi.view.MicroAppLoader;
import com.zkty.nativ.jsi.view.PermissionDto;
import com.zkty.nativ.jsi.view.SchemeManager;

import java.lang.reflect.InvocationTargetException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

        setHorizontalScrollBarEnabled(false);
        setVerticalScrollBarEnabled(false);

        getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);  //设置 缓存模式(true);
        getSettings().setAppCacheEnabled(false);
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

            @Override
            public boolean shouldOverrideUrlLoading(WebView webView, String s) {
                Log.d(TAG, "response url= " + s);

                if (s.contains("tenpay")) {

                    Map<String, String> webviewHead = new HashMap<>();
                    webviewHead.put("referer", "http://linli580.com");
                    webView.loadUrl(s, webviewHead);
                    return true;
                }
                if (s.startsWith("weixin://")) {
                    Intent intent = new Intent();
                    intent.setAction(Intent.ACTION_VIEW);
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
                    intent.setData(Uri.parse(s));
                    mContext.startActivity(intent);
                    return true;
                }
                if (s.startsWith("alipay://") || s.startsWith("alipays://")) {
                    if (Utils.checkAliPayInstalled(mContext)) {
                        Intent intent = new Intent();
                        intent.setAction(Intent.ACTION_VIEW);
                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
                        intent.setData(Uri.parse(s));
                        mContext.startActivity(intent);
                    } else {
                        ToastUtils.showNormalShortToast("请下载支付宝客户端");
                    }
                    return true;
                }
                if (s.startsWith("x-engine-json://") || s.startsWith("x-engine-call://")) {

                    try {
//                        String sss = "x-engine://share/share?title=title1&desc=desc1&link=link1&imageUrl=imageUrl1&type=wx&dataUrl=dataUrl1";
                        URL base = URL.parse(s);

                        String moduleName = base.getHost();
                        String method = base.getPath().replace("/", "");


                        Map<String, Collection<String>> params = base.getQueryPairs();
                        String args = null;
                        String callback = null;
                        if (params != null && params.size() > 0) {

                            if (params.containsKey("args") && params.get("args") != null && params.get("args").size() > 0) {
                                args = (String) params.get("args").toArray()[0];
                            }

                            if (params.containsKey("callback") && params.get("callback") != null && params.get("callback").size() > 0) {
                                callback = (String) params.get("callback").toArray()[0];

                            }
                        }

                        if (callback != null) {
                            callback = URLDecoder.decode(callback);
                        }

                        final String callbackUrl = callback;


                        JSONObject jsonObject = JSONObject.parseObject(URLDecoder.decode(args));

                        CompletionHandler completionHandler = new CompletionHandler() {
                            @Override
                            public void complete(Object retValue) {
                                String callbackTemp = callbackUrl;
                                if (!TextUtils.isEmpty(callbackTemp)) {
                                    final String callbackTemp2 = callbackTemp.replaceAll("\\{ret\\}", URLEncoder.encode(JSONObject.toJSONString(retValue)));
                                    Handler handler = new Handler(Looper.getMainLooper());
                                    handler.post(() -> webView.loadUrl(callbackTemp2));
                                }
                            }

                            @Override
                            public void complete() {
                            }

                            @Override
                            public void setProgressData(Object value) {
                            }
                        };

                        SchemeManager.sharedInstance().invoke(moduleName, method, jsonObject, completionHandler);

                    } catch (Exception e) {
                        e.printStackTrace();
                        if (isDebug) {
                            if (e instanceof XEngineException) {
                                PrintDebugInfo(e.getMessage());
                            } else if (e instanceof InvocationTargetException) {
                                if (((InvocationTargetException) e).getTargetException() instanceof XEngineException) {
                                    PrintDebugInfo(((InvocationTargetException) e).getTargetException().getMessage());
                                }

                            }
                        }
                    }

                    return true;
                }

                if (Build.VERSION.SDK_INT < 26) {
                    webView.loadUrl(s);
                    return true;
                }
                return false;
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
        clearHistory();
//        loadUrl("about:blank");
//        this.destroy();

    }

    //回微应用首页
//    public void goBackToIndexPage() {
//        XEngineWebView webView = XOneWebViewPool.sharedInstance().getFirstWebView();
//        if (webView == null) return;
//
//        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
//        activity.showScreenCapture(true);
//
//        if (webView.getHistoryModels().size() > 1) {
//            webView.getHistoryModels().subList(0, 1);
//            String url = getUrlByHistoryModel(webView.getHistoryModels().get(0));
//            webView.loadUrl(url);
//        } else {
//            throw new XEngineException("当前已是微应用首页");
//        }
//
//
//    }

    //回指定页面
//    public void backToPage(String host, String fragment) {
//
//        XEngineWebView webView = XOneWebViewPool.sharedInstance().getWebViewFromPool(host);
//        if (webView == null) return;
//
//        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
//        activity.showScreenCapture(true);
//
//        ViewGroup parent = (ViewGroup) webView.getParent();
//        if (parent != null) {
//            parent.removeAllViews();
//        }
//
//
//
//    }

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
//        if (getOriginalUrl() != null && getOriginalUrl().equals(url)) {
//            url = url.replaceAll("\\'", "");
//            if (url.contains("?")) {
//                url = url + "&timestamp=" + System.currentTimeMillis();
//            } else {
//                url = url + "?timestamp=" + System.currentTimeMillis();
//            }
//
//        }

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

        scrollTo(0, scrollY - speed);


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
