package com.zkty.modules.loaded.imp;


import com.zkty.modules.loaded.callback.IXEngineNetProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;
import com.zkty.modules.loaded.callback.IXEngineNetRESTProtocol;

import java.util.HashMap;
import java.util.Map;

/**
 *
 */
public class XEngineNetRESTImpl implements IXEngineNetRESTProtocol {
    private static final String TAG = "XEngineNetRESTImpl";


    private IXEngineNetProtocol iXEngineNetProtocol;

    public XEngineNetRESTImpl(IXEngineNetProtocol iXEngineNetProtocol) {
        this.iXEngineNetProtocol = iXEngineNetProtocol;
    }

    @Override
    public void get(String url, HashMap<String, String> header, HashMap<String, String> params, IXEngineNetProtocolCallback callback) {
        iXEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.GET, url, header, params, null, null, callback);
    }

    @Override
    public void post(String url, HashMap<String, String> header, HashMap<String, String> params, String json, IXEngineNetProtocolCallback callback) {
        iXEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.POST, url, header, params, json, null, callback);
    }

    @Override
    public void delete(String url, HashMap<String, String> header, String json, IXEngineNetProtocolCallback callback) {
        iXEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.DELETE, url, header, null, null, null, callback);
    }

    @Override
    public void patch(String url, HashMap<String, String> header, String json, IXEngineNetProtocolCallback callback) {
        iXEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.PATCH, url, header, null, json, null, callback);
    }

    @Override
    public void put(String url, HashMap<String, String> header, String json, IXEngineNetProtocolCallback callback) {
        iXEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.PUT, url, header, null, json, null, callback);
    }

    @Override
    public void head(String url, HashMap<String, String> header, IXEngineNetProtocolCallback callback) {
        iXEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.HEADER, url, header, null, null, null, callback);
    }

    @Override
    public void downloadFile(String url, HashMap<String, String> header, HashMap<String, String> params, IXEngineNetProtocolCallback callback) {
        iXEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.GET, url, header, params, null, null, callback);
    }

    @Override
    public void uploadFile(String url, HashMap<String, String> header, HashMap<String, String> params, HashMap<String, String> file, IXEngineNetProtocolCallback callback) {
        iXEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.POST, url, header, params, null, file, callback);
    }
}
