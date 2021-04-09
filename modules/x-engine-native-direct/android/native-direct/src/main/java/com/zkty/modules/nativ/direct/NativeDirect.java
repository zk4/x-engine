package com.zkty.modules.nativ.direct;

import android.util.Log;

import com.zkty.engine.nativ.protocol.IDirect;
import com.zkty.engine.nativ.protocol.IDirectManager;
import com.zkty.modules.nativ.core.NativeContext;
import com.zkty.modules.nativ.core.NativeModule;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class NativeDirect extends NativeModule implements IDirectManager {
    private static int j = 1;

    static {
        j = 2;
        System.out.println("reg native clazz NativeDirect : ");
        NativeContext.registerModuleByClass(NativeDirect.class);
    }

    {
        directors = new HashMap<>();

    }

    private Map<String, IDirect> directors;

    @Override
    public String moduleId() {
        return "com.zkty.native.direct";
    }

    @Override
    public int order() {
        return 0;
    }

    @Override
    public void afterAllNativeModuleInited() {
        List<NativeModule> modules = NativeContext.sharedInstance().getModulesByProtocol(this);
        for (NativeModule iDirect : modules) {
            if (iDirect instanceof IDirect) {
                directors.put(((IDirect) iDirect).scheme(), (IDirect) iDirect);
            }
        }
    }

    @Override
    public void push(String scheme, String host, String pathname, String fragment, Map<String, Object> query, Map<String, Object> params) {
        IDirect iDirect = directors.get(scheme);
        iDirect.push(iDirect.protocol(), host, pathname, fragment, query, params);
    }

    @Override
    public void back(String scheme, String host, String fragment) {
        IDirect iDirect = directors.get(scheme);
        iDirect.back(host, fragment);
    }
}
