package com.zkty.nativ.network;

import android.content.Context;

import com.zkty.nativ.network.api.RetrofitHttpService;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.ProgressRequestBody;
import com.zkty.nativ.network.net.exception.ApiException;
import com.zkty.nativ.network.net.myinterface.Inetwork;
import com.zkty.nativ.network.net.myinterface.OnDownloadListener;
import com.zkty.nativ.network.net.myinterface.OnUploadListener;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;
import com.zkty.nativ.network.net.rx.RxService;
import com.zkty.nativ.network.net.rx.RxUtil;
import com.zkty.nativ.network.utils.GsonUtil;
import com.zkty.nativ.network.utils.LogUtils;
import com.zkty.nativ.network.utils.WriteFileUtil;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import okhttp3.Callback;
import okhttp3.Interceptor;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;
import rx.Observable;
import rx.Observer;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;


public class NetworkMaster  implements Inetwork {
    private static NetworkMaster mInstance;
    private static Context mContext;
    //接口host地址
    private static String hostUrl;
    //网络监听
    private NetworkListener networkListener;
    //网络拦截
    private static List<Interceptor> interceptorList = new ArrayList<>();

    public static NetworkMaster getInstance() {
        if (mInstance == null) {
            throw new NullPointerException("请初始化 NetworkMaster");
        }
        return mInstance;
    }

    public NetworkMaster(Context mContext,  String hostUrl,  List<Interceptor> interceptorList) {
        NetworkMaster.mContext = mContext;
        NetworkMaster.hostUrl = hostUrl;
        NetworkMaster.interceptorList.clear();
        NetworkMaster.interceptorList.addAll(interceptorList);

    }

    public static Context getContext() {
        return mContext;
    }

    public void setNetworkLinstener(NetworkListener linstener) {
        this.networkListener = linstener;
    }

    public NetworkListener getNetworkListener() {
        return networkListener;
    }


    public String getHostUrl() {
        return hostUrl;
    }

    public static List<Interceptor> getInterceptorList() {
        return interceptorList;
    }

    public static void setInterceptorList(List<Interceptor> interceptorList) {
        NetworkMaster.interceptorList = interceptorList;
    }


    public interface NetworkListener {
        void onInvalid(ApiException apiException);

        void onError();
    }


    public static class SingletonBuilder {
        private Context mContext;
        private String hostUrl;
        private List<Interceptor> interceptorList = new ArrayList<>();

        public SingletonBuilder(Context context) {
            mContext = context.getApplicationContext();
        }

        public SingletonBuilder setHostUrl(String hostUrl) {
            this.hostUrl = hostUrl;
            return this;
        }
        public SingletonBuilder setInterceptor(Interceptor interceptor) {
            this.interceptorList.add(interceptor);
            return this;
        }

        public NetworkMaster build() {
            mInstance = new NetworkMaster(mContext,hostUrl,interceptorList);
            return mInstance;
        }

    }


    /**
     * 错误日志处理
     * @param throwable
     * @param callback
     */
    public void handlerThrowable(Throwable throwable, ServiceCallback callback) {
        if (throwable instanceof ApiException) {
            callback.onError((ApiException) throwable);
        } else {
            LogUtils.e(throwable.getMessage(), throwable);
        }
    }

