package com.zkty.nativ.jsi.bridge;

import android.os.Build;
import android.webkit.WebResourceResponse;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.io.InputStream;
import java.util.Map;


public class WebResourceResponseAdapter extends WebResourceResponse {

    private android.webkit.WebResourceResponse mWebResourceResponse;

    public WebResourceResponseAdapter(String mimeType, String encoding, InputStream data) {
        super(mimeType, encoding, data);
    }

    public WebResourceResponseAdapter(String mimeType, String encoding, int statusCode, @NonNull String reasonPhrase, Map<String, String> responseHeaders, InputStream data) {
        super(mimeType, encoding, statusCode, reasonPhrase, responseHeaders, data);
    }




    @Override
    public String getMimeType() {
        return mWebResourceResponse.getMimeType();
    }

    @Override
    public InputStream getData() {
        return mWebResourceResponse.getData();
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public int getStatusCode() {
        return mWebResourceResponse.getStatusCode();
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    @Override
    public Map<String, String> getResponseHeaders() {
        return mWebResourceResponse.getResponseHeaders();
    }

    @Override
    public String getEncoding() {
        return mWebResourceResponse.getEncoding();
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    @Override
    public String getReasonPhrase() {
        return mWebResourceResponse.getReasonPhrase();
    }
}
