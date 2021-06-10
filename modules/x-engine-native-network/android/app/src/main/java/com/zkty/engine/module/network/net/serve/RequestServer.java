package com.zkty.engine.module.network.net.serve;

import com.zkty.nativ.network.NetworkConfig;
import com.zkty.nativ.network.bean.BaseResp;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;

import java.util.HashMap;
import java.util.Map;

/**
 * @author : MaJi
 * @time : (6/2/21)
 * dexc :
 */
public class RequestServer {



    public static void getImToken(Map<String, Object> body, final ServiceCallback callback){
        NetworkServer.getInstance().sendPost("/im-service/getImToken",body,callback);;
    }


    public static void getimsessionid(Map<String, Object> body, final ServiceCallback callback){
        NetworkServer.getInstance().setBaseurl("http://larkapi.gomeuat.com.cn")
                .sendPost("/open/getimsessionid",body,callback);
    }

    public static void findByPlaceIdAndMallId(String placeId,String mallId, final ServiceCallback callback){
        NetworkServer.getInstance().sendGet(String.format("/ad/desc/findByPlaceIdAndMallId/%s/%s",placeId,mallId),new HashMap<>(),callback);;
    }


    public static void getLoginApi(Map<String, Object> body, ServiceCallback callback) {
        NetworkServer.getInstance()
                .setRequestType(NetworkConfig.REQUEST_TYPE_QUERY_MAP)
                .sendPost("/login/loginBySmsCode",body,callback);;
    }
}
