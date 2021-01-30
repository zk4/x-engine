package com.zkty.modules.loaded.callback;

/**
 *
 */
public interface IXEngineNetProtocolCallback {
    void onSuccess(XEngineNetRequest request, XEngineNetResponse response);

    void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done);

    void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done);

    void onFailed(XEngineNetRequest request, String error);
}
