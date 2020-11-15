package com.zkty.modules.loaded.jsapi;

import android.text.TextUtils;

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
                            if (item.endsWith(".wgt")) {
                                apps.add(item);
                            }
                        }
                        if (apps.size() > 0) {

                            for (int i = 0; i < apps.size(); i++) {                                 //安装微应用
                                String[] segment = apps.get(i).split("\\.");
                                String appId = segment[0];
                                try {
                                    if (!isWgtExit(appId, "1")) {
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
    private File getResourceRoot() {
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
    private File getWgtRoot() {
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
     * 获取指定wgt目录，若不存在则创建
     *
     * @return
     */
    private File createWgtPath(String appId, String version) {
        if (TextUtils.isEmpty(version)) version = "1";
        File root = new File(getWgtRoot(), appId);
        if (!root.exists()) root.mkdirs();

        File root2 = new File(root, version);
        if (!root2.exists()) root2.mkdirs();
        return root2;
    }


    /**
     * 检查指定wgt是否存在指定版本,若version为空，则不检查version
     *
     * @param
     * @return
     */
    public boolean isWgtExit(String appId, String version) {
        boolean exit = false;
        if (!TextUtils.isEmpty(appId)) {
            if (!TextUtils.isEmpty(version)) {
                File webAppDir = new File(getWgtRoot(), appId);
                if (webAppDir.exists()) {
                    File versionDir = new File(webAppDir, version);
                    if (versionDir.exists()) {
                        File appDir = new File(versionDir, appId + ".wgt");
                        if (appDir.exists()) {
                            exit = true;
                        }
                    }
                }
            } else {

                File webAppDir = new File(getWgtRoot(), appId);
                if (webAppDir.exists()) {
                    File[] versions = webAppDir.listFiles();
                    if (versions != null) {
                        int max = 0;
                        for (File f : versions) {
                            int temp = Integer.parseInt(f.getName());
                            if (temp > max) max = temp;
                        }
                        if (max > 0) {
                            File versionDir = new File(webAppDir, String.valueOf(max));
                            if (versionDir.exists()) {
                                File appDir = new File(versionDir, appId + ".wgt");
                                if (appDir.exists()) {
                                    exit = true;
                                }
                            }
                        }
                    }
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
    private void installFormAsset(InputStream asset, String appId) {
        String wgtName = appId + ".wgt";
        FileUtils.saveFile(asset, createWgtPath(appId, null), wgtName); //保存到应用目录中
    }

    /**
     * 获取wgt本地路径,若version为空，返回最高版本
     *
     * @return
     */
    public String getAssignedWgtPathById(String appId, String version) {
        String path = null;
        if (!TextUtils.isEmpty(appId)) {
            if (isWgtExit(appId, version)) {
                if (TextUtils.isEmpty(version)) {
                    File webAppDir = new File(getWgtRoot(), appId);
                    if (webAppDir.exists()) {
                        File[] versions = webAppDir.listFiles();
                        if (versions != null) {
                            int max = 0;
                            for (File f : versions) {
                                int temp = Integer.parseInt(f.getName());
                                if (temp > max) max = temp;
                            }
                            if (max > 0) {
                                File versionDir = new File(webAppDir, String.valueOf(max));
                                if (versionDir.exists()) {
                                    File appDir = new File(versionDir, appId + ".wgt");
                                    if (appDir.exists()) {
                                        path = appDir.getPath();
                                    }
                                }
                            }
                        }
                    }


                } else {
                    File appDir = new File(createWgtPath(appId, version), appId + ".wgt");
                    if (appDir.exists())
                        path = appDir.getPath();
                }
            }
        }
        return path;
    }

    /**
     * 保存下载的wgt
     *
     * @return
     */
    public String saveUniApp(InputStream inputStream, String microAppId, String version) {
        String path = null;
        if (inputStream != null && !TextUtils.isEmpty(microAppId)) {
            File temp = createWgtPath(microAppId, version);
            if (!temp.exists()) {
                temp.mkdirs();
            }
            String name = microAppId + ".wgt";
            path = FileUtils.saveFile(inputStream, temp, name);
        }
        return path;
    }

}
