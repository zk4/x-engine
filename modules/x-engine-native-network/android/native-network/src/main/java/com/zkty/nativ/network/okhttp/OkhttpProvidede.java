package com.zkty.nativ.network.okhttp;

import android.content.Context;
import android.util.Log;

import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.net.HttpsUtil;
import com.zkty.nativ.network.net.Tls12SocketFactory;
import com.zkty.nativ.network.utils.LogUtils;

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
    static OkHttpClient okHttpClient,okHttpClientCheckToken;
    private static final int TIMEOUT_READ = 20;
    private static final int TIMEOUT_CONNECTION = 10;
    private static final HttpLoggingInterceptor interceptor = new HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY);
    private static com.zkty.nativ.network.net.CacheInterceptor cacheInterceptor = new com.zkty.nativ.network.net.CacheInterceptor();



    public static OkHttpClient okHttpClient(boolean isCheckToken) {
        if(isCheckToken){
            return CheckToken();
        }else{
            return NotCheckToken();
        }

    }

    /**
     * 不检查token
     * @return
     */
    public static OkHttpClient NotCheckToken(){
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
                    //SSL证书
                    okHttpClient = new OkHttpClient.Builder().sslSocketFactory(new Tls12SocketFactory(sslContext.getSocketFactory()), new HttpsUtil.UnSafeTrustManager())
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


    /**
     * 检查token
     * @return
     */
    public static OkHttpClient CheckToken(){
        if (okHttpClientCheckToken == null) {
            synchronized (OkhttpProvidede.class) {
                if (okHttpClientCheckToken == null) {
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

                    //SSL证书
                    okHttpClientCheckToken = new OkHttpClient.Builder().sslSocketFactory(new Tls12SocketFactory(sslContext.getSocketFactory()), new HttpsUtil.UnSafeTrustManager())
                            //拦截token
                            .hostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER)
                            .addInterceptor(NetworkMaster.getInstance().getTokenInterceptor())
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
        return okHttpClientCheckToken;
    }

}
