package com.zkty.modules.engine.core;

import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;


import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.exception.XEngineException;
import com.zkty.modules.engine.annotation.Optional;
import com.zkty.modules.engine.webview.XEngineWebView;


import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public abstract class xengine__module_BaseModule {
    protected xengine__module_BaseModule() {
    }

    protected abstract String moduleId();

    public void onAllModulesInited() {

        Log.d("BaseModule", "onAllModulesInited()");
    }

    protected int order() {
        return 0;
    }

    protected XEngineWebView mXEngineWebView;

    //反射赋值，勿删
    public void setXEngineWebView(XEngineWebView mXEngineWebView) {
        this.mXEngineWebView = mXEngineWebView;
    }


    protected <T> T convert(JSONObject object, Class<T> tClass) {
        Field[] fields = tClass.getDeclaredFields();
        StringBuilder builder = new StringBuilder();
        for (final Field field : fields) {
            Optional optionalAnnotation = field.getAnnotation(Optional.class);
            if (optionalAnnotation == null && !object.containsKey(field.getName())) {
                builder.append(field.getName()).append("、");
            }
        }
        if (!TextUtils.isEmpty(builder.toString())) {
            throw new XEngineException(String.format("参数 %s不能为空", builder.toString()));
        }

        return object.toJavaObject(tClass);
    }

    protected <T> T convert(String defaultJson, JSONObject object, Class<T> tClass) {
        if (TextUtils.isEmpty(defaultJson)) {
            return convert(object, tClass);
        }
        try {
            JSONObject defaultObj = JSON.parseObject(defaultJson);
            if (defaultObj != null) {
                for (String key : defaultObj.keySet()) {
                    if (!object.containsKey(key)) {
                        object.put(key, defaultObj.get(key));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return convert(object, tClass);

    }


    protected <T> void callInternalMethod(JSONObject obj, CompletionHandler<String> handler, String methodName, Class<T> tClass) {
        T t = convert(obj, tClass);
        Class<?> clazz = null;
        try {
            clazz = Class.forName(this.getClass().getCanonicalName().replaceFirst("xengine_", "__xengine_"));
            Object object = clazz.newInstance();
            Method method = clazz.getDeclaredMethod(methodName, tClass, CompletionHandler.class);
            method.setAccessible(true);
            method.invoke(object, t, handler);

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
    }


}
