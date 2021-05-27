package com.zkty.engine.module.network.net.api;

import com.zkty.nativ.network.bean.BaseResp;

import retrofit2.http.GET;
import rx.Observable;

/**
 * @author : MaJi
 * @time : (5/27/21)
 * dexc :日程服务
 */
public interface ScheduleApi {
    /**
     * 获取首页-历史日程：已完成的日程、取消的日程。
     *
     * @param id userId
     * @return
     */
    @GET("finishList")
    Observable<BaseResp> getScheduleAccomplishedInfo();
}
