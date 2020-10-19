package com.zkty.engine.module.server;

import android.app.Application;

import com.zkty.modules.loaded.EngineSdk;

public class TemplateApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        EngineSdk.init(this);
    }
}
