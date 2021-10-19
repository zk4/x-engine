package com.zkty.nativ.webcache;

import android.content.Context;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.utils.IApplicationListener;
import com.zkty.nativ.webcache.lib.CacheType;
import com.zkty.nativ.webcache.lib.ResourceInterceptor;
import com.zkty.nativ.webcache.lib.WebViewCacheInterceptor;
import com.zkty.nativ.webcache.lib.WebViewCacheInterceptorInst;
import com.zkty.nativ.webcache.lib.config.CacheExtensionConfig;

import java.io.File;

public class Nativewebcache extends NativeModule implements Iwebcache, IApplicationListener {

    @Override
    public String moduleId() {
        return "com.zkty.native.webcache";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public void onAppCreate(Context context) {

        WebViewCacheInterceptor.Builder builder = new WebViewCacheInterceptor.Builder(context);

        //设置okhttp缓存路径，默认getCacheDir，名称CacheWebViewCache
        builder.setCachePath(new File(context.getCacheDir(), "normal_web_cache"))
                .setDynamicCachePath(new File(context.getCacheDir(), "dynamic_web_cache"))
                .setCacheSize(1024 * 1024 * 2000)//设置缓存大小，默认200M
                .setConnectTimeoutSecond(20)//设置http请求链接超时，默认20秒
                .setReadTimeoutSecond(20)//设置http请求链接读取超时，默认20秒
                .setCacheExtensionConfig(new CacheExtensionConfig())
                .setCacheType(CacheType.FORCE)
                //.setAssetsDir("static");
                //.isAssetsSuffixMod(true);
                .setDebug(true)
                .setResourceInterceptor(new ResourceInterceptor() {
                    @Override
                    public boolean interceptor(String url) {
                        return true;
                    }
                });

        WebViewCacheInterceptorInst.getInstance().
                init(builder);


    }

    @Override
    public void onTerminate() {

    }
}
