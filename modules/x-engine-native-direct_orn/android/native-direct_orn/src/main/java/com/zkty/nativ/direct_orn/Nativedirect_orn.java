package com.zkty.nativ.direct_orn;

import android.util.Log;

import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.direct.IDirect;

import java.io.File;
import java.util.List;
import java.util.Map;

public class Nativedirect_orn extends NativeModule implements IDirect {

    private IDirect microappDirect;

    @Override
    public String moduleId() {
        return  "com.zkty.native.direct_orn";
    }

    @Override
    public void afterAllNativeModuleInited() {
        List<NativeModule> modules = NativeContext.sharedInstance().getModulesByProtocol(IDirect.class);

        for (NativeModule iDirect : modules) {
            if (iDirect instanceof IDirect) {
                if ("rns".equals(((IDirect) iDirect).scheme())) {
                    this.microappDirect = (IDirect) iDirect;
                }
            }
        }
    }

    @Override
    public String scheme() {
        return "rns";
    }

    @Override
    public String protocol() {
        return "rns:";
    }

    @Override
    public void push(String protocol, String host, String pathname, String fragment, Map<String, String> query, Map<String, String> params) {
        if (microappDirect != null)
            microappDirect.push(protocol(), host, pathname, fragment, query, params);
    }

    @Override
    public void back(String host, String fragment) {
        if (microappDirect != null)
            microappDirect.back(host, fragment);
    }
}
