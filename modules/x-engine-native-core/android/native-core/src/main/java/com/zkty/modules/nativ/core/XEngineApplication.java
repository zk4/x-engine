package com.zkty.modules.nativ.core;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import androidx.multidex.MultiDexApplication;

import com.zkty.modules.engine.XEngineContext;
import com.zkty.modules.engine.core.IApplicationListener;
import com.zkty.modules.engine.core.IApplicationListener2;
import com.zkty.modules.engine.utils.Utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class XEngineApplication extends MultiDexApplication {

    private static final String TAG = XEngineApplication.class.getSimpleName();
    private static Application application;
    private static Activity current;

    @Override
    public void onCreate() {
        super.onCreate();
        Log.d(TAG, "process:" + Utils.getCurProcessName(this) + "---packageName:" + getApplicationInfo().packageName);
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
//            String processName = Utils.getCurProcessName(this);
//            String packageName = this.getPackageName();
//            if (!packageName.equals(processName)) {
//                WebView.setDataDirectorySuffix(processName);
//            }
//        }
        //主进程中初始化引擎
        if (Utils.getCurProcessName(this).equals(getApplicationInfo().packageName)) {
            application = this;
            NativeContext.sharedInstance().init(this);

            HashMap<Class, Object> objects = XEngineContext.getObjects();
            if (objects != null) {
                Iterator<Map.Entry<Class, Object>> iterator = objects.entrySet().iterator();
                while (iterator.hasNext()) {
                    Map.Entry<Class, Object> entry = iterator.next();
                    Class cls = entry.getKey();
                    Object obj = entry.getValue();

                    if (obj instanceof IApplicationListener || obj instanceof IApplicationListener2) {
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

        registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(Activity activity, Bundle savedInstanceState) {

            }

            @Override
            public void onActivityStarted(Activity activity) {

            }

            @Override
            public void onActivityResumed(Activity activity) {
                current = activity;
            }

            @Override
            public void onActivityPaused(Activity activity) {

            }

            @Override
            public void onActivityStopped(Activity activity) {

            }

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle outState) {

            }

            @Override
            public void onActivityDestroyed(Activity activity) {

            }
        });
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

    @Override
    public void onTerminate() {
        super.onTerminate();
        HashMap<Class, Object> objects = XEngineContext.getObjects();
        if (objects != null) {
            Iterator<Map.Entry<Class, Object>> iterator = objects.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<Class, Object> entry = iterator.next();
                Class cls = entry.getKey();
                Object obj = entry.getValue();

                if (obj instanceof IApplicationListener || obj instanceof IApplicationListener) {
                    Log.d(TAG, "is instance of IApplicationListener invoke onTerminate()");
                    try {
                        Method method = cls.getMethod("onTerminate");
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

    public static Application getApplication() {
        return application;
    }

    public static Activity getCurrentActivity() {
        return current;
    }
}
