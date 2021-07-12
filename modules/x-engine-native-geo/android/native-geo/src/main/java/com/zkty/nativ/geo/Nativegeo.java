package com.zkty.nativ.geo;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

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
        permissions = permissionsO;
        if (Build.VERSION.SDK_INT >= 29) {
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
}
