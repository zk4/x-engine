package com.zkty.modules.nativ.jsi.view;


import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.nativ.jsi.bridge.CompletionHandler;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;

public class SchemeManager {
    private String TAG = SchemeManager.class.getSimpleName();

    private SchemeManager() {
    }

    private static volatile SchemeManager instance = null;

    public static SchemeManager sharedInstance() {
        if (instance == null) {
            synchronized (SchemeManager.class) {
                if (instance == null) {
                    instance = new SchemeManager();
                }
            }
        }
        return instance;
    }

    public void invoke(String module, String methodName, JSONObject jsonObject, CompletionHandler completionHandler) {
        //module 支持模块名或moduleId;
        if (!TextUtils.isEmpty(module) && module.startsWith("com.zkty.module.")) {
            module = module.replace("com.zkty.module.", "");
        }
        String moduleName = "com.zkty.modules.loaded.jsapi.xengine__module_" + module;
        String moduleImplName = "com.zkty.modules.loaded.jsapi.__xengine__module_" + module;
        try {
            Class<?> classModule = Class.forName(moduleName);
            Class<?> classModuleImpl = Class.forName(moduleImplName);
            Constructor<?> constructor = classModuleImpl.getDeclaredConstructor();
            constructor.setAccessible(true);
            Object object = constructor.newInstance();
            Method methodModule = classModule.getMethod(methodName, JSONObject.class, CompletionHandler.class);

            methodModule.invoke(object, jsonObject, completionHandler);


        } catch (Exception e) {
            Log.d(TAG, e.toString());
        }


    }

}
