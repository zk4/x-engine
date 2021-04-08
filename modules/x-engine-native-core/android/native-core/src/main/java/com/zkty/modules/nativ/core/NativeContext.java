package com.zkty.modules.nativ.core;

import android.content.Context;
import android.util.Log;

import com.alibaba.fastjson.util.ServiceLoader;
import com.zkty.modules.engine.exception.XEngineException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class NativeContext {

    private String TAG = NativeContext.class.getSimpleName();

    private List<Class> moduleClasses;
    private List<NativeModule> modules;
    private Map<String, NativeModule> moduleId2Module;
    private Map<String, List<String>> moduleId2ModuleProtocolNames;

    private Context mContext;


    private NativeContext() {
        moduleClasses = new ArrayList<>();
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

    public NativeModule getModuleByProtocol(Protocol proto) {
        String protocolName = proto.getClass().getName();
        for (Map.Entry<String, List<String>> entry : moduleId2ModuleProtocolNames.entrySet()) {

            if (entry.getValue().contains(protocolName)) {
                return moduleId2Module.get(entry.getKey());
            }
        }
        return null;
    }

    public List<NativeModule> getModulesByProtocol(Protocol proto) {
        List<NativeModule> modules = null;
        String protocolName = proto.getClass().getName();
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

    public void registerModuleByClass(Class clazz) {
        if (moduleClasses.contains(clazz)) {
            throw new XEngineException("重复注册native clazz:" + clazz);
        }
        moduleClasses.add(clazz);
    }

    private <T> List<String> getProtocols(Class<T> clazz) {
        List<String> ret = new ArrayList<>();
        Set<T> set = ServiceLoader.load(clazz, Thread.currentThread().getContextClassLoader());
        for (T t : set) {
            ret.add(t.getClass().getName());
        }
        return ret;
    }

    private void afterAllNativeModuleInited() {
        for (NativeModule module : modules) {
            module.afterAllNativeModuleInited();
        }
    }

}
