package com.zkty.nativ.network.okhttp;

import android.content.Context;

import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.net.HttpsUtil;
import com.zkty.nativ.network.net.Tls12SocketFactory;

import org.apache.http.conn.ssl.SSLSocketFactory;

import java.net.Proxy;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.SSLContext;

import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;

/**
 * okHttpClient
 */
public class OkhttpProvidede {
    static OkHttpClient okHttpClient;
    private static final int TIMEOUT_READ = 20;
    private static final int TIMEOUT_CONNECTION = 10;
    private static final HttpLoggingInterceptor interceptor = new HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY);
    private static com.zkty.nativ.network.net.CacheInterceptor cacheInterceptor = new com.zkty.nativ.network.net.CacheInterceptor();

    public static OkHttpClient okHttpClient(boolean isCheckToken) {
        if (okHttpClient == null) {
            synchronized (OkhttpProvidede.class) {
                if (okHttpClient == null) {
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


                    OkHttpClient.Builder builder = new OkHttpClient.Builder();
                    //是否拦截token
                    if (isCheckToken) {
                        builder.addInterceptor(NetworkMaster.getInstance().getTokenInterceptor());
                    }
                    //SSL证书
                    okHttpClient = builder.sslSocketFactory(new Tls12SocketFactory(sslContext.getSocketFactory()), new HttpsUtil.UnSafeTrustManager())
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

                }
            }
        }
        return okHttpClient;

    }

}
