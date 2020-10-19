package com.zkty.engine.module.protocol.net;

import java.util.HashMap;
import java.util.Map;

/**
 * REST
 */
public interface IXEngineNetRESTProtocol {

    public void get(String url, HashMap<String, String> header, HashMap<String, String> params, IXEngineNetProtocolCallback callback);

    public void post(String url, HashMap<String, String> header, HashMap<String, String> params, String json, IXEngineNetProtocolCallback callback);

    public void delete(String url, HashMap<String, String> header, String json, IXEngineNetProtocolCallback callback);

    public void patch(String url, HashMap<String, String> header, String json, IXEngineNetProtocolCallback callback);

    public void put(String url, HashMap<String, String> header, String json, IXEngineNetProtocolCallback callback);

    public void head(String url, HashMap<String, String> header, IXEngineNetProtocolCallback callback);

    public void downloadFile(String url, HashMap<String, String> header, IXEngineNetProtocolCallback callback);

    public void uploadFile(String url, HashMap<String, String> header, Map<String, String> file, IXEngineNetProtocolCallback callback);
}
