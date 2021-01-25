package com.zkty.engine.module.xxxx.network.service;



import com.zkty.engine.module.xxxx.network.NetworkMaster;
import com.zkty.engine.module.xxxx.network.callback.ServiceCallback;
import com.zkty.engine.module.xxxx.network.networkframe.bean.CommonNodeResponseBaseBean;
import com.zkty.engine.module.xxxx.network.networkframe.net.exception.ApiException;
import com.zkty.engine.module.xxxx.network.utils.LogUtils;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;

import okhttp3.ResponseBody;

public class BaseService {

    public boolean checkRequestResult(ResponseBody responseBody) {
        if (responseBody != null) {
            try {
                String jsonStr = new String(responseBody.bytes());
                JSONObject jsonObject = new JSONObject(jsonStr);
                if (jsonObject.isNull("error")) {
                    // 请求成功
                    return true;
                } else {
                    // 请求失败
                    return false;
                }
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            } catch (JSONException e) {
                e.printStackTrace();
                return false;
            }
        } else {
            return false;
        }
    }

    public JSONObject getRequestResult(ResponseBody responseBody) {
        try {
            String jsonStr = new String(responseBody.bytes());
            JSONObject jsonObject = new JSONObject(jsonStr);
            return jsonObject.getJSONObject("result");
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    public JSONObject getRequestError(ResponseBody responseBody) {
        try {
            String jsonStr = new String(responseBody.bytes());
            JSONObject jsonObject = new JSONObject(jsonStr);
            return jsonObject.getJSONObject("error");
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    public void handlerThrowable(Throwable throwable, ServiceCallback callback) {
        if (throwable instanceof ApiException) {
            callback.onError((ApiException) throwable);
        } else {
            LogUtils.e(throwable.getMessage(), throwable);
        }
    }

    public void handlerThrowable(CommonNodeResponseBaseBean errorBean, ServiceCallback callback) {
        ApiException apiException = new ApiException();
        if (errorBean != null && errorBean.getError() != null) {
            // token失效
            // {"jsonrpc":"2.0","id":1,"error":{"code":-32401,"message":"jwt verify failed","data":"jwt expired"}}
            if (errorBean.getError().getCode() == -32401) {
                if (NetworkMaster.getInstance() != null && NetworkMaster.getInstance().getNetworkListener() != null) {
                    NetworkMaster.getInstance().getNetworkListener().onInvalid(null);
                } else {
                    LogUtils.e("SmarkSdk未初始化，请在init后设置网络状态监听");
                }
            } else {
                apiException.errorInfo.code = errorBean.getError().getCode();
                apiException.errorInfo.error = errorBean.getError().getMessage();
                callback.onError(apiException);
            }
        } else {
            apiException.errorInfo.code = -1;
            apiException.errorInfo.error = "未知异常";
            callback.onError(apiException);
        }
    }

    public void handlerThrowable(JSONObject errorJson, ServiceCallback callback) {
        ApiException apiException = new ApiException();
        if (errorJson != null) {
            try {
                apiException.errorInfo.code = (int) errorJson.getJSONObject("error").get("code");
                apiException.errorInfo.error = (String) errorJson.getJSONObject("error").get("message");
                callback.onError(apiException);
            } catch (JSONException e) {
                e.printStackTrace();
                apiException.errorInfo.code = -1;
                apiException.errorInfo.error = "json解析异常";
                callback.onError(apiException);
            }
        } else {
            apiException.errorInfo.code = -1;
            apiException.errorInfo.error = "未知异常";
            callback.onError(apiException);
        }
    }
}
