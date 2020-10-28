package com.zkty.modules.loaded.imp;

import android.text.TextUtils;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.zkty.modules.engine.XEngineApplication;
import com.zkty.modules.engine.manager.MicroAppsManager;
import com.zkty.modules.engine.utils.FileUtils;
import com.zkty.modules.engine.utils.MD5Utils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.loaded.ServerConfig;
import com.zkty.modules.loaded.callback.IMicroAppInstallListener;
import com.zkty.modules.loaded.callback.IOfflinePackageProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;
import com.zkty.modules.loaded.callback.XEngineNetRequest;
import com.zkty.modules.loaded.callback.XEngineNetResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

public class SingleMicroAppsUpdateManager {
    private static final String TAG = SingleMicroAppsUpdateManager.class.getSimpleName();
    private static SingleMicroAppsUpdateManager INSTANCE = new SingleMicroAppsUpdateManager();
    public static SingleMicroAppsUpdateManager getInstance() {
        return INSTANCE;
    }
    /**
     * 根据microAppId 更新单个微应用
     *
     * @param microId
     */
    public void update(String microId, IMicroAppInstallListener listener) {
        InputStream inputStream = null;

        try {
            inputStream = XEngineApplication.getApplication().getAssets().open("xengine_config.json");
            if (inputStream != null) {
                String json = FileUtils.readInputSteam(inputStream);
                ServerConfig serverConfig = JSON.parseObject(json, ServerConfig.class);
                if (!TextUtils.isEmpty(serverConfig.getOfflineServerUrl())) {
                    checkMicroAppsUpdate(microId, serverConfig.getOfflineServerUrl(), "/microApps.json", serverConfig.getAppId(), serverConfig.getAppSecret(), 1, listener);
                } else {
                    listener.onIMicroAppInstallListener(false, microId);
                }
            } else {
                listener.onIMicroAppInstallListener(false, microId);
            }
        } catch (IOException e) {
            e.printStackTrace();
            listener.onIMicroAppInstallListener(false, microId);
        } finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    private void downLoadApp(String baseUrl, final String microId, String appSecret, final String microAppId, final int version, int engineVersion, final IMicroAppInstallListener listener) {
        final IXEngineNetProtocol ixEngineNetProtocol = XEngineNetImpl.getInstance();

        HashMap<String, String> header = new HashMap<>();

        StringBuilder urlBuilder = new StringBuilder();
        if (!baseUrl.endsWith("/")) {
            urlBuilder.append(baseUrl + "/");
        } else {
            urlBuilder.append(baseUrl);
        }
        if (TextUtils.isEmpty(microAppId)) {
            listener.onIMicroAppInstallListener(false, microId);
            return;
        }
        urlBuilder.append(microAppId);
        urlBuilder.append(".");
        urlBuilder.append(version);
        urlBuilder.append(".zip");

        HashMap<String, String> params = new HashMap<>();
        if (!TextUtils.isEmpty(appSecret)) {
            params.put("key", MD5Utils.getMD5(appSecret + microAppId + version));
        }
//        params.put("engine_build", String.valueOf(engineVersion));

        ixEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.GET, urlBuilder.toString(), header, params, null, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                InputStream inputStream = response.getBody();
                if (inputStream != null) {
                    String path = MicroAppsManager.getInstance().saveApp(inputStream, microAppId, String.valueOf(version));
                    Log.d(TAG, "path:" + path);
                    if (!TextUtils.isEmpty(path)) {
                        boolean installed = MicroAppsManager.getInstance().installApp(new File(path));         //安装微应用
                        Log.d(TAG, "installed:" + installed);
                        if (listener != null) {
                            listener.onIMicroAppInstallListener(installed, microAppId);
                            return;
                        }
                    }
                }
                listener.onIMicroAppInstallListener(false, microAppId);
            }

            @Override
            public void onUploadProgress(XEngineNetRequest xEngineNetRequest, long l, long l1, boolean b) {
                listener.onIMicroAppInstallListener(false, microAppId);
            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest xEngineNetRequest, XEngineNetResponse xEngineNetResponse, long l, long l1, boolean b) {
                listener.onIMicroAppInstallListener(false, microAppId);
            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                listener.onIMicroAppInstallListener(false, microAppId);
            }
        });
    }


    /**
     * 检查指定微应用版本后直接安装更新
     *
     * @param baseUrl
     * @param appId
     * @param appSecret
     * @param engineVersion
     */
    private void checkMicroAppsUpdate(final String microId, final String baseUrl, String path, final String appId, final String appSecret, final int engineVersion, final IMicroAppInstallListener listener) {
        final IXEngineNetProtocol ixEngineNetProtocol = XEngineNetImpl.getInstance();

        HashMap<String, String> header = new HashMap<>();
        if (TextUtils.isEmpty(baseUrl) || TextUtils.isEmpty(path)) {
            listener.onIMicroAppInstallListener(false, microId);
            return;
        }
        StringBuilder urlBuilder = new StringBuilder();
        if (baseUrl.endsWith("/")) {                            //带"/"删除
            urlBuilder.append(baseUrl.substring(0, baseUrl.length() - 1));
        } else {
            urlBuilder.append(baseUrl);
        }
        if (path.startsWith("/")) {
            urlBuilder.append(path);
        } else {
            urlBuilder.append("/").append(path);
        }

        HashMap<String, String> params = new HashMap<>();
        if (!TextUtils.isEmpty(appId) && !TextUtils.isEmpty(appSecret)) {
            params.put("key", MD5Utils.getMD5(appSecret + appId));
        }

        ixEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.GET, urlBuilder.toString(), header, params, null, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {             //获取到所有微应用版本信息
                String resp = FileUtils.readInputSteam(response.getBody());
                if (!TextUtils.isEmpty(resp)) {
                    Log.d(TAG, "resp:" + resp);
                    try {
                        JSONObject body = new JSONObject(resp);
                        int code = body.optInt("code", 0);
                        switch (code) {
                            case 0:     //有新版本
                                JSONArray array = body.optJSONArray("data");
                                if (array != null) {
                                    String tempMicroId = null;
                                    int microAppVersion = 0;
                                    for (int i = 0; i < array.length(); i++) {
                                        JSONObject app = array.getJSONObject(i);        //获取每一个微应用的配置信息
                                        String microAppId = app.optString("microAppId", null);
                                        if (microId.equals(microAppId)) {
                                            microAppVersion = app.optInt("microAppVersion", 0) > microAppVersion ? app.optInt("microAppVersion", 0) : microAppVersion;
                                            tempMicroId = microAppId;
                                        }
                                    }
                                    if (TextUtils.isEmpty(tempMicroId)) {
                                        listener.onIMicroAppInstallListener(true, microId);
                                    } else {
                                        if (MicroAppsManager.getInstance().isMicroAppExit(microId)) {                //本地存在
                                            int old = MicroAppsManager.getInstance().getHighMicroAppVersionCode(microId);
                                            if (microAppVersion > old) {        //有新版本且需要强制升级
                                                downLoadApp(baseUrl, appId, appSecret, microId, microAppVersion, engineVersion, listener);
                                            } else {
                                                listener.onIMicroAppInstallListener(true, microId);

                                            }
                                        } else {                                    //本地不存在[直接下载微应用安装到本地]
                                            downLoadApp(baseUrl, appId, appSecret, microId, microAppVersion, engineVersion, listener);
                                        }
                                    }
                                } else {
                                    listener.onIMicroAppInstallListener(false, microId);

                                }

                                break;
                            case 200://没有新版本
                            default:
                                listener.onIMicroAppInstallListener(true, microId);
                                break;
                        }

                    } catch (JSONException e) {
                        e.printStackTrace();
                        listener.onIMicroAppInstallListener(false, microId);
                    }
                } else {
                    listener.onIMicroAppInstallListener(false, microId);
                }
            }

            @Override
            public void onUploadProgress(XEngineNetRequest xEngineNetRequest, long l, long l1, boolean b) {
                listener.onIMicroAppInstallListener(false, microId);
            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest xEngineNetRequest, XEngineNetResponse xEngineNetResponse, long l, long l1, boolean b) {
                listener.onIMicroAppInstallListener(false, microId);
            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                listener.onIMicroAppInstallListener(false, microId);
            }
        });
    }
}
