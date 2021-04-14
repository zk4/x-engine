package com.zkty.nativ.device;

public interface IDevice {

    String getStatusBarHeight();

    String getNavigationHeight();

    String getScreenHeight();

    String getTabbarHeight();

    String getSystemVersion();

    String getUDID();

    String callPhone(String phone);

    String sendMessage(String phone, String msg);

    String getDeviceInfo();


}
