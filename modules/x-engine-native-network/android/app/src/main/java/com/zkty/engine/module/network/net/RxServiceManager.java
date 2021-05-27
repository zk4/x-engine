package com.zkty.engine.module.network.net;

import com.zkty.engine.module.network.net.api.AdApi;
import com.zkty.engine.module.network.net.api.CommonApi;
import com.zkty.engine.module.network.net.api.ImApi;
import com.zkty.engine.module.network.net.api.LoginApi;
import com.zkty.engine.module.network.net.api.ScheduleApi;
import com.zkty.engine.module.network.net.api.ServiceApi;
import com.zkty.nativ.network.NetworkMaster;
import com.zkty.nativ.network.net.rx.RxService;

/**
 * @author : MaJi
 * @time : (5/25/21)
 * dexc :
 */
public class RxServiceManager {

    //用户服务
    public static LoginApi LoginServeApiFor() {
        return RxService.createBasicApi(LoginApi.class, NetworkMaster.getInstance().getHostUrl() ,"/login/",false);
    }

    //IM服务
    public static ImApi IMServeApiFor() {
        return RxService.createBasicApi(ImApi.class, NetworkMaster.getInstance().getHostUrl(),"/im-service/",true);
    }

    //日程服务
    public static ScheduleApi ScheduleServeApiFor() {
        return RxService.createBasicApi(ScheduleApi.class, NetworkMaster.getInstance().getHostUrl(),"/schedule/",true);
    }

    //广告
    public static AdApi AdServeApiFor() {
        return RxService.createBasicApi(AdApi.class, NetworkMaster.getInstance().getHostUrl(),"/ad/",false);
    }

    //客服
    public static ServiceApi SerivceServeApiFor() {
        return RxService.createBasicApi(ServiceApi.class, "http://larkapi.gomeuat.com.cn","/open/",false);
    }
}
