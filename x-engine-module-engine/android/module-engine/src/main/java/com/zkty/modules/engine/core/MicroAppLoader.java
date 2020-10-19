package com.zkty.modules.engine.core;

import android.app.Application;
import android.content.Context;
import android.text.TextUtils;

import com.zkty.modules.engine.manager.MicroAppsManager;

import java.util.Locale;

public class MicroAppLoader {

    private static MicroAppLoader instance = null;
    private static final String TAG = MicroAppLoader.class.getSimpleName();
    private static String currentIndexPath;//F://xxxx.xxxx.xxx.0/index.html
    private static String currentRootPath;//F://xxxx.xxxx.xxx.0
    private Context mContext;
    private String currentMicroAppId;

    private MicroAppLoader() {
    }

    public static MicroAppLoader sharedInstance() {
        if (instance == null) {
            synchronized (MicroAppLoader.class) {
                if (instance == null) {
                    instance = new MicroAppLoader();
                }
            }
        }
        return instance;
    }

    public void init(Application context) {
        this.mContext = context;
    }


    /**
     * @param microAppId 微应用id
     * @return 最新版本微应用
     */
    public String getMicroAppByMicroAppId(String microAppId) {
        this.currentMicroAppId = microAppId;
        currentRootPath = MicroAppsManager.getInstance().getMicroAppPath(microAppId);
        if (currentRootPath == null) {
            currentRootPath = "file:///android_asset/ModuleApp/" + microAppId + ".0";
        }
        currentIndexPath = String.format(Locale.ENGLISH, "%s/index.html", currentRootPath);
        return currentIndexPath;

    }

    /**
     * @param microAppId 微应用id
     * @param route      路由地址
     * @return
     */
    public String getMicroAppByMicroAppId(String route, String params) {
        // getMicroAppByMicroAppId(microAppId);
        if (TextUtils.isEmpty(params)) {
            return String.format(Locale.ENGLISH, "%s#%s", currentIndexPath, route);
        }
        return String.format(Locale.ENGLISH, "%s#%s?params=%s", currentIndexPath, route, params);

    }

    /**
     * @param microAppId 微应用id
     * @param version    指定版本号
     * @return 指定版本微应用
     */
    public String getMicroAppByMicroAppId(String microAppId, int version) {
        this.currentMicroAppId = microAppId;
        currentRootPath = MicroAppsManager.getInstance().getMicroAppPath(microAppId, String.valueOf(version));
        currentIndexPath = String.format(Locale.ENGLISH, "%s/index.html", currentRootPath);
        return currentIndexPath;
    }


    public String getCurrentIndexPath() {
        return currentIndexPath;
    }

    public String getCurrentRootPath() {
        return currentRootPath;
    }

    public String getCurrentMicroAppId() {
        return currentMicroAppId;
    }
}
