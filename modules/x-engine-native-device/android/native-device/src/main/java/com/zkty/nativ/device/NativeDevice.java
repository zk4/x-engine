package com.zkty.nativ.device;

import android.os.Build;

import androidx.annotation.RequiresApi;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.DensityUtils;
import com.zkty.nativ.core.utils.DeviceUtils;

public class NativeDevice extends NativeModule implements IDevice {

    @Override
    public String moduleId() {
        return "com.zkty.native.device";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public String getSystemModel() {
        return DeviceUtils.getSystemModel();
    }

    @Override
    public String getSystemVersion() {
        return DeviceUtils.getSystemVersion();
    }

    @Override
    public String getSystemLanguage() {
        return DeviceUtils.getSystemLanguage();
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public int getBatteryLevel() {
        return DeviceUtils.getBatteryLevel(XEngineApplication.getApplication());
    }

    @Override
    public float getStatusBarHeight() {
        return DensityUtils.getStatusBarHeight(XEngineApplication.getApplication());
    }
}
