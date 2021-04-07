package com.zkty.modules.nativ.core;

import android.content.Context;

import com.zkty.modules.engine.exception.XEngineException;

import java.util.ArrayList;
import java.util.List;

public class NativeContext {

    private List<Class> moduleClasses;
    private Context mContext;


    private NativeContext() {
        moduleClasses = new ArrayList<>();
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
    }

    public void registerModuleByClass(Class clazz) {
        if (moduleClasses.contains(clazz)) {
            throw new XEngineException("重复注册native clazz:" + clazz);
        }
        moduleClasses.add(clazz);
    }

}
