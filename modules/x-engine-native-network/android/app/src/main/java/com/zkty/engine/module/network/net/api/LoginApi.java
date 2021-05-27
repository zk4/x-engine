package com.zkty.engine.module.network.net.api;

import com.zkty.nativ.network.bean.BaseResp;

import retrofit2.http.POST;
import retrofit2.http.Query;
import rx.Observable;

/**
 * @author : MaJi
 * @time : (5/27/21)
 * dexc : 登陆服务
 */
public interface LoginApi {
    /**
     * 获取短信验证码
     *
     * @param phoneNum
     * @return
     */
    @POST("sendSmsCode")
    Observable<BaseResp> getSmsCode(@Query("phoneNum") String phoneNum);
}
