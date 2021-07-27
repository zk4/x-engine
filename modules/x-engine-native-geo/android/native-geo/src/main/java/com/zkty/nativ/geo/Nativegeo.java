package com.zkty.nativ.geo;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.provider.Settings;
import android.text.TextUtils;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.PermissionsUtils;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.LifecycleListener;

import java.util.List;

public class Nativegeo extends NativeModule implements IGeoManager {

    private List<NativeModule> modules;
    private LifecycleListener lifeCycleListener;
    private String[] permissions;
    //Android10以下申请定位权限
    private String[] permissionsO = new String[]{
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION};

    //Android 10及以上申请定位权限
    private String[] permissionsQ = new String[]{
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_BACKGROUND_LOCATION};

    private final int LOCATION_REQUEST_CODE = 0x31;
    private PermissionsUtils permissionsUtils;

    @Override
    public String moduleId() {
        return "com.zkty.native.geo";
    }

    @Override
    public void afterAllNativeModuleInited() {
        modules = NativeContext.sharedInstance().getModulesByProtocol(Igeo.class);

    }

    @Override
    public void locate(CallBack callBack) {
        checkGeoService();


        permissions = permissionsO;
        if (Build.VERSION.SDK_INT == 29) {
            permissions = permissionsQ;
        }


        Activity activity = XEngineApplication.getCurrentActivity();
        if (activity == null || !(activity instanceof BaseXEngineActivity)) return;
        final BaseXEngineActivity act = (BaseXEngineActivity) activity;
        permissionsUtils = new PermissionsUtils();
        if (lifeCycleListener != null) {
            act.removeLifeCycleListener(lifeCycleListener);
            lifeCycleListener = null;
        }
        lifeCycleListener = new LifecycleListener() {
            @Override
            public void onCreate() {

            }

            @Override
            public void onStart() {

            }

            @Override
            public void onRestart() {

            }

            @Override
            public void onResume() {

            }

            @Override
            public void onPause() {

            }

            @Override
            public void onStop() {

            }

            @Override
            public void onDestroy() {

            }

            @Override
            public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {

            }

            @Override
            public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
                if (requestCode == LOCATION_REQUEST_CODE)
                    permissionsUtils.onRequestPermissionsResult(activity, requestCode, permissions, grantResults);
            }
        };

        if (modules == null || modules.size() == 0) {
            callBack.onLocation(null);
            return;
        }
        act.addLifeCycleListener(lifeCycleListener);
        permissionsUtils.checkPermissions(activity, permissions, LOCATION_REQUEST_CODE, new PermissionsUtils.IPermissionsResult() {
            @Override
            public void passPermissions() {
                Igeo igeo = (Igeo) modules.get(0);
                igeo.locate(callBack);
            }

            @Override
            public void forbidPermissions() {
                callBack.onLocation(null);
            }
        });


    }

    private void checkGeoService() {
        if (!isLocServiceEnable()) {
            Activity activity = XEngineApplication.getCurrentActivity();
            AlertDialog mPermissionDialog = new AlertDialog.Builder(activity)
                    .setMessage("请前往设置页面开启定位服务，并允许应用访问您的位置")
                    .setPositiveButton("设置", (dialog, which) -> {
                        dialog.dismiss();
                        Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                        activity.startActivity(intent);
                    })
                    .setNegativeButton("暂不开启", (dialog, which) -> {
                        //关闭页面或者做其他操作
                        dialog.dismiss();

                    })
                    .create();
            mPermissionDialog.show();
        }
    }


    /**
     * 手机是否开启位置服务，如果没有开启那么所有app将不能使用定位功能
     */
    private boolean isLocServiceEnable() {
//        LocationManager locationManager = (LocationManager) XEngineApplication.getCurrentActivity().getSystemService(Context.LOCATION_SERVICE);
//        if (locationManager == null) {
//            return false;
//        }
//        return locationManager.isLocationEnabled();

        int locationMode = 0;
        String locationProviders;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            try {
                locationMode = Settings.Secure.getInt(XEngineApplication.getCurrentActivity().getContentResolver(), Settings.Secure.LOCATION_MODE);
            } catch (Settings.SettingNotFoundException e) {
                e.printStackTrace();
                return false;
            }
            return locationMode != Settings.Secure.LOCATION_MODE_OFF;
        } else {
            locationProviders = Settings.Secure.getString(XEngineApplication.getCurrentActivity().getContentResolver(), Settings.Secure.LOCATION_PROVIDERS_ALLOWED);
            return !TextUtils.isEmpty(locationProviders);
        }

    }


}
