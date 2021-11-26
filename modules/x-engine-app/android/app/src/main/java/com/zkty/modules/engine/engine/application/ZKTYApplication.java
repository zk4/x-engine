package com.zkty.modules.engine.engine.application;


import com.didichuxing.doraemonkit.DoraemonKit;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.Utils;


public class ZKTYApplication extends XEngineApplication {


    @Override
    public void onCreate() {
        super.onCreate();
        if (Utils.getCurProcessName(this).equals(getApplicationInfo().packageName)) {
            NativeContext.sharedInstance().init(this);
        }
        DoraemonKit.install(this, "pId");

    }
}
