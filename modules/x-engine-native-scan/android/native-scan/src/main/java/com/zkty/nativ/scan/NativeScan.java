package com.zkty.nativ.scan;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.huawei.hms.hmsscankit.ScanUtil;
import com.huawei.hms.ml.scan.HmsScan;
import com.huawei.hms.ml.scan.HmsScanAnalyzerOptions;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.LifecycleListener;
import com.zkty.nativ.scan.activity.DefinedActivity;
import com.zkty.nativ.scan.activity.ScanActivity;

public class NativeScan extends NativeModule implements IScan {

    private static final String TAG = "NativeScan";


    private int REQUEST_CODE = 0x10;
    private LifecycleListener lifeCycleListener;
    private int CODE_PERMISSION_CAMERA = 1;
    private static final int REQUEST_CODE_DEFINE = 0X0111;
    private String[] permissions = {Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE};

    @Override
    public String moduleId() {
        return "com.zkty.native.scan";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public void openScanView(CallBack callBack) {

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
            public void onActivityResult(int requestCode, int resultCode, @Nullable Intent intent) {
                Log.d(TAG, "REQUEST_CODE:" + REQUEST_CODE + ",requestCode=" + requestCode);
                if (resultCode == Activity.RESULT_OK && requestCode == REQUEST_CODE) {
                    REQUEST_CODE++;
                    if (intent.hasExtra("result")) {
                        String code = intent.getStringExtra("result");
                        if (!TextUtils.isEmpty(code)) {
                            callBack.succes(code);
//                            if (mXEngineWebView != null) {
//                                mXEngineWebView.callHandler(dto.__event__, new Object[]{code}, new OnReturnValue<Object>() {
//                                    @Override
//                                    public void onValue(Object retValue) {
//
//                                    }
//                                });
//                            }
                        }
                    }
                }
                if (resultCode == Activity.RESULT_OK && requestCode == REQUEST_CODE_DEFINE) {
                    HmsScan obj = intent.getParcelableExtra(ScanUtil.RESULT);
                    if (obj != null) {
                        callBack.succes(obj.getOriginalValue());
                    }
                    //MultiProcessor & Bitmap
                }
            }

            @Override
            public void onRequestPermissionsResult(int requestCode, @NonNull String[] strings, @NonNull int[] ints) {
                if (requestCode == CODE_PERMISSION_CAMERA) {
                    if (activity.checkCallingOrSelfPermission(permissions[0]) == PackageManager.PERMISSION_GRANTED) {
                        startScan(activity);
                    } else {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                            activity.requestPermissions(permissions, CODE_PERMISSION_CAMERA);
                        }
                    }
                }
            }
        };
//        }

        act.addLifeCycleListener(lifeCycleListener);



        if (activity.checkCallingOrSelfPermission(permissions[0]) == PackageManager.PERMISSION_GRANTED) {
            startScan(activity);
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                activity.requestPermissions(permissions, CODE_PERMISSION_CAMERA);
            }
        }
    }

    private void startScan(Activity activity){
        //zxing 扫描
//        Intent intent = new Intent();
//        intent.setClass(act.getApplicationContext(), ScanActivity.class);
//        act.startActivityForResult(intent, REQUEST_CODE);
        //华为默认样式
        //            ScanUtil.startScan(activity, 0X01, new HmsScanAnalyzerOptions.Creator().create());
        Intent intent = new Intent(activity, DefinedActivity.class);
        activity.startActivityForResult(intent, REQUEST_CODE_DEFINE);
    }
}
