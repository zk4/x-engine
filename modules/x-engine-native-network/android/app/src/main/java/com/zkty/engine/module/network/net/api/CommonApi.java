package com.zkty.engine.module.network.net.api;


import com.zkty.nativ.network.bean.BaseResp;

import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Query;
import rx.Observable;


public interface CommonApi {


    /**
     * 获取短信验证码
     *
     * @param phoneNum
     * @return
     */
    @POST("sendSmsCode")
    Observable<BaseResp> getSmsCode(@Query("phoneNum") String phoneNum);

    /**
     * 获取首页-历史日程：已完成的日程、取消的日程。
     *
     * @param id userId
     * @return
     */
    @GET("finishList")
    Observable<BaseResp> getScheduleAccomplishedInfo();

}
