package com.zkty.nativ.core;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;

import androidx.multidex.MultiDexApplication;

import com.zkty.nativ.core.utils.Utils;

public class XEngineApplication extends MultiDexApplication {

    private static final String TAG = XEngineApplication.class.getSimpleName();
    private static Application application;
    private static Activity current;

    @Override
    public void onCreate() {
        super.onCreate();
        application = this;
        //主进程中初始化引擎
        if (Utils.getCurProcessName(this).equals(getApplicationInfo().packageName)) {
            NativeContext.sharedInstance().init(this);
        }
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
    }

    @Override
    public void onTerminate() {
        super.onTerminate();
        ActivityStackManager.getInstance().unRegister(this);
    }

    public static Application getApplication() {
        return application;
    }

    public static Activity getCurrentActivity() {
        return current;
    }
}
