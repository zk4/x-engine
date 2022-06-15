package com.zkty.nativ.jsi;

import android.text.TextUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zkty.nativ.core.annotation.Optional;
import com.zkty.nativ.jsi.bridge.CompletionHandler;
import com.zkty.nativ.jsi.bridge.DWebView;
import com.zkty.nativ.jsi.exception.XEngineException;
import com.zkty.nativ.jsi.webview.XEngineWebView;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;

public abstract class JSIModule {

    public abstract String moduleId();

    public int order() {
        return 0;
    }

    protected XEngineWebView xEngineWebView;

    //反射调用，在 DWebView 的 call() 方法
    public void setWebView(DWebView webView) {
        if (webView instanceof XEngineWebView) {
            this.xEngineWebView = (XEngineWebView) webView;
        }

    }


    protected abstract void afterAllJSIModuleInited();

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

    protected JSONObject mergeDefault(JSONObject object, String defaultJson) {
        try {
            if (object == null || object.isEmpty()) return JSONObject.parseObject(defaultJson);
            if (TextUtils.isEmpty(defaultJson) || JSONObject.parseObject(defaultJson).isEmpty())
                return object;
            return merge(object, JSONObject.parseObject(defaultJson));

        } catch (Exception e) {
            return object;
        }
    }

    private JSONObject merge(JSONObject const_dest, JSONObject const_dv) {
        if (const_dest == null || const_dest.isEmpty()) return const_dv;
        if (const_dv == null || const_dv.isEmpty()) return const_dest;

        JSONObject result = new JSONObject();

        for (Map.Entry<String, Object> entry : const_dest.entrySet()) {
            Object value = entry.getValue();
            // default 里有的相同 key
            if (const_dv.containsKey(entry.getKey())) {
                //  如果 value 是 dict 调用 value=merge(dest[key],default[key])
                //  现在仅处理了 dict 的 merge 情况,
                //  数组 不处理, 用不到.
                //  set 不处理, json 里没有.
                if (value instanceof JSONObject) {
                    value = merge((JSONObject) entry.getValue(), (JSONObject) const_dv.get(entry.getKey()));
                }
            }
            result.put(entry.getKey(), value);
        }
        // 处理 dest 里没有但 default 里有的 key
        // 以 default 里的值为准, 不关心类型
        for (Map.Entry<String, Object> entry : const_dv.entrySet()) {
            if (!const_dest.containsKey(entry.getKey())) {
                result.put(entry.getKey(), entry.getValue());
            }
        }
        return result;
    }

    private <T> T convert(String defaultJson, JSONObject object, Class<T> tClass) {
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

    protected boolean isSameMicroApp(XEngineWebView webView, XEngineWebView webView2) {
        if (webView == null || webView2 == null) {
            return false;
        }
        if (webView.getHistoryModel() != null && webView2.getHistoryModel() != null) {
            String host = webView.getHistoryModel().host;
            return host != null && host.equals(webView2.getHistoryModel().host);
        }
        return false;
    }

}
