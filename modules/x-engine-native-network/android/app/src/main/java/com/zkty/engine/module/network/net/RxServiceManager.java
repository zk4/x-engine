package com.zkty.engine.module.network.net;

import com.zkty.nativ.network.net.rx.RxService;

/**
 * @author : MaJi
 * @time : (5/25/21)
 * dexc :
 */
public class RxServiceManager {

    //用户服务
    public static <T> T LoginServeApiFor(Class<T> clazz) {
        return RxService.createBasicApi(clazz, "/login/",false);
    }

    //IM服务
    public static <T> T IMServeApiFor(Class<T> clazz) {
        return RxService.createBasicApi(clazz, "/im-service/",true);
    }

    //日程服务
    public static <T> T ScheduleServeApiFor(Class<T> clazz) {
        return RxService.createBasicApi(clazz, "/schedule/",true);
    }

    //广告
    public static <T> T AdServeApiFor(Class<T> clazz) {
        return RxService.createBasicApi(clazz, "/ad/",false);
    }
}
