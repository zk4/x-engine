package com.zkty.modules.loaded.imp;


import com.zkty.modules.loaded.callback.IXEngineNetProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;

import java.util.HashMap;
import java.util.Map;

public class XEngineNetManager {
    private static final String TAG = "XEngineNetManager";


    private IXEngineNetProtocol ixEngineNetProtocol;

    private XEngineNetManager() {
        ixEngineNetProtocol = XEngineNetImpl.getInstance();
    }

    private static class HOLDER {
        private static final XEngineNetManager INSTANCE = new XEngineNetManager();
    }

    public static XEngineNetManager getInstance() {
        return HOLDER.INSTANCE;
    }

    public void doRequest(IXEngineNetProtocol.Method method,
                          final String url, final HashMap<String, String> header, final HashMap<String, String> params,
                          final Map<String, String> file, final IXEngineNetProtocolCallback callback) {
        ixEngineNetProtocol.doRequest(method, url, header, params, file, callback);
    }


    public void doDownloadFile(IXEngineNetProtocol.Method method,
                               final String url, final HashMap<String, String> header, final HashMap<String, String> params,
                               final IXEngineNetProtocolCallback callback) {

    }


    public void doUploadFile(IXEngineNetProtocol.Method method,
                             final String url, final HashMap<String, String> header, final HashMap<String, String> params,
                             final IXEngineNetProtocolCallback callback) {

    }
}
