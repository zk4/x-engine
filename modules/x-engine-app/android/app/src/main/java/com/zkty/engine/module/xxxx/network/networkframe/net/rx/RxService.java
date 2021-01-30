package com.zkty.engine.module.xxxx.network.networkframe.net.rx;


import com.google.gson.Gson;
import com.zkty.engine.module.xxxx.network.networkframe.net.CacheInterceptor;
import com.zkty.engine.module.xxxx.network.networkframe.net.HttpsUtil;
import com.zkty.engine.module.xxxx.network.networkframe.net.Tls12SocketFactory;
import com.zkty.engine.module.xxxx.network.networkframe.net.TokenInterceptor;
import com.zkty.engine.module.xxxx.network.networkframe.net.converter.DecodeConverterFactory;

import org.apache.http.conn.ssl.SSLSocketFactory;

import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.SSLContext;

import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;

public class RxService {
    private static final int TIMEOUT_READ = 20;
    private static final int TIMEOUT_CONNECTION = 10;
    private static final HttpLoggingInterceptor interceptor = new HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY);
    private static CacheInterceptor cacheInterceptor = new CacheInterceptor();
    private static OkHttpClient httpClient;
    private static OkHttpClient basicClient;
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

    public static <T> T createApiFor(Class<T> clazz, String url) {
        Retrofit retrofit = new Retrofit.Builder()
                .addConverterFactory(DecodeConverterFactory.create(new Gson()))
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .client(genericClient())
                .baseUrl(url)
                .build();
        return retrofit.create(clazz);
    }

    public static <T> T createBasicApi(Class<T> clazz, String url) {
        Retrofit retrofit = new Retrofit.Builder()
                .addConverterFactory(DecodeConverterFactory.create(new Gson()))
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .client(genericBasicClient())
                .baseUrl(url)
                .build();
        return retrofit.create(clazz);
    }


    private static OkHttpClient genericClient() {
        if (httpClient != null) {
            return httpClient;
        }
        SSLContext sslContext = null;
        try {
            sslContext = SSLContext.getInstance("TLS");
            try {
                sslContext.init(null, null, null);
            } catch (KeyManagementException e) {
                e.printStackTrace();
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        httpClient = new OkHttpClient.Builder()
//                .addInterceptor(new Interceptor() {
//                    @Override
//                    public Response intercept(Chain chain) throws IOException {
//                        Request request = chain.request()
//                                .newBuilder()
//                                .addHeader("Authorization", UserManager.getInstance().getTokenBean().getTokenHead() + UserManager.getInstance().getTokenBean().getToken())
//                                .removeHeader("User-Agent")
//                                .addHeader("User-Agent", getUserAgent())
//                                .build();
//
//                        return chain.proceed(request);
//                    }
//
//                })
                //SSL证书
//                    .sslSocketFactory(TrustManager.getUnsafeOkHttpClient())
                .sslSocketFactory(new Tls12SocketFactory(sslContext.getSocketFactory()), new HttpsUtil.UnSafeTrustManager())
                .hostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER)
                .addInterceptor(new TokenInterceptor())
                //打印日志
                .addInterceptor(interceptor)
                //设置Cache
                .addNetworkInterceptor(cacheInterceptor)//缓存方面需要加入这个拦截器
                .addInterceptor(cacheInterceptor)
                //time out
                .connectTimeout(TIMEOUT_CONNECTION, TimeUnit.SECONDS)
                .readTimeout(TIMEOUT_READ, TimeUnit.SECONDS)
                .writeTimeout(TIMEOUT_READ, TimeUnit.SECONDS)
                //失败重连
                .retryOnConnectionFailure(true)
                .build();

        return httpClient;
    }

    private static OkHttpClient genericBasicClient() {
        if (basicClient != null) return basicClient;
        SSLContext sslContext = null;
        try {
            sslContext = SSLContext.getInstance("TLS");
            try {
                sslContext.init(null, null, null);
            } catch (KeyManagementException e) {
                e.printStackTrace();
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        basicClient = new OkHttpClient.Builder()
                //SSL证书
//                    .sslSocketFactory(TrustManager.getUnsafeOkHttpClient())
                .sslSocketFactory(new Tls12SocketFactory(sslContext.getSocketFactory()), new HttpsUtil.UnSafeTrustManager())
                .hostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER)
                //打印日志
                .addInterceptor(interceptor)
                //设置Cache
                .addNetworkInterceptor(cacheInterceptor)//缓存方面需要加入这个拦截器
                .addInterceptor(cacheInterceptor)
                //time out
                .connectTimeout(TIMEOUT_CONNECTION, TimeUnit.SECONDS)
                .readTimeout(TIMEOUT_READ, TimeUnit.SECONDS)
                .writeTimeout(TIMEOUT_READ, TimeUnit.SECONDS)
                //失败重连
                .retryOnConnectionFailure(true)
                .build();
        return basicClient;
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

