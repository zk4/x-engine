package com.zkty.modules.engine.manager;


import android.util.Log;

import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;

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

    public void invoke(String module, String methodName, JSONObject jsonObject) {

        String moduleName = "com.zkty.modules.loaded.jsapi.xengine__module_" + module;
        String moduleImplName = "com.zkty.modules.loaded.jsapi.__xengine__module_" + module;
        try {
            Class<?> classModule = Class.forName(moduleName);
            Class<?> classModuleImpl = Class.forName(moduleImplName);
            Constructor<?> constructor = classModuleImpl.getDeclaredConstructor();
            constructor.setAccessible(true);
            Object object = constructor.newInstance();
            Method methodModule = classModule.getMethod(methodName, JSONObject.class, CompletionHandler.class);
            CompletionHandler completionHandler = new CompletionHandler() {
                @Override
                public void complete(Object retValue) {

                }

                @Override
                public void complete() {

                }

                @Override
                public void setProgressData(Object value) {

                }
            };
            methodModule.invoke(object, jsonObject, completionHandler);


        } catch (Exception e) {
            Log.d(TAG, e.toString());
        }


    }

}
