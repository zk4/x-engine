package com.zkty.modules.engine.engine.application;


import com.didichuxing.doraemonkit.DoraemonKit;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.MicroAppsInstall;


public class ZKTYApplication extends XEngineApplication {


    @Override
    public void onCreate() {
        super.onCreate();
        DoraemonKit.install(this, "pId");

    }
}
