package com.zkty.engine.module.xxxx;

import com.zkty.engine.module.xxxx.network.NetworkMaster;
import com.zkty.modules.engine.XEngineApplication;

public class xxxxApplication extends XEngineApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        NetworkMaster.init(this, BuildConfig.BUILD_TYPE);
    }
}
