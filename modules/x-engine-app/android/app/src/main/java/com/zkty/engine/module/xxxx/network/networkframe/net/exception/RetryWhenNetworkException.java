package com.zkty.engine.module.xxxx.network.networkframe.net.exception;

import com.zkty.engine.module.xxxx.network.NetworkMaster;
import com.zkty.engine.module.xxxx.network.utils.LogUtils;
import com.zkty.modules.engine.utils.ToastUtils;


import rx.Observable;
import rx.functions.Func1;
import rx.functions.Func2;


public class RetryWhenNetworkException implements Func1<Observable<? extends Throwable>, Observable<?>> {

    /* retry次数*/
    private int count = 1;
    /*延迟*/
    private long delay = 100;
    /*叠加延迟*/
    private long increaseDelay = 100;

    public RetryWhenNetworkException() {

    }

    public RetryWhenNetworkException(int count, long delay) {
        this.count = count;
        this.delay = delay;
    }

    public RetryWhenNetworkException(int count, long delay, long increaseDelay) {
        this.count = count;
        this.delay = delay;
        this.increaseDelay = increaseDelay;
    }

    @Override
    public Observable<?> call(Observable<? extends Throwable> observable) {
        return observable
                .zipWith(Observable.range(1, count), new Func2<Throwable, Integer, Wrapper>() {
                    @Override
                    public Wrapper call(Throwable throwable, Integer integer) {
                        return new Wrapper(throwable, integer);
                    }
                }).flatMap(new Func1<Wrapper, Observable<?>>() {
                    @Override
                    public Observable<?> call(Wrapper wrapper) {
                        LogUtils.e(wrapper.index + "okHttp");
                        LogUtils.e(wrapper.throwable.getMessage()+"OkHttp");
                        LogUtils.e(wrapper.throwable.getCause() + "OkHttp");
                        ApiException apiException = ExceptionEngine.handleException(wrapper.throwable);
                        if ("invalid_token".equals(apiException.errorInfo.error_description)) {
                            handleError(apiException);
                            ToastUtils.showThreadToast("登录信息已过期，请重新登录。");
                        } else if ("401000021".equals(apiException.errorInfo.type)) {
                            handleError(apiException);
                            ToastUtils.showThreadToast("您的账号已在其他设备登录，请重新登录。");
                        } else if ("invalid_access_token".equals(apiException.errorInfo.error)) {
                            handleError(apiException);
                            ToastUtils.showThreadToast("您的账号已在其他设备登录，请重新登录。");
                        } else if ("expired_access_token".equals(apiException.errorInfo.error)) {
                            handleError(apiException);
                            ToastUtils.showThreadToast("登录信息已过期，请重新登录。");
                        } else if (wrapper.throwable.getMessage()!=null&&wrapper.throwable.getMessage().contains("401")) {
                            handleError(apiException);
                            ToastUtils.showThreadToast(apiException.errorInfo.error);
                        } else {
//                            return LoginManager.getInstance().refresh();
                        }
//                        if ((wrapper.throwable instanceof ConnectException
//                                || wrapper.throwable instanceof SocketTimeoutException
//                                || wrapper.throwable instanceof TimeoutException)
//                                && wrapper.index = count) { //如果超出重试次数也抛出错误，否则默认是会进入onCompleted
//                            return Observable.timer(delay + (wrapper.index - 1) * increaseDelay, TimeUnit.MILLISECONDS);
//                        }
                        return Observable.error(apiException);
                    }
                });
    }

    private class Wrapper {
        private int index;
        private Throwable throwable;

        public Wrapper(Throwable throwable, int index) {
            this.index = index;
            this.throwable = throwable;
        }
    }

    private void handleError(ApiException apiException) {
        if (NetworkMaster.getInstance() != null && NetworkMaster.getInstance().getNetworkListener() != null) {
//            CommonService.getInstance().logout();
            NetworkMaster.getInstance().getNetworkListener().onInvalid(apiException);
        } else {
            LogUtils.e("SmarkSdk未初始化，请在init后设置网络状态监听");
        }
    }

}
