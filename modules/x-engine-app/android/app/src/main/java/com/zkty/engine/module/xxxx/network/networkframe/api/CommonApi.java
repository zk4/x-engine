package com.zkty.engine.module.xxxx.network.networkframe.api;


import com.zkty.engine.module.xxxx.dto.MicroAppInfoBean;
import com.zkty.engine.module.xxxx.network.networkframe.bean.BaseResp;
import com.zkty.engine.module.xxxx.network.networkframe.bean.TokenBean;

import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;
import retrofit2.http.Query;
import rx.Observable;


public interface CommonApi {

    /**
     * 登录接口
     *
     * @param grant_type
     * @param username
     * @param password
     * @return
     */
    @POST("token")
    Observable<BaseResp<TokenBean>> postLogin(@Query("grant_type") String grant_type,
                                              @Query("username") String username,
                                              @Query("password") String password,
                                              @Query("client_id") String client_id,
                                              @Query("client_secret") String client_secret,
                                              @Query("scope") String scope);


    @GET("microapp-service/app/{id}/microapps")
    Observable<BaseResp<MicroAppInfoBean>> getMicroAppListById(@Path("id") String id);


}
