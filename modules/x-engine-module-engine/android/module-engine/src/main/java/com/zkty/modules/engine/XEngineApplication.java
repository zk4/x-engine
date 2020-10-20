package com.zkty.modules.engine;

import android.content.Context;
import android.util.Log;

import androidx.multidex.MultiDexApplication;

import com.zkty.modules.engine.core.IApplicationListener;
import com.zkty.modules.engine.manager.MicroAppsManager;
import com.zkty.modules.engine.utils.ResourceManager;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class XEngineApplication extends MultiDexApplication {
    private static final String TAG = XEngineApplication.class.getSimpleName();

    @Override
    public void onCreate() {
        super.onCreate();
        XEngineContext.init(this);
        ResourceManager.init(this);
        MicroAppsManager.init(this);

        HashMap<Class, Object> objects = XEngineContext.getObjects();
        if (objects != null) {
            Iterator<Map.Entry<Class, Object>> iterator = objects.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<Class, Object> entry = iterator.next();
                Class cls = entry.getKey();
                Object obj = entry.getValue();

                if (obj instanceof IApplicationListener) {
                    Log.d(TAG, "is instance of IApplicationListener invoke onAppCreate()");
                    try {
                        Method method = cls.getMethod("onAppCreate", Context.class);
                        try {
                            method.invoke(obj, this);
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        } catch (InvocationTargetException e) {
                            e.printStackTrace();
                        }
                    } catch (NoSuchMethodException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        HashMap<Class, Object> objects = XEngineContext.getObjects();
        if (objects != null) {
            Iterator<Map.Entry<Class, Object>> iterator = objects.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<Class, Object> entry = iterator.next();
                Class cls = entry.getKey();
                Object obj = entry.getValue();

                if (obj instanceof IApplicationListener) {
                    Log.d(TAG, "is instance of IApplicationListener invoke onAppLowMemory()");
                    try {
                        Method method = cls.getMethod("onAppLowMemory");
                        try {
                            method.invoke(obj);
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        } catch (InvocationTargetException e) {
                            e.printStackTrace();
                        }
                    } catch (NoSuchMethodException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
