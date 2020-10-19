package com.zkty.modules.engine.utils;

import android.app.Activity;

import java.lang.reflect.Field;
import java.util.Map;

public class ActivityUtils {

    public static Activity getCurrentActivity() {
        Class activityThreadClass = null;
        try {
            activityThreadClass = Class.forName("android.app.ActivityThread");
            Object activityThread = activityThreadClass.getMethod("currentActivityThread").invoke(null);
            Field activitiesField = activityThreadClass.getDeclaredField("mActivities");
            activitiesField.setAccessible(true);
            Map activities = (Map) activitiesField.get(activityThread);
            for (Object activityRecord : activities.values()) {
                Class activityRecordClass = activityRecord.getClass();
                Field pausedField = activityRecordClass.getDeclaredField("paused");
                pausedField.setAccessible(true);
                if (!pausedField.getBoolean(activityRecord)) {
                    Field activityField = activityRecordClass.getDeclaredField("activity");
                    activityField.setAccessible(true);
                    return  (Activity) activityField.get(activityRecord);
                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }
        return null;
    }

//    public static void exitAllXEngineActivity() {
//        Class activityThreadClass = null;
//        try {
//            activityThreadClass = Class.forName("android.app.ActivityThread");
//            Object activityThread = activityThreadClass.getMethod("currentActivityThread").invoke(null);
//            Field activitiesField = activityThreadClass.getDeclaredField("mActivities");
//            activitiesField.setAccessible(true);
//            Map activities = (Map) activitiesField.get(activityThread);
//            for (Object activityRecord : activities.values()) {
//                Class activityRecordClass = activityRecord.getClass();
//                Field activityField = activityRecordClass.getDeclaredField("activity");
//                activityField.setAccessible(true);
//                Activity activity = (Activity) activityField.get(activityRecord);
//                if (activity instanceof XEngineWebActivity || activity instanceof XEngineIndexActivity) {
//                    activity.finish();
//                }
//
//            }
//        } catch (Exception e) {
//
//            e.printStackTrace();
//        }
//
//    }
//
//    public static void goBackToIndexActivity() {
//        Class activityThreadClass = null;
//        try {
//            activityThreadClass = Class.forName("android.app.ActivityThread");
//            Object activityThread = activityThreadClass.getMethod("currentActivityThread").invoke(null);
//            Field activitiesField = activityThreadClass.getDeclaredField("mActivities");
//            activitiesField.setAccessible(true);
//            Map activities = (Map) activitiesField.get(activityThread);
//            for (Object activityRecord : activities.values()) {
//                Class activityRecordClass = activityRecord.getClass();
//                Field activityField = activityRecordClass.getDeclaredField("activity");
//                activityField.setAccessible(true);
//                Activity activity = (Activity) activityField.get(activityRecord);
//                if (activity instanceof XEngineWebActivity) {
//                    activity.finish();
//                }
//
//            }
//        } catch (Exception e) {
//
//            e.printStackTrace();
//        }
//
//    }
}
