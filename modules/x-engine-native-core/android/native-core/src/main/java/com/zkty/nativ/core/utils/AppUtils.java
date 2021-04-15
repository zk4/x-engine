package com.zkty.nativ.core.utils;

import android.app.ActivityManager;
import android.content.Context;

import java.util.List;

public class AppUtils {

    /**
     * 判断是否是App的进程
     *
     * @param context App上下文
     * @return true是, false不是
     */
    public static boolean isAppProcess(Context context) {
        int pid = android.os.Process.myPid();
        String packageName = context.getPackageName();
        ActivityManager am = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        List<ActivityManager.RunningAppProcessInfo> infos = am.getRunningAppProcesses();
        for (ActivityManager.RunningAppProcessInfo info : infos) {
            if (info.pid == pid && info.processName.equals(packageName)) {
                return true;
            }
        }
        return false;
    }
}
