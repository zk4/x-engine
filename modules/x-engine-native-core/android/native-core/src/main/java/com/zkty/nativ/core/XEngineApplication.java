package com.zkty.nativ.core;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;

import androidx.multidex.MultiDexApplication;

import com.zkty.nativ.core.utils.IApplicationListener;
import com.zkty.nativ.core.utils.Utils;

import java.util.List;

public class XEngineApplication extends MultiDexApplication {

    private static final String TAG = XEngineApplication.class.getSimpleName();
    private static Application application;
    private static Activity current;

    @Override
    public void onCreate() {
        super.onCreate();
        application = this;
        ActivityStackManager.getInstance().register(this);
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

    @Override
    public void onTerminate() {
        super.onTerminate();
        ActivityStackManager.getInstance().unRegister(this);
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
