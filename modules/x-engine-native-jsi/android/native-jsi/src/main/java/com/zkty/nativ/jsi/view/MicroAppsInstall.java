package com.zkty.nativ.jsi.view;

import android.app.Application;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;


import com.zkty.nativ.jsi.utils.FileUtils;

import java.io.File;
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
                        for (int i = 0; i < files.length; i++) {                //过滤所有符合微应用命名的zip安装包
                            String item = files[i];
                            String[] segment = item.split("\\.");
                            if (segment != null && segment.length > 3 && segment[segment.length - 1].equals("zip") && isNumeric(segment[segment.length - 2])) {
                                apps.add(item);
                            }
                        }
                        if (apps.size() > 0) {
                            Log.d(TAG, "recognize apps count: " + apps.size());
                            for (int i = 0; i < apps.size(); i++) {                                 //安装微应用
                                String[] segment = apps.get(i).split("\\.");

                                StringBuilder stringBuilder = new StringBuilder();
                                for (int j = 0; j < segment.length - 2; j++) {
                                    stringBuilder.append(segment[j]);
                                    if (j != segment.length - 3) {
                                        stringBuilder.append(".");
                                    }
                                }
                                String app = stringBuilder.toString();


                                try {
                                    long version = Long.parseLong(segment[segment.length - 2]);
                                    if (!isMicroAppExit(app, version)) {
                                        Log.d(TAG, "start install apps:" + app + "." + version);
                                        InputStream inputStream = context.getAssets().open(ASSET_APPS_DIR + "/" + apps.get(i));
                                        installFormAsset(inputStream, app, version);
                                    }
                                } catch (IOException e) {

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
     * 检查指定版本的应用是否存在
     *
     * @param microAppId
     * @param version
     * @return
     */
    private boolean isMicroAppExit(String microAppId, long version) {
        boolean exit = false;

        File webAppDir = getWebAppRoot();
        if (webAppDir.exists()) {                                           //微应用集合目录是否存在
            File appDir = new File(webAppDir, microAppId);
            if (appDir.exists()) {                                          //指定的微应用是否存在
                File appVersionDir = new File(appDir, microAppId + "." + version);
                if (appVersionDir.exists()) {                                   //指定的微应用版本包是否存在
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
                path = getMicroAppPath(microAppId, getHighMicroAppVersionCode(microAppId));
            }
        }
        return path;
    }

    /**
     * 获取应用的本地路径
     *
     * @param microAppId
     * @param version
     * @return
     */
    public String getMicroAppPath(String microAppId, long version) {
        String path = null;
        if (isMicroAppExit(microAppId)) {
            if (isMicroAppExit(microAppId, version)) {
                File appVersionPath = new File(new File(getWebAppRoot(), microAppId), microAppId + "." + version);
                path = appVersionPath.getPath();
            }
        }

        return path;
    }

    /**
     * 列出指定应用的所有本地版本
     *
     * @param microAppId
     * @return
     */
    private ArrayList<String> listMicroAppVersions(String microAppId) {
        ArrayList<String> apps = new ArrayList<>();
        if (isMicroAppExit(microAppId)) {
            File dir = new File(getWebAppRoot(), microAppId);
            String[] appdirs = dir.list(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return new File(dir, name).isDirectory();       //过滤目录
                }
            });
            if (appdirs != null) {
                for (int i = 0; i < appdirs.length; i++) {
                    apps.add(appdirs[i]);
                }
            }
        }
        return apps;
    }

    /**
     * 列出所有本地的应用
     *
     * @return
     */
    private ArrayList<String> listAllMicroApps() {
        ArrayList<String> apps = new ArrayList<>();
        File dir = getWebAppRoot();
        if (dir.exists()) {
            String[] dirs = dir.list(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    return new File(dir, name).isDirectory();       //过滤目录
                }
            });
            if (dirs != null) {
                for (int i = 0; i < dirs.length; i++) {
                    String file = dirs[i];
                    apps.add(file);
                }
            }
        }
        return apps;
    }


    /**
     * 获取本地保存的指定微应用的最高版本
     *
     * @param microAppId
     * @return -1:不存在
     */
    private int getHighMicroAppVersionCode(String microAppId) {
        int code = -1;
        ArrayList<String> list = listMicroAppVersions(microAppId);
        if (list != null && list.size() > 0) {
            ArrayList<Integer> codes = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                int version = Integer.parseInt(list.get(i).replace(microAppId + ".", ""));
                codes.add(version);
            }
            code = Collections.max(codes, new Comparator<Integer>() {
                @Override
                public int compare(Integer o1, Integer o2) {
                    if (o1 > o2) {
                        return 1;
                    } else if (o1 < o2) {
                        return -1;
                    } else {
                        return 0;
                    }
                }
            });
        }

        return code;
    }

    /**
     * 保存应用到应用目录
     *
     * @param inputStream
     * @param microAppId
     * @param version
     * @return
     */
    private String saveApp(InputStream inputStream, String microAppId, long version) {
        String path = null;
        if (inputStream != null && !TextUtils.isEmpty(microAppId)) {
            if (getWebAppRoot() != null) {
                File temp = new File(getWebAppRoot(), microAppId);
                if (!temp.exists()) {
                    temp.mkdirs();
                }
                String name = microAppId + "." + version + ".zip";
                path = FileUtils.saveFile(inputStream, temp, name);
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
            if (FileUtils.deleteFile(file)) {
                success = true;
            }
        }
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
     * @param microAppId
     * @param version
     * @return
     */
    private boolean installFormAsset(InputStream asset, String microAppId, long version) {
        boolean success = false;

        String app = microAppId;
        String zip = microAppId + "." + version + ".zip";

        File appDir = new File(getWebAppRoot(), app);
        if (!appDir.exists()) {
            appDir.mkdirs();
        }
        String path = FileUtils.saveFile(asset, appDir, zip);                 //先保存到应用目录中

        if (!TextUtils.isEmpty(path)) {
            Log.d(TAG, "save path:" + path);
            success = installApp(new File(appDir, zip));         //再安装应用
            if (success) {
                Log.d(TAG, "install success :" + app);
            } else {
                Log.d(TAG, "install failed :" + app);
            }
        } else {
            Log.d(TAG, "save path null");
        }
        return success;
    }


}
