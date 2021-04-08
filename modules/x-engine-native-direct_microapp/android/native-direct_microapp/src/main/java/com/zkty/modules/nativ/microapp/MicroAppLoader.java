package com.zkty.modules.nativ.microapp;

import android.app.Application;
import android.content.Context;
import android.text.TextUtils;

import com.anthonynsimon.url.URL;
import com.anthonynsimon.url.exceptions.MalformedURLException;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

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




    public String getMicroAppHost(String host, long version) {

        return null;
    }




    /**
     * @param microAppId 微应用id
     * @param version    指定版本号
     * @return 指定版本微应用
     */
    public String getMicroAppByMicroAppIdAndVersion(String microAppId, long version) {
        this.currentMicroAppId = microAppId;
        currentRootPath = MicroAppsInstall.sharedInstance().getMicroAppPath(microAppId, version);
        currentIndexPath = String.format(Locale.ENGLISH, "%s/index.html", currentRootPath);
        return currentIndexPath;
    }


    /**
     * @param microAppId 微应用id
     * @param route      路由地址
     * @return
     */
    public String getFullRouterUrl(String route, String params) {
        // getMicroAppByMicroAppId(microAppId);
        String url = XEngineWebActivityManager.sharedInstance().getCurrent().getWebUrl();
        if (url != null & url.startsWith("http")) {
            try {
                URL base = URL.parse(url);
                StringBuilder sb = new StringBuilder();
                return sb.append(base.getScheme()).append("://").append(base.getHost()).append(base.getPath())
                        .append("#").append(route).append("?").append(params).toString();
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
        }
        XEngineWebActivity current = XEngineWebActivityManager.sharedInstance().getCurrent();
        if (TextUtils.isEmpty(params)) {
            return String.format(Locale.ENGLISH, "%s#%s", current.getIndexUrl(), route);
        }
        return String.format(Locale.ENGLISH, "%s#%s?%s", current.getIndexUrl(), route, params);

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
