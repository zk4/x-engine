package com.zkty.nativ.jsi.view;


import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSONObject;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.jsi.exception.XEngineException;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
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

//    public void invoke(String module, String methodName, JSONObject jsonObject, CompletionHandler completionHandler) {
//        //module 支持模块名或moduleId;
//        if (!TextUtils.isEmpty(module) && module.startsWith("com.zkty.module.")) {
//            module = module.replace("com.zkty.module.", "");
//        }
//        String moduleName = "com.zkty.modules.loaded.jsapi.xengine__module_" + module;
//        String moduleImplName = "com.zkty.modules.loaded.jsapi.__xengine__module_" + module;
//        try {
//            Class<?> classModule = Class.forName(moduleName);
//            Class<?> classModuleImpl = Class.forName(moduleImplName);
//            Constructor<?> constructor = classModuleImpl.getDeclaredConstructor();
//            constructor.setAccessible(true);
//            Object object = constructor.newInstance();
//            Method methodModule = classModule.getMethod(methodName, JSONObject.class, CompletionHandler.class);
//
//            methodModule.invoke(object, jsonObject, completionHandler);
//
//
//        } catch (Exception e) {
//            Log.d(TAG, e.toString());
//        }
//
//
//    }

    public void invoke(String module, String methodName, JSONObject jsonObject, CompletionHandler completionHandler) {
        //module 支持模块名或moduleId;
        if (!TextUtils.isEmpty(module) && module.startsWith("com.zkty.module.")) {
            module = module.replace("com.zkty.module.", "");
        }
        if (!TextUtils.isEmpty(module) && module.startsWith("com.zkty.jsi.")) {
            module = module.replace("com.zkty.jsi.", "");
        }
        String moduleName = "com.zkty.jsi.xengine_jsi_" + module;
        String moduleImplName = "com.zkty.jsi.JSI_" + module;
        try {
            Class<?> classModule = Class.forName(moduleName);
            Class<?> classModuleImpl = Class.forName(moduleImplName);
            Constructor<?> constructor = classModuleImpl.getDeclaredConstructor();
            constructor.setAccessible(true);
            Object object = constructor.newInstance();
            Method methodModule = classModule.getMethod(methodName, JSONObject.class, CompletionHandler.class);
            methodModule.invoke(object, jsonObject, completionHandler);

        } catch (Exception e) {
            if (e instanceof XEngineException) {
                throw new XEngineException(e.getMessage());
            } else if (e instanceof InvocationTargetException) {
                if (((InvocationTargetException) e).getTargetException() instanceof XEngineException) {
                    throw new XEngineException(((InvocationTargetException) e).getTargetException().getMessage());
                }

            }
            Log.d(TAG, e.toString());
        }


    }

}
