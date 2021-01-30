package com.zkty.engine.module.xxxx.network;


import android.content.Context;
import android.text.TextUtils;

import com.alibaba.fastjson.JSON;

import com.zkty.engine.module.xxxx.network.networkframe.bean.TokenBean;
import com.zkty.modules.engine.XEngineApplication;
import com.zkty.modules.loaded.util.SharePreferenceUtils;


import java.util.List;


public class ConfigStorage {
    private static final String TAG = ConfigStorage.class.getSimpleName();

    private static final String SP_KEY_USER_INFO = "sp_user_info";
    private static final String SP_KEY_HCM_INFO = "sp_hcm_info";
    private static final String SP_KEY_TOKEN_INFO = "sp_token_info";
    private static final String SP_KEY_TOKEN_REFRESH = "sp_key_token_refresh";
    private static final String SP_KEY_JPUSH_REGISTERID = "sp_key_jpush_registerid";
    private static final String SP_KEY_DOORS = "sp_current_doors_list";
    private static final String SP_KEY_PROJECT_INFO = "sp_project_info";
    public static final String SP_KEY_QRCODE = "qr_code";
    public static final String SP_KEY_LOCATION = "sp_location_info";


    private static final String SP_KEY_SIMPLY_TOKEN = "LLBToken";
    private static final String SP_KEY_SIMPLY_REFRESH_TOKEN = "LLBRefreshToken";
    private static final String SP_KEY_LLBPROJECTID = "LLBProjectId";
    private static final String SP_KEY_LLBPROJECTNAME = "LLBProjectName";


    private static ConfigStorage configStorage;
    private Context mContext;

    public static ConfigStorage getInstance() {
        if (configStorage == null) {
            configStorage = new ConfigStorage();
        }
        return configStorage;
    }


    private ConfigStorage() {
        mContext = XEngineApplication.getApplication();
    }






    public TokenBean getTokenBean() {
        String json = (String) SharePreferenceUtils.get(mContext, true, SP_KEY_TOKEN_INFO, "{}");

        return JSON.parseObject(json, TokenBean.class);
    }


    public void saveTokenInfo(TokenBean bean) {
        if (bean != null) {
            SharePreferenceUtils.put(mContext, true, SP_KEY_TOKEN_INFO, JSON.toJSONString(bean));
            SharePreferenceUtils.put(mContext, true, SP_KEY_SIMPLY_TOKEN, !TextUtils.isEmpty(bean.getToken()) ? bean.getToken() : "");
            SharePreferenceUtils.put(mContext, true, SP_KEY_SIMPLY_REFRESH_TOKEN, !TextUtils.isEmpty(bean.getRefreshToken()) ? bean.getRefreshToken() : "");

        }
    }

    public void clearTokenInfo() {
        SharePreferenceUtils.remove(mContext, true, SP_KEY_TOKEN_INFO);
        SharePreferenceUtils.remove(mContext, true, SP_KEY_SIMPLY_TOKEN);
        SharePreferenceUtils.remove(mContext, true, SP_KEY_SIMPLY_REFRESH_TOKEN);

    }

}
