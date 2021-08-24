package com.zkty.nativ.jsi.view;


import java.util.Locale;

public class MicroAppLoader {

    private static MicroAppLoader instance = null;
    private static final String TAG = MicroAppLoader.class.getSimpleName();
    private static String currentIndexPath;//F://xxxx.xxxx.xxx.0/index.html
    private static String currentRootPath;//F://xxxx.xxxx.xxx.0
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


    public String getMicroAppUrl(String host) {
        this.currentMicroAppId = host;
        currentRootPath = MicroAppsInstall.sharedInstance().getMicroAppPath(host);
        currentIndexPath = String.format(Locale.ENGLISH, "%s/index.html", currentRootPath);
        return currentIndexPath;
    }

    public String getMicroAppHostFormAssets(String host) {
        this.currentMicroAppId = host;
        currentRootPath = MicroAppsInstall.sharedInstance().getMicroAppPath(host);
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
