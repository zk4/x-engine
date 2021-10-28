package com.zkty.nativ.jsi;

/**
 * @author : MaJi
 * @time : (10/22/21)
 * dexc :
 */
public class WebViewManager {

    private static WebViewManager mInstance;

    public static WebViewManager getInstance() {
        if (mInstance == null) {
            synchronized (WebViewManager.class) {
                if (mInstance == null) {
                    mInstance = new WebViewManager();
                }
            }
        }
        return mInstance;
    }

    private WebViewManagerImi webviewDelegate;

    /**
     * 设置webview的监听
     * @param webviewDelegate
     */
    public void setWebviewDelegate(WebViewManagerImi webviewDelegate){
        this.webviewDelegate = webviewDelegate;
    }

    /**
     * 获取管理器
     * @return
     */
    public WebViewManagerImi getWebViewManagerImi(){
        return webviewDelegate;
    }
    
    
}
