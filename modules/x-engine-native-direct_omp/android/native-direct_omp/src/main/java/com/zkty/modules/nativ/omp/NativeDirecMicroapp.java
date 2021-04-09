package com.zkty.modules.nativ.omp;

import android.app.Activity;
import android.text.TextUtils;

import com.zkty.engine.nativ.protocol.IDirect;
import com.zkty.modules.nativ.core.XEngineApplication;
import com.zkty.modules.engine.exception.XEngineException;
import com.zkty.modules.nativ.core.NativeContext;
import com.zkty.modules.nativ.core.NativeModule;
import com.zkty.modules.nativ.jsi.view.XEngineWebActivity;
import com.zkty.modules.nativ.jsi.view.XEngineWebActivityManager;

import java.util.List;
import java.util.Map;

public class NativeDirecMicroapp extends NativeModule implements IDirect {
    private IDirect microappDirect;

    @Override
    public String moduleId() {
        return "com.zkty.native.direct_omp";
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
                if ("omp".equals(((IDirect) iDirect).scheme())) {
                    this.microappDirect = (IDirect) iDirect;
                }
            }
        }
    }


    @Override
    public String scheme() {
        return "omp";
    }

    @Override
    public String protocol() {
        return "https:";
    }

    @Override
    public void push(String protocol, String host, String pathname, String fragment, Map<String, Object> query, Map<String, Object> params) {
        if (TextUtils.isEmpty(protocol)) {
            protocol = protocol();
        }
        Activity currentActivity = XEngineApplication.getCurrentActivity();


        if (TextUtils.isEmpty(host)) {
            if (!(currentActivity instanceof XEngineWebActivity)) {
                throw new XEngineException("host 不可为 null");
            }
        }

        boolean hideNavbar = params != null && params.containsKey("hideNavbar") && Boolean.parseBoolean(String.valueOf(params.get("hideNavbar")));
        XEngineWebActivityManager.sharedInstance().startXEngineActivity(currentActivity, protocol, host, pathname, fragment, hideNavbar);
    }

    @Override
    public void back(String host, String fragment) {
        if (microappDirect != null)
            microappDirect.back(host, fragment);
    }


}
