package com.zkty.nativ.core;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.util.ServiceLoader;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class NativeContext {

    private String TAG = NativeContext.class.getSimpleName();

    private static List<Class> moduleClasses = new ArrayList<>();
    private List<NativeModule> modules;
    private Map<String, NativeModule> moduleId2Module;
    private Map<String, List<String>> moduleId2ModuleProtocolNames;

    private static HashMap<Class, Object> objects;
    private Context mContext;


    private NativeContext() {
        modules = new ArrayList<>();
        moduleId2Module = new HashMap();
        moduleId2ModuleProtocolNames = new HashMap<>();
    }

    private static volatile NativeContext instance = null;

    public static NativeContext sharedInstance() {
        if (instance == null) {
            synchronized (NativeContext.class) {
                if (instance == null) {
                    instance = new NativeContext();
                }
            }
        }
        return instance;
    }

    public void init(Context context) {
        this.mContext = context;
        initModulesForQuick(context);
        initModules();
        afterAllNativeModuleInited();
    }

    private void initModules() {
        for (Class clazz : moduleClasses) {
            try {
                NativeModule module = (NativeModule) clazz.newInstance();
                String moduleId = module.moduleId();
                moduleId2Module.put(moduleId, module);
                List<String> protocols = getProtocols(clazz);
                moduleId2ModuleProtocolNames.put(moduleId, protocols);
                modules.add(module);
                Log.d(TAG, String.format("moudle found: %s", moduleId));
            } catch (IllegalAccessException | InstantiationException e) {
                e.printStackTrace();
            }
        }
        //排序？
    }

    public NativeModule getModuleById(String moduleId) {
        return moduleId2Module.get(moduleId);
    }

    public NativeModule getModuleByProtocol(Class proto) {
        String protocolName = proto.getName();
        for (Map.Entry<String, List<String>> entry : moduleId2ModuleProtocolNames.entrySet()) {

            if (entry.getValue().contains(protocolName)) {
                return moduleId2Module.get(entry.getKey());
            }
        }
        return null;
    }

    public List<NativeModule> getModulesByProtocol(Class proto) {
        List<NativeModule> modules = null;
        String protocolName = proto.getName();
        for (Map.Entry<String, List<String>> entry : moduleId2ModuleProtocolNames.entrySet()) {

            if (entry.getValue().contains(protocolName)) {
                if (modules == null) {
                    modules = new ArrayList<>();
                }
                modules.add(moduleId2Module.get(entry.getKey()));
            }
        }
        return modules;
    }

    private void registerModuleByClass(Class clazz) {
        if (moduleClasses.contains(clazz)) {
            return;
        }
        moduleClasses.add(clazz);
        Log.d("NativeContext", "reg native clazz success : " + clazz);
    }

    private <T> List<String> getProtocols(Class<T> clazz) {
        Class[] clazzs = clazz.getInterfaces();
        List<String> ret = new ArrayList<>();
        for (Class cla : clazzs) {
            ret.add(cla.getName());
        }
        return ret;
    }

    private void afterAllNativeModuleInited() {
        for (NativeModule module : modules) {
            module.afterAllNativeModuleInited();
        }
    }

    /**
     * 快速注册模块实现
     *
     * @param context
     */
    private void initModulesForQuick(Context context) {

        long start = System.currentTimeMillis();
        try {
            ApplicationInfo appInfo = context.getPackageManager().getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
            if (appInfo.metaData != null) {
                for (String key : appInfo.metaData.keySet()) {
                    if (!TextUtils.isEmpty(key) && key.startsWith("com.zkty.native")) {
                        String value = appInfo.metaData.getString(key);
                        Log.d(TAG, "Id:" + key + "----" + "Class:" + value);
                        if (!TextUtils.isEmpty(value) && value.startsWith("com.zkty.nativ")) {      //过滤
                            try {
                                Class c = Class.forName(value);
                                moduleClasses.add(c);
                            } catch (ClassNotFoundException e) {
                                e.printStackTrace();
                            }

                        }
                    }
                }
            }
            Log.d(TAG, String.format("注册模块耗时 %d ms, 加载模块个数 %d 个", System.currentTimeMillis() - start, moduleClasses.size()));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<NativeModule> getModules() {
        return modules;
    }
}


