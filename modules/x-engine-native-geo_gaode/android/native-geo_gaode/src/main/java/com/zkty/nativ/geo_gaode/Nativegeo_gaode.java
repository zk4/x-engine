package com.zkty.nativ.geo_gaode;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.geo.IGeoManager;
import com.zkty.nativ.geo.Igeo;

public class Nativegeo_gaode extends NativeModule implements Igeo {

    @Override
    public String moduleId() {
        return "com.zkty.native.geo_gaode";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public void locate(IGeoManager.CallBack callBack) {


    }
}
