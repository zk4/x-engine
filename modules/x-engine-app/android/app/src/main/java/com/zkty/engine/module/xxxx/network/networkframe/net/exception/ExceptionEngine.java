package com.zkty.engine.module.xxxx.network.networkframe.net.exception;

import android.text.TextUtils;

import com.alibaba.fastjson.JSON;
import com.google.gson.JsonParseException;
import com.zkty.engine.module.xxxx.network.NetworkMaster;
import com.zkty.engine.module.xxxx.network.utils.LogUtils;
import com.zkty.modules.engine.utils.ToastUtils;


import org.apache.http.conn.ConnectTimeoutException;
import org.json.JSONException;

import java.io.IOException;
import java.net.ConnectException;
import java.net.SocketTimeoutException;
import java.text.ParseException;

import retrofit2.HttpException;


public class ExceptionEngine {
    //对应HTTP的状态码
    private static final int BAD_REQUEST = 400;//当前请求无法被服务器理解 或 请求参数有误
    private static final int UNAUTHORIZED = 401;//当前请求需要用户验证
    private static final int FORBIDDEN = 403;//禁止访问
    private static final int NOT_FOUND = 404;//请求URI表示的资源不存在
    private static final int NOT_ALLOWED = 405;//请求方法不被受理
    private static final int UNSUPPORTED_MEDIA_TYPE = 415;//请求媒体类型不被支持
    private static final int INTERNAL_SERVER_ERROR = 500;//服务内部发生了未处理的异常
    private static final int NOT_IMPLEMENTED = 501;//请求调用的方法未实现

    public static ApiException handleException(Throwable e) {
        ApiException ex = null;
        if (e instanceof HttpException) {             //HTTP错误
            HttpException httpException = (HttpException) e;
            try {
                ex = new ApiException(e, ErrorType.HTTP_ERROR);
                ex.errorInfo = new ApiException.ErrorInfo();
            } catch (Exception exception) {
                ToastUtils.showNormalLongToast("登录信息已过期，请重新登录。");
                if (NetworkMaster.getInstance() != null && NetworkMaster.getInstance().getNetworkListener() != null) {
//                    CommonService.getInstance().logout();
                    ex = new ApiException(exception, -1);
                    ex.errorInfo = new ApiException.ErrorInfo();
                    NetworkMaster.getInstance().getNetworkListener().onInvalid(ex);
                } else {
                    LogUtils.e("SmarkSdk未初始化，请在init后设置网络状态监听");
                }
            }
            switch (httpException.code()) {
                case BAD_REQUEST:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                        }
                        ex.errorInfo.code = BAD_REQUEST;
                        if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.error = "请求参数有误";
                        }
                    } catch (IOException e1) {
                        ex.errorInfo.code = BAD_REQUEST;
                        ex.errorInfo.error = "请求参数有误";
                        e1.printStackTrace();
                    }
                    break;
                case UNAUTHORIZED:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                        }
                        ex.errorInfo.code = UNAUTHORIZED;
                        if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.error = "登录状态异常";
                        }
                        // {"error": "invalid_access_token", "error_message": "Token not found."}
