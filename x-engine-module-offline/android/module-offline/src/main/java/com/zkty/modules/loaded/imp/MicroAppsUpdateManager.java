package com.zkty.modules.loaded.imp;

import android.util.Log;

import com.zkty.modules.engine.utils.MD5Utils;
import com.zkty.modules.loaded.callback.IOfflinePackageProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;
import com.zkty.modules.loaded.callback.XEngineNetRequest;
import com.zkty.modules.loaded.callback.XEngineNetResponse;

import java.util.HashMap;

public class MicroAppsUpdateManager implements IOfflinePackageProtocol {
    private static final String TAG = MicroAppsUpdateManager.class.getSimpleName();


    /**
     * GET: {offlineServerUrl}/app/{appId}/{microAppId}.{version}.zip?key=md5(appSecret+microAppId+version)&engine_version=1
     *
     * @param baseUrl
     * @param appId
     * @param appSecret
     * @param microAppId
     * @param version
     */
    @Override
    public void downLoadApp(String baseUrl, final String appId, String appSecret, final String microAppId, final int version, int engineVersion, final IXEngineNetProtocolCallback callback) {
        final IXEngineNetProtocol ixEngineNetProtocol = XEngineNetImpl.getInstance();

        HashMap<String, String> header = new HashMap<>();

        StringBuilder urlBuilder = new StringBuilder();
        urlBuilder.append(baseUrl)
                .append("/").append("app")
                .append("/").append(appId)
                .append("/").append(microAppId).append(".").append(version).append(".zip");

        HashMap<String, String> params = new HashMap<>();
        params.put("key", MD5Utils.getMD5(appSecret + microAppId + version));
        params.put("engine_version", String.valueOf(engineVersion));

        ixEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.GET, urlBuilder.toString(), header, params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                if (callback != null) {
                    callback.onSuccess(request, response);
                }

//                InputStream inputStream = response.getBody();
//                if (inputStream != null) {
//                    String path = MicroAppsManager.getInstance().saveApp(inputStream, microAppId, String.valueOf(version));
//                    if (!TextUtils.isEmpty(path)) {
//                        MicroAppsManager.getInstance().installApp(new File(path));         //安装微应用
//                    }
//                }
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
     * GET: {offlineServerUrl}/app/{appId}/microApps.json?key=md5(appSecret+appId)
     *
     * @param url
     */
    /**
     * @param baseUrl
     * @param appId
     * @param appSecret
     * @param engineVersion
     */
    @Override
    public void checkMicroAppsUpdate(String baseUrl, final String appId, final String appSecret, final int engineVersion, final IXEngineNetProtocolCallback callback) {
        final IXEngineNetProtocol ixEngineNetProtocol = XEngineNetImpl.getInstance();

        HashMap<String, String> header = new HashMap<>();

        StringBuilder urlBuilder = new StringBuilder();
        urlBuilder.append(baseUrl).append("/").append("app").append("/").append(appId).append("/").append("microApps.json");

        HashMap<String, String> params = new HashMap<>();
        params.put("key", MD5Utils.getMD5(appSecret + appId));

        ixEngineNetProtocol.doRequest(IXEngineNetProtocol.Method.GET, urlBuilder.toString(), header, params, null, new IXEngineNetProtocolCallback() {
            @Override
            public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                if (callback != null) {
                    callback.onSuccess(request, response);
                }

//                String resp = FileUtils.readInputSteam(response.getBody());
//                if (!TextUtils.isEmpty(resp)) {
//                    Log.d(TAG, "resp:" + resp);
//                    try {
//                        JSONObject body = new JSONObject(resp);
//                        int code = body.optInt("code", 0);
//                        int version = body.optInt("version", 0);
//                        switch (code) {
//                            case 0:     //有新版本
//                                JSONArray array = body.optJSONArray("data");
//                                if (array != null) {
//                                    for (int i = 0; i < array.length(); i++) {
//                                        JSONObject app = array.getJSONObject(i);        //获取每一个微应用的配置信息
//
//                                        boolean forceUpdate = app.optBoolean("forceUpdate", false);
//                                        String microAppName = app.optString("microAppName", null);
//                                        String microAppId = app.optString("microAppId", null);
//                                        int microAppVersion = app.optInt("microAppVersion", 0);
//
//
//                                        if (MicroAppsManager.getInstance().isMicroAppExit(microAppId)) {                //本地存在
//                                            int old = MicroAppsManager.getInstance().getHighMicroAppVersionCode(microAppId);
//                                            if (microAppVersion > old && forceUpdate) {        //有新版本且需要牵强制升级
//                                                downLoadApp("", appId, appSecret, microAppId, version, engineVersion);
//                                            }
//                                        } else {                                    //本地不存在[直接下载微应用安装到本地]
//                                            downLoadApp("", appId, appSecret, microAppId, version, engineVersion);
//                                        }
//                                    }
//                                }
//
//                                break;
//                            case 200:       //没有新版本
//
//                                break;
//                        }
//
//                    } catch (JSONException e) {
//                        e.printStackTrace();
//                    }
//                }
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
