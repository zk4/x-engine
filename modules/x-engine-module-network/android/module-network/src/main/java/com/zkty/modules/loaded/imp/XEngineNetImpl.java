package com.zkty.modules.loaded.imp;

import android.os.Handler;
import android.text.TextUtils;

import com.zkty.modules.loaded.callback.IXEngineNetProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;
import com.zkty.modules.loaded.callback.XEngineNetRequest;
import com.zkty.modules.loaded.callback.XEngineNetResponse;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicLong;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class XEngineNetImpl implements IXEngineNetProtocol {
    private static final String TAG = "XEngineNetImpl";

    private OkHttpClient client;

    private AtomicLong requestCount;
    private AtomicLong processedSuccessCount;
    private AtomicLong processFailedCount;
    private Handler mHandler;

    private static OkHttpClient.Builder builder;

    /**
     * 自定义Builder
     *
     * @param customBuilder
     */
    public static void initBuilder(OkHttpClient.Builder customBuilder) {
        builder = customBuilder;
    }

    public static XEngineNetImpl getInstance() {
        return HOLDER.INSTANCE;
    }

    private static class HOLDER {
        private static final XEngineNetImpl INSTANCE = new XEngineNetImpl();
    }

    private XEngineNetImpl() {
        if (builder != null) {
            client = builder.build();
        } else {
            client = new OkHttpClient.Builder()
                    .readTimeout(60, TimeUnit.SECONDS)      //默认10s
                    .writeTimeout(60, TimeUnit.SECONDS)     //默认10s
                    .connectTimeout(60, TimeUnit.SECONDS)   //默认10s
                    .build();
        }


        client.dispatcher().setMaxRequests(128);                //设置最大处理请求量（非就绪队列，是正在运行队列）
        client.dispatcher().setMaxRequestsPerHost(16);          //每个主机复用连接个数


        if (DebugUtils.isDebug()) {
            requestCount = new AtomicLong(0);
            processedSuccessCount = new AtomicLong(0);
            processFailedCount = new AtomicLong(0);

            mHandler = new Handler();
        }
    }

    @Override
    public void doRequest(Method method, final String url, final Map<String, String> header, final Map<String, String> params,
                          final String json,
                          final Map<String, String> file, final IXEngineNetProtocolCallback callback) {
        Request.Builder builder = new Request.Builder();
        if (header != null) {
            Iterator<Map.Entry<String, String>> iterator = header.entrySet().iterator();
            while (iterator.hasNext()) {
                Map.Entry<String, String> entry = iterator.next();
                builder.addHeader(entry.getKey(), entry.getValue());
            }
        }

        MultipartBody.Builder multipartBuilder = null;
        switch (method) {
            case GET:
                StringBuilder stringBuilder = new StringBuilder();
                if (!url.endsWith("?")) {
                    stringBuilder.append(url).append("?");
                } else {
                    stringBuilder.append(url);
                }
                if (params != null) {
                    Iterator<Map.Entry<String, String>> iterator = params.entrySet().iterator();
                    while (iterator.hasNext()) {
                        Map.Entry<String, String> entry = iterator.next();
                        stringBuilder.append("&").append(entry.getKey()).append("=").append(entry.getValue());
                    }
                }


                builder.url(stringBuilder.toString().replaceFirst("&",""));
                builder.get();
                break;
            case POST:
                if (!TextUtils.isEmpty(json)) {                 //json不为空 按照CONTENT_TYPE_JSON处理
                    RequestBody body = RequestBody.create(json, MediaType.parse("application/json; charset=utf-8"));
                    builder.post(body);
                } else {                                     //json为空
                    multipartBuilder = new MultipartBody.Builder().setType(MultipartBody.FORM);
                    if (params != null) {
                        Iterator<Map.Entry<String, String>> iterator = params.entrySet().iterator();
                        while (iterator.hasNext()) {
                            Map.Entry<String, String> entry = iterator.next();
                            multipartBuilder.addFormDataPart(entry.getKey(), entry.getValue());
                        }
                    }

                    boolean hasFile = false;
                    if (file != null && !file.isEmpty()) {
                        Iterator<Map.Entry<String, String>> iterator = file.entrySet().iterator();
                        while (iterator.hasNext()) {
                            Map.Entry<String, String> entry = iterator.next();
                            DebugUtils.debug(TAG, "fileName:" + entry.getKey() + "----path:" + entry.getValue());
                            if (new File(entry.getValue()).exists()) {
                                multipartBuilder.addFormDataPart("file", entry.getKey(), RequestBody.create(new File(entry.getValue()), MediaType.parse("multipart/form-data")));
                                hasFile = true;
                            }
                        }
                    }

                    if ((params == null || params.isEmpty()) && !hasFile) {
                        builder.post(RequestBody.create(null, ""));        //空body
                    } else {
//                    builder.post(multipartBuilder.build());
                        builder.post(new ProgressRequestBody(multipartBuilder.build(), new ProgressRequestListener() {
                            @Override
                            public void onRequestProgress(long bytesWritten, long contentLength, boolean done) {
                                XEngineNetRequest xEngineNetRequest = new XEngineNetRequest();
                                xEngineNetRequest.setUrl(url);
                                xEngineNetRequest.setHeader(header);
                                xEngineNetRequest.setParams(params);

                                callback.onUploadProgress(xEngineNetRequest, bytesWritten, contentLength, done);
                            }
                        }));
                    }
                }
                builder.url(url);
                break;
            case PUT:
                multipartBuilder = new MultipartBody.Builder().setType(MultipartBody.FORM);
                if (params != null) {
                    Iterator<Map.Entry<String, String>> iterator = params.entrySet().iterator();
                    while (iterator.hasNext()) {
                        Map.Entry<String, String> entry = iterator.next();
                        multipartBuilder.addFormDataPart(entry.getKey(), entry.getValue());
                    }
                }

                if (params != null) {
//                    builder.put(multipartBuilder.build());
                    builder.put(new ProgressRequestBody(multipartBuilder.build(), new ProgressRequestListener() {
                        @Override
                        public void onRequestProgress(long bytesWritten, long contentLength, boolean done) {
                            XEngineNetRequest xEngineNetRequest = new XEngineNetRequest();
                            xEngineNetRequest.setUrl(url);
                            xEngineNetRequest.setHeader(header);
                            xEngineNetRequest.setParams(params);

                            callback.onUploadProgress(xEngineNetRequest, bytesWritten, contentLength, done);
                        }
                    }));
                } else {
                    builder.put(RequestBody.create(null, ""));        //空body
                }
                builder.url(url);
                break;
            case DELETE:
                multipartBuilder = new MultipartBody.Builder().setType(MultipartBody.FORM);
                if (params != null) {
                    Iterator<Map.Entry<String, String>> iterator = params.entrySet().iterator();
                    while (iterator.hasNext()) {
                        Map.Entry<String, String> entry = iterator.next();
                        multipartBuilder.addFormDataPart(entry.getKey(), entry.getValue());
                    }
                }
                if (params != null) {
//                    builder.delete(multipartBuilder.build());
                    builder.delete(new ProgressRequestBody(multipartBuilder.build(), new ProgressRequestListener() {
                        @Override
                        public void onRequestProgress(long bytesWritten, long contentLength, boolean done) {
                            XEngineNetRequest xEngineNetRequest = new XEngineNetRequest();
                            xEngineNetRequest.setUrl(url);
                            xEngineNetRequest.setHeader(header);
                            xEngineNetRequest.setParams(params);

                            callback.onUploadProgress(xEngineNetRequest, bytesWritten, contentLength, done);
                        }
                    }));
                } else {
                    builder.delete();
                }
                builder.url(url);
                break;
            case PATCH:
                multipartBuilder = new MultipartBody.Builder().setType(MultipartBody.FORM);
                if (params != null) {
                    Iterator<Map.Entry<String, String>> iterator = params.entrySet().iterator();
                    while (iterator.hasNext()) {
                        Map.Entry<String, String> entry = iterator.next();
                        multipartBuilder.addFormDataPart(entry.getKey(), entry.getValue());
                    }
                }
                if (params != null) {
//                    builder.patch(multipartBuilder.build());
                    builder.patch(new ProgressRequestBody(multipartBuilder.build(), new ProgressRequestListener() {
                        @Override
                        public void onRequestProgress(long bytesWritten, long contentLength, boolean done) {
                            XEngineNetRequest xEngineNetRequest = new XEngineNetRequest();
                            xEngineNetRequest.setUrl(url);
                            xEngineNetRequest.setHeader(header);
                            xEngineNetRequest.setParams(params);

                            callback.onUploadProgress(xEngineNetRequest, bytesWritten, contentLength, done);
                        }
                    }));
                } else {
                    builder.patch(RequestBody.create(null, ""));        //空body
                }
                builder.url(url);
                break;
            case HEADER:
                builder.head();
                builder.url(url);
                break;
        }


        if (DebugUtils.isDebug()) {
            requestCount.incrementAndGet();                 //统计请求个数
            if (requestCount.get() == 1) {
                mHandler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        DebugUtils.debug(TAG, monitor());
                    }
                }, 1000);
            }
        }

        final XEngineNetRequest xEngineNetRequest = new XEngineNetRequest();
        xEngineNetRequest.setUrl(url);
        xEngineNetRequest.setHeader(header);
        xEngineNetRequest.setParams(params);

        client.newCall(builder.build()).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                if (DebugUtils.isDebug()) {
                    DebugUtils.debug(TAG, "onFailure:" + e.getMessage());
                    processFailedCount.incrementAndGet();       //统计返回错误的次数
                }

                if (callback != null) {
                    callback.onFailed(xEngineNetRequest, e.getMessage());
                }
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                if (DebugUtils.isDebug()) {
                    DebugUtils.debug(TAG, "onResponse!");
                    processedSuccessCount.incrementAndGet();        //统计返回成功的次数
                }
                if (callback != null) {
                    XEngineNetResponse xEngineNetResponse = new XEngineNetResponse();
                    xEngineNetResponse.setCode(response.code());
                    HashMap<String, String> xheader = new HashMap<>();
                    Set<String> names = response.headers().names();
                    if (names != null) {
                        Iterator<String> iterator = names.iterator();
                        while (iterator.hasNext()) {
                            String key = iterator.next();
                            String value = response.headers().get(key);
                            xheader.put(key, value);
                        }
                    }
                    xEngineNetResponse.setHeader(xheader);
                    xEngineNetResponse.setContentLength(response.body().contentLength());
                    xEngineNetResponse.setBody(response.body().byteStream());

                    callback.onSuccess(xEngineNetRequest, xEngineNetResponse);
                }
                response.body().close();

                DebugUtils.debug(TAG, monitor());
            }
        });
    }


    @Override
    public void cancelAll() {
        client.dispatcher().cancelAll();
    }

    @Override
    public String monitor() {
        StringBuilder monitor = new StringBuilder();
        monitor.append("connectCount:").append(client.connectionPool().connectionCount()).append("\n");
        monitor.append("idleCount:").append(client.connectionPool().idleConnectionCount()).append("\n");
        monitor.append("threadPoolRunningCallCount:").append(client.dispatcher().runningCallsCount()).append("\n");
        monitor.append("threadPoolQueueCallCount").append(client.dispatcher().queuedCallsCount()).append("\n");

        monitor.append("maxMemory:").append(Runtime.getRuntime().maxMemory()).append("\n");
        monitor.append("totalMemory:").append(Runtime.getRuntime().totalMemory()).append("\n");
        monitor.append("freeMemory:").append(Runtime.getRuntime().freeMemory()).append("\n");

        monitor.append("requestCount:").append(requestCount.get()).append("\n");
        monitor.append("processSuccessCount:").append(processedSuccessCount.get()).append("\n");
        monitor.append("processFailedCount:").append(processFailedCount.get()).append("\n");

        return monitor.toString();
    }
}
