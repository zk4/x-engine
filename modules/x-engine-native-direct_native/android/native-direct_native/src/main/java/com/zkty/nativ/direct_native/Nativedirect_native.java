package com.zkty.nativ.direct_native;

import android.content.Context;

import com.alibaba.android.arouter.facade.Postcard;
import com.alibaba.android.arouter.launcher.ARouter;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.IApplicationListener;
import com.zkty.nativ.direct.IDirect;

import java.util.Map;

import nativ.direct_native.BuildConfig;

public class Nativedirect_native extends NativeModule implements IDirect, IApplicationListener {

    @Override
    public void onAppCreate(Context context) {

    }

    @Override
    public void onTerminate() {
        ARouter.getInstance().destroy();

    }

    @Override
    public String moduleId() {
        return "com.zkty.native.direct_native";
    }

    @Override
    public void afterAllNativeModuleInited() {
        if (!"release".equals(BuildConfig.BUILD_TYPE)) {           // 这两行必须写在init之前，否则这些配置在init过程中将无效
            ARouter.openLog();     // 打印日志
            ARouter.openDebug();   // 开启调试模式(如果在InstantRun模式下运行，必须开启调试模式！线上版本需要关闭,否则有安全风险)
        }
        ARouter.init(XEngineApplication.getApplication()); // 尽可能早，推荐在Application中初始化


    }

    @Override
    public String scheme() {
        return "native";
    }

    @Override
    public String protocol() {
        return "native:";
    }

    @Override
    public void push(String protocol, String host, String pathname, String fragment, Map<String, String> query, Map<String, String> params) {
        Postcard postcard = ARouter.getInstance().build(pathname);
        for (Map.Entry<String, String> entry : query.entrySet()) {
            postcard.withString(entry.getKey(), entry.getValue());
        }
        postcard.navigation();

    }

    @Override
    public void back(String host, String fragment) {

    }
}
