package com.zkty.demo.pedestal;

import android.app.Application;

import com.zkty.modules.engine.XEngineApplication;

public class PedestalApplication extends XEngineApplication {
    private static PedestalApplication application;

    @Override
    public void onCreate() {
        super.onCreate();
        application = this;
    }

    public static Application getApplication() {
        return application;
    }
}
