package com.zkty.modules.loaded.imp;

import android.text.TextUtils;
import android.util.Log;

import com.zkty.modules.engine.manager.MicroAppsManager;
import com.zkty.modules.engine.utils.FileUtils;
import com.zkty.modules.engine.utils.MD5Utils;
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
import java.io.InputStream;
import java.util.HashMap;

public class MicroAppsUpdateManager implements IOfflinePackageProtocol {
    private static final String TAG = MicroAppsUpdateManager.class.getSimpleName();


    private static MicroAppsUpdateManager INSTANCE = new MicroAppsUpdateManager();

    public static MicroAppsUpdateManager getInstance() {
        return INSTANCE;
    }


    /**
     * 自动更新
     *
     * @param serverConfig
     */
    public void update(ServerConfig serverConfig) {
        if (!TextUtils.isEmpty(serverConfig.getOfflineServerUrl())) {
            checkMicroAppsUpdate(serverConfig.getOfflineServerUrl(), "/microApps.json", serverConfig.getAppId(), serverConfig.getAppSecret(), 0, null);
        }
    }

    /**
     * 废弃原始制定规则
     * 根据微应用版本信息拼接地址url并下载安装
     * GET: {offlineServerUrl}/app/{appId}/{microAppId}.{version}.zip?key=md5(appSecret+microAppId+version)&engine_version=1
     *
     * @param baseUrl
     * @param appId
     * @param appSecret
     * @param microAppId
     * @param version
     */
    @Override
    public void downLoadApp(String baseUrl, final String appId, String appSecret, final String microAppId, final int version, int engineVersion, final IXEngineNetProtocolCallback callback, final IMicroAppInstallListener installListener) {
        final IXEngineNetProtocol ixEngineNetProtocol = XEngineNetImpl.getInstance();

        HashMap<String, String> header = new HashMap<>();

        StringBuilder urlBuilder = new StringBuilder();
        if (!baseUrl.endsWith("/")) {
            urlBuilder.append(baseUrl + "/");
        } else {
            urlBuilder.append(baseUrl);
        }
        if (TextUtils.isEmpty(microAppId)) {
            Log.d(TAG, "not define microAppId");
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
        params.put("engine_version", String.valueOf(engineVersion));

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
                        if (installListener != null) {
                            installListener.onIMicroAppInstallListener(installed, microAppId);
                        }
                    }
                }
            }

            @Override
            public void onUploadProgress(XEngineNetRequest xEngineNetRequest, long l, long l1, boolean b) {
                if (callback != null) {
                    callback.onUploadProgress(xEngineNetRequest, l, l1, b);
                }
            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest xEngineNetRequest, XEngineNetResponse xEngineNetResponse, long l, long l1, boolean b) {
                if (callback != null) {
                    callback.onDownLoadProgress(xEngineNetRequest, xEngineNetResponse, l, l1, b);
                }
            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                Log.d(TAG, "download app error:" + error);
                if (callback != null) {
                    callback.onFailed(request, error);
                }
            }
        });
    }


    /**
     * 废弃原始制定规则
     * GET: {offlineServerUrl}/app/{appId}/microApps.json?key=md5(appSecret+appId)
     *
     * @param url
     */
    /**
     * 检查所有微应用版本后直接安装更新
     *
     * @param baseUrl
     * @param appId
     * @param appSecret
     * @param engineVersion
     */
    @Override
    public void checkMicroAppsUpdate(final String baseUrl, String path, final String appId, final String appSecret, final int engineVersion, final IXEngineNetProtocolCallback callback) {
        final IXEngineNetProtocol ixEngineNetProtocol = XEngineNetImpl.getInstance();

        HashMap<String, String> header = new HashMap<>();
        if (TextUtils.isEmpty(baseUrl) || TextUtils.isEmpty(path)) {
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
                                    for (int i = 0; i < array.length(); i++) {
                                        JSONObject app = array.getJSONObject(i);        //获取每一个微应用的配置信息

                                        String microAppName = app.optString("microAppName", null);
                                        String microAppId = app.optString("microAppId", null);
                                        int microAppVersion = app.optInt("microAppVersion", 0);

                                        if (MicroAppsManager.getInstance().isMicroAppExit(microAppId)) {                //本地存在
                                            int old = MicroAppsManager.getInstance().getHighMicroAppVersionCode(microAppId);
                                            if (microAppVersion > old) {        //有新版本且需要强制升级
                                                downLoadApp(baseUrl, appId, appSecret, microAppId, microAppVersion, engineVersion, null, null);
                                            }
                                        } else {                                    //本地不存在[直接下载微应用安装到本地]
                                            downLoadApp(baseUrl, appId, appSecret, microAppId, microAppVersion, engineVersion, null, null);
                                        }
                                    }
                                }

                                break;
                            case 200:       //没有新版本

                                break;
                        }

                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }

            @Override
            public void onUploadProgress(XEngineNetRequest xEngineNetRequest, long l, long l1, boolean b) {
                if (callback != null) {
                    callback.onUploadProgress(xEngineNetRequest, l, l1, b);
                }
            }

            @Override
            public void onDownLoadProgress(XEngineNetRequest xEngineNetRequest, XEngineNetResponse xEngineNetResponse, long l, long l1, boolean b) {
                if (callback != null) {
                    callback.onDownLoadProgress(xEngineNetRequest, xEngineNetResponse, l, l1, b);
                }
            }

            @Override
            public void onFailed(XEngineNetRequest request, String error) {
                if (callback != null) {
                    callback.onFailed(request, error);
                }
            }
        });
    }
}
