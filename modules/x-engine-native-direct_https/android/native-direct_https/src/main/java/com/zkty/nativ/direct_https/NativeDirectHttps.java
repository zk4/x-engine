package com.zkty.nativ.direct_https;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.direct.IDirect;

import java.util.List;
import java.util.Map;

public class NativeDirectHttps extends NativeModule implements IDirect {
    private IDirect microappDirect;

    @Override
    public String moduleId() {
        return "com.zkty.native.direct_https";
    }

    @Override
    public int order() {
        return 0;
    }

    @Override
    public void afterAllNativeModuleInited() {
        List<NativeModule> modules = NativeContext.sharedInstance().getModulesByProtocol(IDirect.class);

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
        return "https";
    }

    @Override
    public String protocol() {
        return "https:";
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
