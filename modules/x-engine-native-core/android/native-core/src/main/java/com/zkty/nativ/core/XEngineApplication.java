package com.zkty.nativ.core;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import androidx.multidex.MultiDexApplication;


import com.zkty.nativ.core.utils.IApplicationListener;
import com.zkty.nativ.core.utils.Utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class XEngineApplication extends MultiDexApplication {

    private static final String TAG = XEngineApplication.class.getSimpleName();
    private static Application application;
    private static Activity current;

    @Override
    public void onCreate() {
        super.onCreate();
        application = this;
        //主进程中初始化引擎
//        if (Utils.getCurProcessName(this).equals(getApplicationInfo().packageName)) {
        NativeContext.sharedInstance().init(this);
//        }
        registerAppOnCreateLifecycleCallback();
        registerActivityLifecycleCallback();

    }

    private void registerAppOnCreateLifecycleCallback() {
        List<NativeModule> modules = NativeContext.sharedInstance().getModules();

        for (NativeModule module : modules) {
            if (module instanceof IApplicationListener) {
                IApplicationListener listener = (IApplicationListener) module;
                if (listener != null) {
                    listener.onAppCreate(this);
                }

            }
        }

    }

    private void registerActivityLifecycleCallback() {
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
    public void onTerminate() {
        super.onTerminate();
        List<NativeModule> modules = NativeContext.sharedInstance().getModules();

        for (NativeModule module : modules) {
            if (module instanceof IApplicationListener) {
                IApplicationListener listener = (IApplicationListener) module;
                if (listener != null) {
                    listener.onTerminate();
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
