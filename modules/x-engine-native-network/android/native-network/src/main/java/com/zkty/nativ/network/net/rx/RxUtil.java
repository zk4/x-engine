package com.zkty.nativ.network.net.rx;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.bean.CommonNodeResponseBaseBean;
import com.zkty.nativ.network.net.exception.ExceptionEngine;
import com.zkty.nativ.network.net.exception.RetryWhenNetworkException;
import com.zkty.nativ.network.utils.LogUtils;

import java.io.IOException;

import okhttp3.ResponseBody;
import rx.Observable;
import rx.Observable.Transformer;
import rx.android.schedulers.AndroidSchedulers;
import rx.functions.Func1;
import rx.schedulers.Schedulers;

public class RxUtil {

    /**
     * RestFull 统一返回结果处理
     *
     * @param <T>
     * @return
     */
    public static <T> Transformer<T, T> handleRestfullResult() {   //compose判断结果
        return new Transformer<T, T>() {
            @Override
            public Observable<T> call(Observable<T> httpResponseObservable) {
                return httpResponseObservable
                        .subscribeOn(Schedulers.newThread())
                        .retryWhen(new RetryWhenNetworkException())
                        .subscribeOn(Schedulers.newThread())
//                        /*异常处理*/
//                        .onErrorResumeNext(funcException)
                        /*返回数据统一判断*/
                        .map(new Func1<T, T>() {
                            @Override
                            public T call(T httpResult) {
                                return httpResult;
                            }
                        })
                        /*http请求线程*/
                        .subscribeOn(Schedulers.newThread())
                        /*回调线程*/
                        .observeOn(AndroidSchedulers.mainThread());
            }
        };
    }

    /**
     * RestFull 统一返回结果处理 for nodejs
     *
     * @return
     */
    public static Transformer<ResponseBody, ResponseBody> handleRestfullResultForNodeJs() {   //compose判断结果
        return new Transformer<ResponseBody, ResponseBody>() {
            @Override
            public Observable<ResponseBody> call(Observable<ResponseBody> httpResponseObservable) {
                return httpResponseObservable
                        .subscribeOn(Schedulers.newThread())
                        .retryWhen(new RetryWhenNetworkException())
                        .subscribeOn(Schedulers.newThread())
                        /*返回数据统一判断*/
                        .map(new Func1<ResponseBody, ResponseBody>() {
                            @Override
                            public ResponseBody call(ResponseBody responseBody) {
                                if (responseBody != null) {
                                    try {
                                        String jsonStr = new String(responseBody.bytes());
                                        CommonNodeResponseBaseBean<String> jsonObject = JSON.parseObject(jsonStr, new TypeReference<CommonNodeResponseBaseBean<String>>() {});
                                        if (jsonObject != null && jsonObject.getError() != null) {
                                            if (NetworkMaster.getInstance() != null && NetworkMaster.getInstance().getNetworkListener() != null) {
                                                NetworkMaster.getInstance().getNetworkListener().onInvalid(null);
                                                return null;
                                            } else {
                                                LogUtils.e("SmarkSdk未初始化，请在init后设置网络状态监听");
                                            }
                                        }
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                }
                                return responseBody;
                            }
                        })
                        /*http请求线程*/
                        .subscribeOn(Schedulers.newThread())
                        /*回调线程*/
                        .observeOn(AndroidSchedulers.mainThread());
            }
        };
    }

    /**
     * 异常处理
     */
    public static Func1 funcException = new Func1<Throwable, Observable>() {
        @Override
        public Observable call(Throwable throwable) {
            return Observable.error(ExceptionEngine.handleException(throwable));
        }
    };
}
