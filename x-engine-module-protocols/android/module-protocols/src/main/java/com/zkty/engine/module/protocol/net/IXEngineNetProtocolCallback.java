package com.zkty.engine.module.protocol.net;

/**
 *
 */
public interface IXEngineNetProtocolCallback {
    void onSuccess(XEngineNetRequest request, XEngineNetResponse response);

    void onFailed(XEngineNetRequest request, String error);
}
