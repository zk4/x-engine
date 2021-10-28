package com.zkty.nativ.jsi.view;

import android.app.Application;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.zkty.nativ.jsi.MicroAppJsonDto;
import com.zkty.nativ.jsi.utils.FileUtils;
import com.zkty.nativ.jsi.utils.MicroAppDownloader;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Locale;


/**
 * microapp 安装及卸载管理类
 */
public class MicroAppsInstall {
    private static final String TAG = MicroAppsInstall.class.getSimpleName();

    private static final String ROOT = "x-engine-dir";
    private static final String ASSET_APPS_DIR = "moduleApps";
    private static final String MICRO_APPS_ROOT = "microApps";       //microApp安装包目录，目录下每个微应用按照微应用包名建目录，微应用目录下包含此应用的各版本目录

    private static final String ZIPS_ROOT = "zips";       //下载的zip 地址


    private static Context context;
    private static MicroAppsInstall INSTANCE;


    /**
     * assets及cache中所有微应用加载地址
     * <p>
     * <p>
     * <p>
     * key:id,value:{key:version,value:path}
     */
    private HashMap<String, HashMap<Integer, String>> microApps;

    /**
     * assets下微应用目录
     * --assets
     * ----moduleApps
     * ----com.aaa.bbb.ccc
     * ------js
     * ------static
     * ------index.html
     * ------microapp.json
     * ------sitemap.json
     * ----com.aaa.bbb.ddd
     **/

    /**
     * cache中
     * 。。/files/x-engine-dir/microApps
     * --com.aaa.bbb.ccc
     * ----1
     * -------{js,index.html,microapp.json,sitemap.json}
     * ----2
     **/


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
        loadAppsFormAssetsAndCache();
    }

    private void loadAppsFormAssetsAndCache() {
        microApps = new HashMap<>();
        loadAppsFormAssets();
        loadAppsForCache();

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
     * 预加载asset中的微应用
     */
    private void loadAppsFormAssets() {

        try {
            String[] files = context.getAssets().list(ASSET_APPS_DIR);
            if (files != null && files.length > 0) {

                for (String file : files) {
                    String[] segment = file.split("\\.");
                    if (segment != null && segment.length == 4) {
                        //安装微应用
                        try {
                            Log.d(TAG, "start install apps:" + file);
                            InputStream inputStream = context.getAssets().open(String.format("%s/%s/%s", ASSET_APPS_DIR, file, "microapp.json"));
//                            InputStream inputStream2 = context.getAssets().open(String.format("%s/%s/%s", ASSET_APPS_DIR, file, "sitemap.json"));
                            MicroAppJsonDto microAppJsonDto = JSON.parseObject(inputStream, MicroAppJsonDto.class);
                            if (microAppJsonDto != null && microAppJsonDto.getId() != null) {
                                HashMap<Integer, String> microApp = microApps.get(microAppJsonDto.getId());
                                if (microApp == null) microApp = new HashMap<>();
                                microApp.put(microAppJsonDto.getVersion(), String.format(Locale.ENGLISH, "/android_asset/moduleApps/%s", file));
                                microApps.put(microAppJsonDto.getId(), microApp);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }

                }
            }

        } catch (
                IOException e) {
            e.printStackTrace();
        }


    }

    /**
     * 预加载cache中的微应用
     */
    private void loadAppsForCache() {

        File[] microAppList = getWebAppRoot().listFiles();
        String[] microAppStr = getWebAppRoot().list();
        if (microAppList != null) {

            for (int i = 0; i < microAppList.length; i++) {
                HashMap<Integer, String> map = microApps.get(microAppStr[i]);
                File[] apps = microAppList[i].listFiles();
                String[] appstr = microAppList[i].list();
                if (apps != null) {
                    for (int j = 0; j < apps.length; j++) {

                        if (map == null) map = new HashMap<>();
                        try {
                            map.put(Integer.parseInt(appstr[j]), String.format("%s/%s/%s", getWebAppRoot().getPath(), microAppStr[i], appstr[j]));

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    microApps.put(microAppStr[i], map);
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
     * 获取应用的本地路径
     *
     * @param microAppId
     * @return null 或 微应用的最高版本目录
     */
    public String getMicroAppPath(String microAppId) {

        if (!TextUtils.isEmpty(microAppId)) {
            HashMap<Integer, String> apps = microApps.get(microAppId);
            if (apps != null) {
                return apps.get(getHighestVersionOfMicroApp(microAppId));
            }

        }
        return null;
    }

    public int getHighestVersionOfMicroApp(String microAppId) {

        if (!TextUtils.isEmpty(microAppId)) {
            HashMap<Integer, String> apps = microApps.get(microAppId);
            if (apps != null) {
                int max = 0;
                for (Integer key : apps.keySet()) {
                    if (key > max) max = key;
                }
                return max;
            }
        }
        return -1;


    }

    /**
     * 获取zip目录
     *
     * @return
     */
    private File getZipRoot() {
        File temp = null;
        File root = new File(context.getCacheDir(), ZIPS_ROOT);
        if (!root.exists()) {
            if (root.mkdirs()) {
                temp = root;
            }
        } else {
            temp = root;
        }
        return temp;
    }

    private boolean isMicroAppValid(File file) {

        File file1 = new File(file, "microapp.json");
        File file2 = new File(file, "sitemap.json");
        return file1.exists() && file2.exists();


    }


    public void downloadMicroApp(String url) {
        String fileName = System.currentTimeMillis() + ".zip";

        String savePath = new File(getZipRoot(), fileName).getPath();

        MicroAppDownloader.get().download(url, savePath, new MicroAppDownloader.OnDownloadListener() {
            @Override
            public void onDownloadSuccess() {
                Log.d(TAG, "onDownloadSuccess: ");
                if (FileUtils.doUnzip(getZipRoot(), fileName)) {
                    File file = new File(getZipRoot(), fileName.replaceAll(".zip", ""));
                    if (isMicroAppValid(file)) {
                        File file1 = new File(file, "microapp.json");
                        try {
                            MicroAppJsonDto microAppJsonDto = JSON.parseObject(new FileInputStream(file1), MicroAppJsonDto.class);
                            if (microAppJsonDto != null && microAppJsonDto.getId() != null) {

                                File file2 = new File(getWebAppRoot(), microAppJsonDto.getId());
                                if (!file2.exists()) file2.mkdirs();
                                File file3 = new File(file2, String.valueOf(microAppJsonDto.getVersion()));
                                if (FileUtils.copy(file.getPath(), file3.getPath() + File.separator) == 0) {
                                    loadAppsFormAssetsAndCache();
                                }
                            }
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }

            @Override
            public void onDownloading(int progress) {
                Log.d(TAG, "progress: " + progress);
            }

            @Override
            public void onDownloadFailed(String msg) {
                Log.d(TAG, "onDownloadFailed: " + msg);
            }
        });
    }


}
