package com.zkty.modules.nativ.jsi.view;

import android.app.Application;
import android.content.Context;
import android.text.TextUtils;

import com.anthonynsimon.url.URL;
import com.anthonynsimon.url.exceptions.MalformedURLException;

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
