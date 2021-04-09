package com.zkty.modules.engine;

import android.app.Application;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.text.TextUtils;
import android.util.Log;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


public class XEngineContext {
    private static List<String> modules;
    private static HashMap<Class, Object> objects;
    private static final String TAG = XEngineContext.class.getSimpleName();

    public static void init(Application application) {
        initX5(application);
        initModulesForQuick(application);
        onAllModulesInited();
    }


    /**
     * 快速注册模块实现
     *
     * @param context
     */
    private static void initModulesForQuick(Context context) {
        if (modules == null || modules.isEmpty()) {
            modules = new ArrayList<>();
            long start = System.currentTimeMillis();
            try {
                ApplicationInfo appInfo = context.getPackageManager().getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
                if (appInfo.metaData != null) {
                    for (String key : appInfo.metaData.keySet()) {
                        if (!TextUtils.isEmpty(key) && key.startsWith("com.zkty.module")) {
                            String value = appInfo.metaData.getString(key);
                            Log.d(TAG, "Id:" + key + "----" + "Class:" + value);
                            if (!TextUtils.isEmpty(value) && value.startsWith("com.zkty.modules.loaded")) {      //过滤
                                modules.add(value);
                            }
                        }
                    }
                }
                Log.d(TAG, String.format("注册模块耗时 %d ms, 加载模块个数 %d 个", System.currentTimeMillis() - start, modules.size()));
            } catch (PackageManager.NameNotFoundException e) {

            }
        }
        if (objects == null) {
            objects = new HashMap<>();
        }
    }


    public static void initX5(Context application) {
//        QbSdk.initX5Environment(application.getApplicationContext(), new QbSdk.PreInitCallback() {
//            @Override
//            public void onCoreInitFinished() {
//                Log.d("initX5", "onCoreInitFinished");
//            }
//
//            @Override
//            public void onViewInitFinished(boolean b) {
//                Log.d("initX5", "onViewInitFinished: " + b);
//            }
//        });
    }



    public static List<String> getModules() {
        return modules;
    }

    public static HashMap<Class, Object> getObjects() {
        return objects;
    }

    private static void onAllModulesInited() {
        for (String module : modules) {
            Class<?> classModule = null;
            try {
                classModule = Class.forName(module);
                Constructor<?> constructor = classModule.getDeclaredConstructor();
                constructor.setAccessible(true);
                Object object = constructor.newInstance();
                objects.put(classModule, object);
                Method methodModule = classModule.getMethod("onAllModulesInited");
//                methodModule.setAccessible(true);
                methodModule.invoke(object);


            } catch (Exception e) {
                Log.d(TAG, e.toString());
            }
        }
    }
}
