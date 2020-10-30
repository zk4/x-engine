package com.zkty.modules.loaded.jsapi;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.text.TextUtils;

import com.alibaba.fastjson.JSON;
import com.tencent.mm.opensdk.modelbiz.WXLaunchMiniProgram;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import java.util.Map;


public class RouterMaster {

    public static void openTargetRouter(Context context, String type, String uri, String path, String arg, String microAppVersion) {

        if (context == null || type == null) return;
        switch (type) {
            case "0":
            case "h5"://h5
                type = "h5";
                String url = TextUtils.isEmpty(path) ? uri : uri + "?" + path;
                XEngineWebActivityManager.sharedInstance().startXEngineActivity(context, type, url);
                break;
            case "2":
            case "microApp":
            case "microapp"://微应用
                type = "microapp";
                XEngineWebActivityManager.sharedInstance().startXEngineActivity(context, type, uri, path, arg, microAppVersion);
                break;
            case "wx"://微信小程序
                String appId = null;
                try {
                    ApplicationInfo appInfo = context.getPackageManager().getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
                    if (appInfo.metaData != null) {
                        for (String key : appInfo.metaData.keySet()) {
                            if (!TextUtils.isEmpty(key) && ("wx_appid").equals(key)) {
                                appId = appInfo.metaData.getString(key);
                                break;
                            }
                        }
                    }

                } catch (PackageManager.NameNotFoundException e) {
                    e.printStackTrace();
                }
                if (TextUtils.isEmpty(appId)) break;

                IWXAPI api = WXAPIFactory.createWXAPI(context, appId);
                WXLaunchMiniProgram.Req req = new WXLaunchMiniProgram.Req();
                req.userName = uri; // 填小程序原始id
                req.path = path;  ////拉起小程序页面的可带参路径，不填默认拉起小程序首页，对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"。
                req.miniprogramType = WXLaunchMiniProgram.Req.MINIPTOGRAM_TYPE_RELEASE;// 可选打开 开发版，体验版和正式版
                api.sendReq(req);

                break;
            case "3":
            case "uni"://uniApp
                String path1 = null;
                Map<String, String> params = null;
                if (path != null) {
                    if (path.contains("?")) {
                        String[] splits = path.split("\\?");
                        path1 = splits[0];
                        params = JSON.parseObject(splits[1], Map.class);
                    } else {
                        path1 = path;
                    }
                }
                UniMPMaster.startUniApp(uri, path1, params);

                break;
            case "1":
            case "native"://原生页面
                if (!uri.contains(",")) return;
                String[] classNames = uri.split(",");
                try {
                    Class<?> classActivity = Class.forName(classNames[1]);
                    Intent intent = new Intent(context, classActivity);
                    if (!TextUtils.isEmpty(path)) {
                        intent.putExtra("params", path);
                    }
                    context.startActivity(intent);
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
                break;
            default:
                break;
        }

    }
}
