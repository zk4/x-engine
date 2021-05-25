package com.zkty.nativ.network.net.rx;


import com.google.gson.Gson;
import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.net.converter.DecodeConverterFactory;
import com.zkty.nativ.network.okhttp.OkhttpProvidede;

import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;

public class RxService {

    private static RxService instance;

    public static RxService getInstance() {
        if (instance == null) {
            synchronized (RxService.class) {
                if (instance == null) {
                    instance = new RxService();
                }
            }
        }
        return instance;
    }

    /**
     * 创建 Retrofit
     * @param clazz
     * @param serverUrl
     * @param isCheckToekn
     * @param <T>
     * @return
     */
    public static <T> T createBasicApi(Class<T> clazz, String serverUrl,boolean isCheckToekn) {
        Retrofit retrofit = new Retrofit.Builder()
                .addConverterFactory(DecodeConverterFactory.create(new Gson()))
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .client(OkhttpProvidede.okHttpClient(isCheckToekn))
                .baseUrl(NetworkMaster.getInstance().getHostUrl() + serverUrl)
                .build();
        return retrofit.create(clazz);
    }



    private static String getUserAgent() {
        String userAgent;
        userAgent = System.getProperty("http.agent");
        StringBuilder sb = new StringBuilder();
        for (int i = 0, length = userAgent.length(); i < length; i++) {
            char c = userAgent.charAt(i);
            if (c <= '\u001f' || c >= '\u007f') {
                sb.append(String.format("\\u%04x", (int) c));
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }

}

