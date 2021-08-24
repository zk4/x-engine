package com.zkty.nativ.jsi.view;

import android.app.Application;
import android.content.Context;
import android.text.TextUtils;
import android.util.JsonReader;
import android.util.Log;


import com.alibaba.fastjson.JSON;
import com.zkty.nativ.jsi.MicroAppJsonDto;
import com.zkty.nativ.jsi.utils.FileUtils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import static com.zkty.nativ.core.utils.Utils.isNumeric;


/**
 * microapp 安装及卸载管理类
 */
public class MicroAppsInstall {
    private static final String TAG = MicroAppsInstall.class.getSimpleName();

    private static final String ROOT = "x-engine-dir";
    private static final String ASSET_APPS_DIR = "moduleApps";
    private static final String MICRO_APPS_ROOT = "microApps";       //microApp安装包目录，目录下每个微应用按照微应用包名建目录，微应用目录下包含此应用的各版本目录


    private static Context context;
    private static MicroAppsInstall INSTANCE;


    /**
     * 微应用集合目录结构
     * --webapp
     * ----------{appId0}.{packageName0}    <=> microAppId(微应用0)
     * -----------------{appId0}.{packageName0}.{version0}(微应用0版本0)
     * -------------------------index.html
     * --------------------------main.js
     * --------------------------main.js.map
     * -----------------{appId1}.{packageName1}.{version1}(微应用0版本1)
     * -------------------------index.html
     * -------------------------main.js
     * -------------------------main.js.map
     * -----------------....
     * -----------------...
     * ----------{appId1}.{packageName1}    <=> microAppId(微应用1)
     * ----------------{appId1}.{packageName1}.{version0}(微应用1版本0)
     * -------------------------index.html
     * -------------------------main.js
     * -------------------------main.js.map
     * ----------------{appId1}.{packageName1}.{version1}(微应用1版本1)
     * ------------------------index.html
     * ------------------------main.js
     * ------------------------main.js.map
     * -----------------...
     * -----------------...
     * ---------...
     * ---------...
     */


    private MicroAppsInstall() {
    }

    public static MicroAppsInstall sharedInstance() {
        if (INSTANCE == null) {
            synchronized (MicroAppLoader.class) {
                if (INSTANCE == null) {
                    INSTANCE = new MicroAppsInstall();
                }
            }
        }
        return INSTANCE;
    }

    public void init(Application context) {
        this.context = context;
        initResourceDir();
        preInstallAssets();


    }

    /**
     * 预安装asset中的微应用
     */
    private void preInstallAssets() {
        try {
            String[] files = context.getAssets().list(ASSET_APPS_DIR);
            if (files != null && files.length > 0) {
                Log.d(TAG, "microApps has apps, count:" + files.length);
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        ArrayList<String> apps = new ArrayList<>();
                        for (String file : files) {                //不再校验微应用名字,只要压缩包默认都需要解压判断
                            if (file.endsWith(".zip")) {
                                apps.add(file);
                            }
                        }
                        if (apps.size() > 0) {
                            Log.d(TAG, "recognize apps count: " + apps.size());
                            for (String app : apps) {                                 //安装微应用
                                try {
                                    Log.d(TAG, "start install apps:" + app);
                                    InputStream inputStream = context.getAssets().open(ASSET_APPS_DIR + "/" + app);
                                    installFormAsset(inputStream, app);

                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                        } else {
                            Log.d(TAG, "recognize apps count: 0");
                        }
                    }
                }).start();
            } else {
                Log.d(TAG, "microApps dir is empty!");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void initResourceDir() {
        File temp = new File(context.getFilesDir(), ROOT);
        if (!temp.exists()) {
            if (temp.mkdirs()) {
                File temp1 = new File(temp, MICRO_APPS_ROOT);
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
        if (context != null) {
            File temp = new File(context.getFilesDir(), ROOT);
            if (!temp.exists()) {
                if (temp.mkdir()) {
                    root = temp;
                }
            } else {
                root = temp;
            }
        } else {
            throw new Error(ROOT + " context is null, you must init the class!");
        }
        return root;
    }

    /**
     * 获取微应用根目录
     *
     * @return
     */
    private File getWebAppRoot() {
        File temp = null;
        File root = new File(getResourceRoot(), MICRO_APPS_ROOT);
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
     * 检查指定应用是否存在
     *
     * @param microAppId
     * @return
     */
    private boolean isMicroAppExit(String microAppId) {
        boolean exit = false;
        if (!TextUtils.isEmpty(microAppId)) {
            File webAppDir = getWebAppRoot();
            if (webAppDir.exists()) {                                           //微应用集合目录是否存在
                File appDir = new File(webAppDir, microAppId);
                if (appDir.exists()) {                                          //指定的微应用是否存在
                    exit = true;
                }
            }
        }
        return exit;
    }


    /**
     * 获取应用的本地路径
     *
     * @param microAppId
     * @return null 或 微应用的最高版本目录
     */
    public String getMicroAppPath(String microAppId) {
        String path = null;
        if (!TextUtils.isEmpty(microAppId)) {
            if (isMicroAppExit(microAppId)) {
                path = String.format("%s%s%s", getWebAppRoot().getPath(), File.separator, microAppId);
            }
        }
        return path;
    }


    /**
     * 安装微应用
     *
     * @param file
     * @return
     */
    private boolean installApp(File file) {
        boolean success = false;
        if (FileUtils.doUnzip(file.getParentFile(), file.getName())) {
            String path = file.getPath();
            if (path.endsWith(".zip")) path = path.substring(0, path.length() - 4);
            File micro = new File(path);
            if (micro.exists()) {
                File microJson = new File(micro, "microapp.json");
                File sitemapJson = new File(micro, "sitemap.json");
                if (microJson.exists() && sitemapJson.exists()) {
                    try {
                        MicroAppJsonDto microAppJsonDto = JSON.parseObject(new FileInputStream(microJson), MicroAppJsonDto.class);
                        if (microAppJsonDto != null && microAppJsonDto.getId() != null) {
                            micro.renameTo(new File(getWebAppRoot().getPath() + File.separator + microAppJsonDto.getId()));
                            success = true;
                        }

                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (micro.exists())
                    micro.delete();
            }


        }
        FileUtils.deleteFile(file);
        return success;
    }

    /**
     * 卸载指定应用
     *
     * @param microAppId
     */
    public void uninstallApp(String microAppId) {
        File app = new File(getWebAppRoot(), microAppId);
        if (app.exists()) {
            FileUtils.deleteFile(app);
        }
    }

    /**
     * @param asset
     * @param fileName
     * @return
     */
    private boolean installFormAsset(InputStream asset, String fileName) {
        boolean success = false;

        String path = FileUtils.saveFile(asset, getWebAppRoot(), fileName);                 //先保存到应用目录中
        if (!TextUtils.isEmpty(path)) {
            success = installApp(new File(getWebAppRoot(), fileName));         //再安装应用
            if (success) {
                Log.d(TAG, "install success :" + fileName);
            } else {
                Log.d(TAG, "install failed :" + fileName);
            }
        } else {
            Log.d(TAG, "save path null");
        }
        return success;
    }


}
