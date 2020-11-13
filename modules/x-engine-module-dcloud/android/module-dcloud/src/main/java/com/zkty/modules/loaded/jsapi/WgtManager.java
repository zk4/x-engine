package com.zkty.modules.loaded.jsapi;

import android.text.TextUtils;
import android.util.Log;

import com.zkty.modules.engine.XEngineApplication;
import com.zkty.modules.engine.utils.FileUtils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

public class WgtManager {
    private static final String TAG = WgtManager.class.getSimpleName();

    private static final String ROOT = "x-engine-dir";
    private static final String ASSET_WGTS_DIR = "wgts";//wgt包目录


    private static WgtManager INSTANCE;

    public void init() {
        initResourceDir();
        preInstallAssets();
    }

    private WgtManager() {
    }

    public static WgtManager getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new WgtManager();
        }
        return INSTANCE;
    }

    /**
     * 预安装asset中的wgt
     */
    private void preInstallAssets() {
        try {
            String[] files = XEngineApplication.getApplication().getAssets().list(ASSET_WGTS_DIR);
            if (files != null && files.length > 0) {

                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        ArrayList<String> apps = new ArrayList<>();
                        for (int i = 0; i < files.length; i++) {                //过滤所有符合微应用命名的zip安装包
                            String item = files[i];
                            if (item.endsWith("wgt")) {
                                apps.add(item);
                            }
                        }
                        if (apps.size() > 0) {

                            for (int i = 0; i < apps.size(); i++) {                                 //安装微应用
                                String[] segment = apps.get(i).split("\\.");
                                String appId = segment[0];
                                try {
                                    if (!WgtManager.getInstance().isWgtExit(appId)) {
                                        InputStream inputStream = XEngineApplication.getApplication().getAssets().open(ASSET_WGTS_DIR + "/" + apps.get(i));
                                        installFormAsset(inputStream, appId);
                                    }
                                } catch (IOException e) {

                                }
                            }
                        }
                    }
                }).start();
            }
        } catch (IOException e) {

        }
    }

    private void initResourceDir() {
        File temp = new File(XEngineApplication.getApplication().getFilesDir(), ROOT);
        if (!temp.exists()) {
            if (temp.mkdirs()) {
                File temp1 = new File(temp, ASSET_WGTS_DIR);
                if (!temp1.exists()) {
                    temp1.mkdirs();
                }
            }
        }
    }

    /**
     * 获取资源根目录
     *
     * @return
     */
    public File getResourceRoot() {
        File root = null;
        File temp = new File(XEngineApplication.getApplication().getFilesDir(), ROOT);
        if (!temp.exists()) {
            if (temp.mkdir()) {
                root = temp;
            }
        } else {
            root = temp;
        }
        return root;
    }

    /**
     * 获取wgt根目录
     *
     * @return
     */
    public File geWgtRoot() {
        File temp = null;
        File root = new File(getResourceRoot(), ASSET_WGTS_DIR);
        if (!root.exists()) {
            if (root.mkdirs()) {
                temp = root;
            }
        } else {
            temp = root;
        }
        return temp;
    }


    /**
     * 检查指定wgt是否存在
     *
     * @param microAppId
     * @return
     */
    public boolean isWgtExit(String microAppId) {
        boolean exit = false;
        if (!TextUtils.isEmpty(microAppId)) {
            File webAppDir = geWgtRoot();
            if (webAppDir.exists()) {                                           //微应用集合目录是否存在
                File appDir = new File(webAppDir, microAppId + ".wgt");
                if (appDir.exists()) {                                          //指定的微应用是否存在
                    exit = true;
                }
            }
        }
        return exit;
    }

    /**
     * @param asset
     * @param appId
     * @return
     */
    public void installFormAsset(InputStream asset, String appId) {
        String wgtName = appId + ".wgt";
        FileUtils.saveFile(asset, geWgtRoot(), wgtName); //保存到应用目录中
    }

    /**
     * 获取wgt本地路径
     *
     * @return
     */
    public String getWgtPath(String appId) {
        String path = null;
        if (!TextUtils.isEmpty(appId)) {
            if (isWgtExit(appId)) {
                File appVersionPath = new File(geWgtRoot(), appId + ".wgt");
                path = appVersionPath.getPath();
            }
        }
        return path;
    }
}
