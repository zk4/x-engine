package com.zkty.demo.pedestal;

import android.app.Application;


public class PedestalApplication extends Application {
    private static PedestalApplication application;


    @Override
    public void onCreate() {
        super.onCreate();
        application = this;
    }
}
