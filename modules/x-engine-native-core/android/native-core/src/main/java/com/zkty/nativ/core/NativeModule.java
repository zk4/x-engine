package com.zkty.nativ.core;


import android.text.TextUtils;

import com.alibaba.fastjson.JSONObject;
import com.zkty.nativ.core.annotation.Optional;
import com.zkty.nativ.core.exception.XCoreException;

import java.lang.reflect.Field;
import java.util.Map;

public abstract class NativeModule {

    public abstract String moduleId();

    public int order() {
        return 0;
    }

    public void afterAllNativeModuleInited() {
    }

    protected <T> T convert(Map object, Class<T> tClass) {
        Field[] fields = tClass.getDeclaredFields();
        StringBuilder builder = new StringBuilder();
        for (final Field field : fields) {
            Optional optionalAnnotation = field.getAnnotation(Optional.class);
            if (optionalAnnotation == null && !object.containsKey(field.getName())) {
                builder.append(field.getName()).append("、");
            }
        }
        if (!TextUtils.isEmpty(builder.toString())) {
            throw new XCoreException(String.format("参数 %s不能为空", builder.toString()));
        }

        return (new JSONObject(object)).toJavaObject(tClass);
    }


}
