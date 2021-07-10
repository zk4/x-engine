package com.zkty.nativ.geo;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;

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
    private String[] permissions = new String[]{
            Manifest.permission.ACCESS_COARSE_LOCATION};
    private final int LOCATION_REQUEST_CODE = 0x31;
    private PermissionsUtils permissionsUtils = new PermissionsUtils();

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

        Activity activity = XEngineApplication.getCurrentActivity();
        if (activity == null || !(activity instanceof BaseXEngineActivity)) return;
        final BaseXEngineActivity act = (BaseXEngineActivity) activity;

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
                permissionsUtils.onRequestPermissionsResult(activity, requestCode, permissions, grantResults);
            }
        };

        if (modules == null || modules.size() == 0) {
            callBack.onLocation(null);
            return;
        }

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
