package com.zkty.nativ.device;

public interface IDevice {

    String getSystemModel();

    String getSystemVersion();

    String getSystemLanguage();

    int getBatteryLevel();

    float getStatusBarHeight();


}
