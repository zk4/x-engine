package com.zkty.engine.module.xxxx.network.service;


import com.zkty.engine.module.xxxx.network.NetworkMaster;
import com.zkty.engine.module.xxxx.network.callback.ServiceCallback;


/**
 * 作者 王磊
 * 日期 2018/7/4
 * 功能
 * 备注
 */
public class CommonService extends BaseService {

    public String MICRO_SERVE = "http://10.2.129.60:8800/";


    public String HOST_OAUTH = NetworkMaster.getInstance().getHostUrl() + "/times/auth/oauth/";

    private static CommonService mInstance;

    public static CommonService getInstance() {
        if (mInstance == null) {
            mInstance = new CommonService();

        }
        return mInstance;
    }


    public void postLogin(String grant_type, String username, String password, String clientId, String clientSecret, String scope, ServiceCallback callback) {
        CommonEngine.getInstance(this).postLogin(grant_type, username, password, clientId, clientSecret, scope, callback);
    }

    public void getMicroAppListById(String microId, ServiceCallback callback) {
        CommonEngine.getInstance(this).getMicroAppListById(microId, callback);
    }


}