    /**
     * post 请求
     * @param requestType  请求类型
     * @param baseUrl
     * @param url //请求地址方法名
     * @param params
     * @param heads
     * @param isIntercepToken
     * @param callback
     */
    @Override
    public void post(String requestType, String baseUrl, String url, Map<String, Object> params, Map<String, String> heads, boolean isIntercepToken, ServiceCallback callback) {
        params = params == null ? new HashMap<>() : params;
        heads = heads == null ? new HashMap<>() : heads;

        RetrofitHttpService retrofitHttpService = RxService.createBasicApi(RetrofitHttpService.class, baseUrl, isIntercepToken);
        //默认body请求
        Observable<String> observable = retrofitHttpService.ObpostBody(url, params, heads);
        if(requestType.equals(NetworkConfig.REQUEST_TYPE_BODY)){
            observable = retrofitHttpService.ObpostBody(url, params, heads);
        }else if(requestType.equals(NetworkConfig.REQUEST_TYPE_QUERY_MAP)){
            observable = retrofitHttpService.ObpostQueryMap(url, params, heads);
        }else if(requestType.equals(NetworkConfig.REQUEST_TYPE_FILE_MAP)){
            observable = retrofitHttpService.ObpostFileMap(url, params, heads);
        }
        observable.compose(RxUtil.<String>handleRestfullResult())
                .subscribe(new Observer<String>() {
                    @Override
                    public void onCompleted() {
                    }

                    @Override
                    public void onError(Throwable e) {
                        handlerThrowable(e,callback);
                    }

                    @Override
                    public void onNext(String s) {
                        BaseResp baseResp = GsonUtil.fromJson(s,BaseResp.class);
//                        JSONObject jsonObject = JSON.parseObject(s);
//                        Class caClass = jsonObject.toJavaObject(Class.class);
                        if(null == callback) return;
                        callback.onSuccess(baseResp);
                    }
                });
    }

    /**
     * get请求
     * @param requestType  请求类型
     * @param baseUrl
     * @param url //请求地址方法名
     * @param params
     * @param heads
     * @param isIntercepToken
     * @param callback
     */
    @Override
    public void get(String requestType, String baseUrl, String url, Map<String, Object> params, Map<String, String> heads, boolean isIntercepToken, ServiceCallback callback) {
        params = params == null ? new HashMap<>() : params;
        heads = heads == null ? new HashMap<>() : heads;
        RetrofitHttpService retrofitHttpService = RxService.createBasicApi(RetrofitHttpService.class, baseUrl, isIntercepToken);
        //默认body请求
        retrofitHttpService.Obget(url, params, heads).compose(RxUtil.<String>handleRestfullResult())
                .subscribe(new Observer<String>() {
                    @Override
                    public void onCompleted() {
                    }

                    @Override
                    public void onError(Throwable e) {
                        handlerThrowable(e,callback);
                    }

                    @Override
                    public void onNext(String s) {
                        BaseResp baseResp = GsonUtil.fromJson(s,BaseResp.class);

                        if(null == callback) return;
                        callback.onSuccess(baseResp);
                    }
                });
    }

    /**
     * 下载文件
     * @param url
     * @param filePath
     * @param callback
     */
    @Override
    public void download(String url, String filePath, OnDownloadListener callback) {
        Request request = new Request.Builder().url(url).build();
        new OkHttpClient().newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(okhttp3.Call call, IOException e) {
                // 下载失败
                WriteFileUtil.mHandler.post(() -> callback.onDownloadFailed());
            }
            @Override
            public void onResponse(okhttp3.Call call, Response response) throws IOException {
                WriteFileUtil.writeFile(response.body(),filePath,callback);
            }
        });
    }

    /**
     * 上传文件
     * @param url
     * @param filePath
     * @param callback
     */
    @Override
    public void upload(String url, String filePath, OnUploadListener callback) {
        File file = new File(filePath);
        //封装请求体
        ProgressRequestBody uploadFileRequestBody = new ProgressRequestBody(file, callback);
        //封装文件
        MultipartBody.Part part = MultipartBody.Part.createFormData("file", file.getName(), uploadFileRequestBody);

//        Request request = new Request.Builder()
//                .header("Authorization", "Client-ID " + UUID.randomUUID())
//                .url(url)
//                .post(uploadFileRequestBody)
//                .build();
//
//        new OkHttpClient().newCall(request).enqueue(new Callback() {
//            @Override
//            public void onFailure(okhttp3.Call call, IOException e) {
//                // 下载失败
//                WriteFileUtil.mHandler.post(() -> callback.onUploadFailed());
//            }
//            @Override
//            public void onResponse(okhttp3.Call call, Response response) throws IOException {
//            }
//        });

        //创建请求
        RxService.createBasicApi(RetrofitHttpService.class,NetworkMaster.getInstance().getHostUrl(),false)
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
                        callback.onUploadFailed();
                    }

                    @Override
                    public void onNext(ResponseBody responseBody) {
                    }
                });
    }
}