//                        if (ex.errorInfo != null && "invaild_password".equals(ex.errorInfo.error)) {
//                            //401 账户名密码错误
//                        } else if (ex.errorInfo != null && "invalid_password".equals(ex.errorInfo.error)) {
//                            //401 账户名密码错误
//                        } else {
////                            LoginManager.getInstance().logout();
//                        }
//                        else if ("".equals(ex.errorInfo.error)) {
//                            //401 token失效
//                        } else if ("".equals(ex.errorInfo.error)) {
//                            //401 token过期
//                        }
                        LogUtils.e(httpException.response().errorBody().string());
                    } catch (IOException e1) {
                        ex.errorInfo.code = UNAUTHORIZED;
                        ex.errorInfo.error = "登录状态异常";
                        e1.printStackTrace();
                    }
                    break;
                case FORBIDDEN:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                        }
                        ex.errorInfo.code = FORBIDDEN;
                        if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.error = "禁止访问";
                        }
                    } catch (IOException e1) {
                        ex.errorInfo.code = FORBIDDEN;
                        ex.errorInfo.error = "禁止访问";
                        e1.printStackTrace();
                    }
                    break;
                case NOT_FOUND:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                            ex.errorInfo.code = NOT_FOUND;
                            ex.errorInfo.error = "服务器资源未找到，请稍后再试";
                        } else if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.code = NOT_FOUND;
                            ex.errorInfo.error = "服务器资源未找到，请稍后再试";
                        }
                    } catch (IOException e1) {
                        ex.errorInfo.code = NOT_FOUND;
                        ex.errorInfo.error = "服务器资源未找到，请稍后再试";
                    }
                    break;
                case NOT_ALLOWED:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                        }
                        ex.errorInfo.code = NOT_ALLOWED;
                        if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.error = "请求方法不被受理";
                        }
                    } catch (IOException e1) {
                        ex.errorInfo.code = NOT_ALLOWED;
                        ex.errorInfo.error = "请求方法不被受理";
                        e1.printStackTrace();
                    }
                    break;
                case UNSUPPORTED_MEDIA_TYPE:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                        }
                        ex.errorInfo.code = UNSUPPORTED_MEDIA_TYPE;
                        if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.error = "请求媒体类型不被支持";
                        }
                    } catch (IOException e1) {
                        ex.errorInfo.code = UNSUPPORTED_MEDIA_TYPE;
                        ex.errorInfo.error = "请求媒体类型不被支持";
                        e1.printStackTrace();
                    }
                    break;
                case INTERNAL_SERVER_ERROR:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                        }
                        ex.errorInfo.code = INTERNAL_SERVER_ERROR;
                        if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.error = "服务器内部发生了一个未捕获的异常";
                        }
                    } catch (IOException e1) {
                        ex.errorInfo.code = INTERNAL_SERVER_ERROR;
                        ex.errorInfo.error = "服务器内部发生了一个未捕获的异常";
                        e1.printStackTrace();
                    }
                    break;
                case NOT_IMPLEMENTED:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                        }
                        ex.errorInfo.code = NOT_IMPLEMENTED;
                        if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.error = "请求调用的方法未实现";
                        }
                    } catch (IOException e1) {
                        ex.errorInfo.code = NOT_IMPLEMENTED;
                        ex.errorInfo.error = "请求调用的方法未实现";
                        e1.printStackTrace();
                    }
                    break;
                default:
                    try {
                        ex.errorInfo = JSON.parseObject(httpException.response().errorBody().string(), ApiException.ErrorInfo.class);
                        if (ex.errorInfo == null) {
                            ex.errorInfo = new ApiException.ErrorInfo();
                        }
                        ex.errorInfo.code = -1;
                        if (TextUtils.isEmpty(ex.errorInfo.error)) {
                            ex.errorInfo.error = "网络连接错误,请检查网络设置";
                        }
                    } catch (IOException e1) {
                        ex.errorInfo.code = -1;
                        ex.errorInfo.error = "网络连接错误,请检查网络设置";  //其它均视为网络错误
                        e1.printStackTrace();
                    }
                    break;
            }
            return ex;
        } else if (e instanceof ServerException) {    //服务器返回的错误
            ServerException resultException = (ServerException) e;
            ex = new ApiException(resultException, resultException.code);
            ex.errorInfo.code = resultException.code;
            ex.errorInfo.error = resultException.message;
            return ex;
        } else if (e instanceof JsonParseException
                || e instanceof JSONException
                || e instanceof ParseException) {
            ex = new ApiException(e, ErrorType.PARSE_ERROR);
            ex.errorInfo.code = ErrorType.PARSE_ERROR;
            ex.errorInfo.error = "解析错误";            //均视为解析错误
            return ex;
        } else if (e instanceof ConnectException || e instanceof SocketTimeoutException || e instanceof ConnectTimeoutException) {
            ex = new ApiException(e, ErrorType.NETWORD_ERROR);
            ex.errorInfo.code = ErrorType.NETWORD_ERROR;
            ex.errorInfo.error = "连接失败";  //均视为网络错误
            return ex;
        } else {
            ex = new ApiException(e, ErrorType.UNKNOWN);
            ex.errorInfo.code = -1;
            ex.errorInfo.code = ErrorType.UNKNOWN;
            ex.errorInfo.error = "未知错误";          //未知错误
            return ex;
        }

    }
}
