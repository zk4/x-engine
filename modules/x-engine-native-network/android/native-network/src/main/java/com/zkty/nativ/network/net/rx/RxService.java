package com.zkty.nativ.network.net.rx;


import com.google.gson.Gson;
import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.api.RetrofitHttpService;
import com.zkty.nativ.network.net.ProgressRequestBody;
import com.zkty.nativ.network.net.converter.DecodeConverterFactory;
import com.zkty.nativ.network.net.converter.StringConverterFactory;
import com.zkty.nativ.network.net.myinterface.OnDownloadListener;
import com.zkty.nativ.network.net.myinterface.OnUploadListener;
import com.zkty.nativ.network.okhttp.OkhttpProvidede;
import com.zkty.nativ.network.utils.WriteFileUtil;

import java.io.File;
import java.util.HashMap;

import okhttp3.MultipartBody;
import okhttp3.ResponseBody;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;
import rx.Observer;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

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
     * @param isCheckToekn
     * @param <T>
     * @return
     */
    public static <T> T createBasicApi(Class<T> clazz,String hostUrl,boolean isCheckToekn) {
        Retrofit retrofit = new Retrofit.Builder()
                .addConverterFactory(StringConverterFactory.create())
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .client(OkhttpProvidede.okHttpClient(isCheckToekn))
                .baseUrl(hostUrl)
                .build();
        return retrofit.create(clazz);
    }

    /**
     * 下载文件
     * @param url
     * @param filePath
     * @param onDownloadListener
     */

    public static void downLoadFile(String url, String filePath, OnDownloadListener onDownloadListener) {
        HashMap<String, String> headers = new HashMap<>();
        createBasicApi(RetrofitHttpService.class,NetworkMaster.getInstance().getHostUrl(),false)
                .Obdownload(headers,url)
                /*http请求线程*/
                .subscribeOn(Schedulers.newThread())
                /*回调线程*/
                .observeOn(Schedulers.newThread())
                .subscribe(new Observer<ResponseBody>() {
                    @Override
                    public void onCompleted() {

                    }

                    @Override
                    public void onError(Throwable e) {
                        onDownloadListener.onDownloadFailed();
                    }

                    @Override
                    public void onNext(ResponseBody responseBody) {
                        WriteFileUtil.writeFile(responseBody,filePath,onDownloadListener);
                    }
                });
    }

    /**
     * 上传文件
     * @param url
     * @param filePath
     * @param onUploadListener
     */

    public static void upLoadFile(String url, String filePath, OnUploadListener onUploadListener) {
        File file = new File(filePath);
        //封装请求体
        ProgressRequestBody uploadFileRequestBody = new ProgressRequestBody(file, onUploadListener);
        //封装文件
        MultipartBody.Part part = MultipartBody.Part.createFormData("file", file.getName(), uploadFileRequestBody);
        //创建请求
        createBasicApi(RetrofitHttpService.class,NetworkMaster.getInstance().getHostUrl(),false)
                .uploadMultipleTypeFile(url,part)
                /*http请求线程*/
                .subscribeOn(Schedulers.newThread())
                /*回调线程*/
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Observer<ResponseBody>() {
                    @Override
                    public void onCompleted() {
                    }
                    @Override
                    public void onError(Throwable e) {
                    }

                    @Override
                    public void onNext(ResponseBody responseBody) {
                    }
                });
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

