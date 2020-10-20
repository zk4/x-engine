package com.zkty.engine.module.phone;

import android.app.Application;

import com.zkty.modules.engine.XEngineContext;


public class TemplateApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        XEngineContext.init(this);
    }
}
