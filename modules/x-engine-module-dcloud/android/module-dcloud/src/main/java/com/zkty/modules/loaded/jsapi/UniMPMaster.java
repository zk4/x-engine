package com.zkty.modules.loaded.jsapi;

import android.app.Activity;
import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.zkty.modules.engine.utils.ActivityUtils;
import com.zkty.modules.engine.utils.FileUtils;
import com.zkty.modules.engine.utils.ToastUtils;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.dcloud.feature.sdk.DCSDKInitConfig;
import io.dcloud.feature.sdk.DCUniMPSDK;
import io.dcloud.feature.sdk.MenuActionSheetItem;

public class UniMPMaster {

    public static void initialize(Context context) {
        WgtManager.getInstance().init();
        MenuActionSheetItem item = new MenuActionSheetItem("关于", "gy");
        List<MenuActionSheetItem> sheetItems = new ArrayList<>();
        sheetItems.add(item);
        DCSDKInitConfig config = new DCSDKInitConfig.Builder()
                .setCapsule(true)
                .setMenuDefFontSize("16px")
                .setMenuDefFontColor("#ff00ff")
                .setMenuDefFontWeight("normal")
//                .setMenuActionSheetItems(sheetItems)
                .build();
        DCUniMPSDK.getInstance().initialize(context, config, isSuccess -> Log.d("unimp", "onInitFinished---->" + isSuccess));

    }

    public static void preload(String appId) {
        Activity context = ActivityUtils.getCurrentActivity();
        String wgtPath = WgtManager.getInstance().getAssignedWgtPathById(appId, null);
        DCUniMPSDK.getInstance().releaseWgtToRunPathFromePath(appId, wgtPath, (code, pArgs) -> {
            if (code == 1) {//释放wgt完成
                try {
                    DCUniMPSDK.getInstance().startApp(context, appId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {//释放wgt失败
                ToastUtils.showThreadToast("小程序启动失败:资源释放失败");
            }
            return null;
        });
    }

    public static void startUniApp(String appId, String redirectPath, Map<String, String> params) {
        startUniApp(appId, redirectPath, params, null);
    }

    public static void startUniApp(String appId, String redirectPath, Map<String, String> params, String version) {
        Activity context = ActivityUtils.getCurrentActivity();
        String wgtPath = WgtManager.getInstance().getAssignedWgtPathById(appId, null);
        if (TextUtils.isEmpty(wgtPath)) return;
        DCUniMPSDK.getInstance().releaseWgtToRunPathFromePath(appId, wgtPath, (code, pArgs) -> {
            if (code == 1) {//释放wgt完成
                try {
                    if (params == null) {
                        if (redirectPath == null) {
                            DCUniMPSDK.getInstance().startApp(context, appId);
                        } else {
                            DCUniMPSDK.getInstance().startApp(context, appId, redirectPath);
                        }
                    } else {
                        JSONObject argument = new JSONObject(params);

                        if (redirectPath == null) {
                            DCUniMPSDK.getInstance().startApp(context, appId, argument);
                        } else {
                            DCUniMPSDK.getInstance().startApp(context, appId, null, redirectPath, argument);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {//释放wgt失败
                ToastUtils.showThreadToast("小程序启动失败:资源释放失败");
            }
            return null;
        });
    }


    public static boolean isWgtExisted(String appId, String version) {
        if (TextUtils.isEmpty(appId)) return false;

        return WgtManager.getInstance().isWgtExit(appId, version);
    }

    public static void setOnUniMPEventCallBack(DCUniMPSDK.IOnUniMPEventCallBack callBack) {
        DCUniMPSDK.getInstance().setOnUniMPEventCallBack(callBack);
    }
}
