package com.zkty.modules.engine.utils;
import android.content.Context;
import android.os.BatteryManager;
import android.os.Build;

import androidx.annotation.RequiresApi;

import java.util.Locale;

public class DeviceUtils {

    /**
     * 获取手机型号
     */
    public static String getSystemModel() {

        return android.os.Build.MODEL;
    }

    /**
     * 系统版本号
     */
    public static String getSystemVersion() {
        return "Android " + android.os.Build.VERSION.RELEASE;
    }

    /**
     * 获取当前手机系统语言。
     *
     * @return 返回当前系统语言。例如：当前设置的是“中文-中国”，则返回“zh-CN”
     */
    public static String getSystemLanguage() {
        return Locale.getDefault().getLanguage();
    }

    /**
     * 获取当前手机电视电量。
     *
     * @return 电量百分比
     */
    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public static int getBatteryLevel(Context context) {
        BatteryManager manager = (BatteryManager) context.getSystemService(Context.BATTERY_SERVICE);
        return manager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);

    }


}
