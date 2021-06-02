package com.zkty.engine.module.network.net.serve;

import com.zkty.nativ.network.NetworkConfig;
import com.zkty.nativ.network.net.myinterface.ServiceCallback;

import java.util.Map;

/**
 * @author : MaJi
 * @time : (6/2/21)
 * dexc :
 */
public class RequestServer {




    public static void getImToken(Map<String, Object> body, final ServiceCallback callback){
        NetworkServer.getInstance()
                .setRequestType(NetworkConfig.REQUEST_TYPE_BODY)
                .setBaseurl("http://10.115.91.71:32383")
                .setUrl("/im-service/getImToken")
                .setParams(body)
                .setCallback(callback)
                .post();
    }
}
