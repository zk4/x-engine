package com.zkty.engine.module.network.net;

import android.os.Environment;
import android.os.FileUtils;

import com.zkty.engine.module.network.callback.DownloadCallBack;

import org.apache.http.conn.ssl.SSLSocketFactory;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.Interceptor;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okhttp3.internal.cache.CacheInterceptor;
import okhttp3.logging.HttpLoggingInterceptor;

public class OkHttpManager {
    private static OkHttpManager instance;
    private OkHttpClient httpClient;

    private static final int TIMEOUT_READ = 20;
    private static final int TIMEOUT_CONNECTION = 10;

    private static final HttpLoggingInterceptor interceptor = new HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY);


    private OkHttpManager() {
        httpClient = getClient();
    }

    public static OkHttpManager getInstance() {
        if (instance == null) {
            synchronized (OkHttpManager.class) {
                if (instance == null) {
                    instance = new OkHttpManager();
                }
            }
        }
        return instance;
    }

    public OkHttpClient getClient() {
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
                .addInterceptor(new Interceptor() {
                    @Override
                    public Response intercept(Chain chain) throws IOException {
                        Request request = chain.request()
                                .newBuilder()
//                                    .addHeader("Authorization", "Basic MDAwYWY4ZjBhYmMwMDAwMDoxK1Q2VHl5V3l3VUVDMC9DMVlXcVoxVXQ=")
//                                    .removeHeader("User-Agent")
                                .build();


                        return chain.proceed(request);
                    }

                })
                //SSL证书
//                .sslSocketFactory(new Tls12SocketFactory(sslContext.getSocketFactory()), new HttpsUtil.UnSafeTrustManager())
                .hostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER)
//                    .addInterceptor(new TokenInterceptor())
                //打印日志
                .addInterceptor(interceptor)
                //设置Cache
//                .addNetworkInterceptor(cacheInterceptor)//缓存方面需要加入这个拦截器
//                .addInterceptor(cacheInterceptor)
                //.cache(HttpCache.getCache())
                //time out
                .connectTimeout(TIMEOUT_CONNECTION, TimeUnit.SECONDS)
                .readTimeout(TIMEOUT_READ, TimeUnit.SECONDS)
                .writeTimeout(TIMEOUT_READ, TimeUnit.SECONDS)
                //失败重连
                .retryOnConnectionFailure(true)
                .build();

        return httpClient;

    }

    //异步 get
    public void asyncGet(String url, Callback callback) {

        Request request = new Request.Builder()
                .url(url)
                .get()
                .build();
        httpClient.newCall(request).enqueue(callback);


    }

    //异步 post
    public void asyncPost(String url, String params, Callback callback) {

        MediaType mediaType = MediaType.parse("text/x-markdown; charset=utf-8");

        Request request = new Request.Builder()
                .url(url)
                .post(RequestBody.create(params, mediaType))
                .build();
        httpClient.newCall(request).enqueue(callback);


    }

    public void download(final String url, final DownloadCallBack callback) {

        final long startTime = System.currentTimeMillis();


        Request request = new Request.Builder()
                .url(url)
                .addHeader("Connection", "close")
                .build();
        httpClient.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                e.printStackTrace();
                callback.onFailure(call, e);
            }

            @Override
            public void onResponse(Call call, Response response) throws IOException {
                InputStream is = null;
                byte[] buf = new byte[2048];
                int len = 0;
                FileOutputStream fos = null;
                // 储存下载文件的目录
                String savePath = Environment.getExternalStorageDirectory().getAbsolutePath() + "/mapdata/download";
                File saveFile = new File(savePath);
                if (!saveFile.exists()) {
                    saveFile.mkdirs();
                }
                try {
                    is = response.body().byteStream();
                    long total = response.body().contentLength();
                    File file = new File(savePath, url.substring(url.lastIndexOf("/") + 1));
                    fos = new FileOutputStream(file);
                    long sum = 0;
                    while ((len = is.read(buf)) != -1) {
                        fos.write(buf, 0, len);
                        sum += len;
                        int progress = (int) (sum * 1.0f / total * 100);

                    }
                    fos.flush();
                    callback.onResponse(call, response, file.getPath());

                } catch (IOException e) {
                    e.printStackTrace();
                    callback.onFailure(call, e);

                } finally {
                    try {
                        if (is != null)
                            is.close();
                    } catch (IOException e) {
                    }
                    try {
                        if (fos != null)
                            fos.close();
                    } catch (IOException e) {
                    }
                }
            }
        });
    }


    //同步get
//    public Response syncGet(String url) {
//        final Request request = new Request.Builder().url(url).get().build();
//        final Call call = httpClient.newCall(request);
//        new Thread(new Runnable() {
//            @Override
//            public void run() {
//                try {
//                    Response response =  call.execute();
//
//                } catch (Exception e) {
//
//                }
//
//            }
//        }).start();
//
//    }

}
