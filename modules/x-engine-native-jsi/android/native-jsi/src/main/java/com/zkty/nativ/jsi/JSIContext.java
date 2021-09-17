package com.zkty.nativ.jsi;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.text.TextUtils;
import android.util.Log;

import com.tencent.smtt.export.external.TbsCoreSettings;
import com.tencent.smtt.sdk.QbSdk;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.MicroAppsInstall;
import com.zkty.nativ.jsi.webview.XWebViewPool;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JSIContext extends NativeModule {
    private List<Class> moduleClasses;
    private List<JSIModule> modules;
    private String TAG = JSIContext.class.getSimpleName();

    @Override
    public String moduleId() {
        return "com.zkty.native.jsicontext";
    }


    public JSIContext() {
        moduleClasses = new ArrayList<>();
        modules = new ArrayList<>();
        instance = this;
    }

    private static volatile JSIContext instance = null;

    public static JSIContext sharedInstance() {
        if (instance == null) {
            synchronized (NativeContext.class) {
                if (instance == null) {
                    instance = new JSIContext();
                }
            }
        }
        return instance;
    }

    public void init() {
        initJSIForQuick(XEngineApplication.getApplication());
        initModules();
        initWebView();
        MicroAppsInstall.sharedInstance().init(XEngineApplication.getApplication());
        for (JSIModule module : modules) {
            module.afterAllJSIModuleInited();
        }
    }

    private void initWebView() {
        // 设置开启优化方案
        // 在调用TBS初始化、创建WebView之前进行如下配置
        QbSdk.setDownloadWithoutWifi(true);
        Map<String, Object> map = new HashMap<>();
        map.put(TbsCoreSettings.TBS_SETTINGS_USE_SPEEDY_CLASSLOADER, true);
        map.put(TbsCoreSettings.TBS_SETTINGS_USE_DEXLOADER_SERVICE, true);
        QbSdk.initTbsSettings(map);

        XWebViewPool.sharedInstance().init(XEngineApplication.getApplication());
////        MicroAppsInstall.sharedInstance().init(XEngineApplication.getApplication());

        QbSdk.initX5Environment(XEngineApplication.getApplication(), new QbSdk.PreInitCallback() {
            @Override
            public void onCoreInitFinished() {
                Log.d("initX5", "onCoreInitFinished");
            }

            @Override
            public void onViewInitFinished(boolean b) {
                Log.d("initX5", "onViewInitFinished: " + b);
            }
        });

    }

    @Override
    public void afterAllNativeModuleInited() {
        init();
    }

    public List<JSIModule> modules() {
        return this.modules;
    }

    private void initModules() {
        for (Class clazz : moduleClasses) {
            try {
                JSIModule module = (JSIModule) clazz.newInstance();
                String moduleId = module.moduleId();
                this.modules.add(module);
                Log.d(TAG, String.format("jsi moudle found: %s", moduleId));
            } catch (IllegalAccessException | InstantiationException e) {
                e.printStackTrace();
            }
        }
        //排序？


    }

    /**
     * 快速注册模块实现
     *
     * @param context
     */
    private void initJSIForQuick(Context context) {

        long start = System.currentTimeMillis();
        try {
            ApplicationInfo appInfo = context.getPackageManager().getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
            if (appInfo.metaData != null) {
                for (String key : appInfo.metaData.keySet()) {
                    if (!TextUtils.isEmpty(key) && key.startsWith("com.zkty.jsi")) {
                        String value = appInfo.metaData.getString(key);
                        Log.d(TAG, "Id:" + key + "----" + "Class:" + value);
                        if (!TextUtils.isEmpty(value) && value.startsWith("com.zkty.jsi")) {      //过滤
                            try {
                                Class c = Class.forName(value);
                                moduleClasses.add(c);
                            } catch (ClassNotFoundException e) {
                                e.printStackTrace();
                            }

                        }
                    }
                }
            }
            Log.d(TAG, String.format("注册模块耗时 %d ms, 加载模块个数 %d 个", System.currentTimeMillis() - start, moduleClasses.size()));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
