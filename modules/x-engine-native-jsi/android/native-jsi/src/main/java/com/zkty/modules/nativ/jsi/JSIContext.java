package com.zkty.modules.nativ.jsi;

import android.app.Application;
import android.content.Context;
import android.util.Log;

import com.zkty.modules.engine.exception.XEngineException;
import com.zkty.modules.nativ.core.NativeContext;
import com.zkty.modules.nativ.core.NativeModule;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class JSIContext extends NativeModule {
    private List<Class> moduleClasses;
    private List<JSIModule> modules;
    private String TAG = NativeModule.class.getSimpleName();

    @Override
    public String moduleId() {
        return "com.zkty.native.jsicontext";
    }

    private Context mContext;


    private JSIContext() {
        moduleClasses = new ArrayList<>();
        modules = new ArrayList<>();
    }

    private static volatile JSIContext instance = null;

    public static JSIContext sharedInstance() {
        if (instance == null) {
            synchronized (NativeContext.class) {
                if (instance == null) {
                    instance = new JSIContext();
                }
            }
        }
        return instance;
    }

    public void init(Application content) {
        this.mContext = content;
        initModules();
        afterAllNativeModuleInited();

    }

    @Override
    public void afterAllNativeModuleInited() {
        for (JSIModule module : modules) {
            module.afterAllJSIModuleInited();
        }
    }

    public List<JSIModule> modules() {
        return this.modules;
    }

    private void initModules() {
        for (Class clazz : moduleClasses) {
            try {
                JSIModule module = (JSIModule) clazz.newInstance();
                String moduleId = module.moduleId();
                modules.add(module);
                Log.d(TAG, String.format("jsi moudle found: %s", moduleId));
            } catch (IllegalAccessException | InstantiationException e) {
                e.printStackTrace();
            }
        }
        //排序？


    }

    public void registerModuleByClass(Class clazz) {
        if (moduleClasses.contains(clazz)) {
            throw new XEngineException("重复注册JSI clazz:" + clazz);
        }
        moduleClasses.add(clazz);
    }
}
