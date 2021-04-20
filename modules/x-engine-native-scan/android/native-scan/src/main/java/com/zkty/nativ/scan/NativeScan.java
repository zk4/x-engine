package com.zkty.nativ.scan;

import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.LifecycleListener;
import com.zkty.nativ.scan.activity.ScanActivity;

public class NativeScan extends NativeModule implements IScan {

    private static final String TAG = "xengine__module_scan";


    private int REQUEST_CODE = 0;
    private LifecycleListener lifeCycleListener;

    @Override
    public String moduleId() {
        return "com.zkty.native.scan";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public void openScanView(CallBack callBack) {
        REQUEST_CODE++;

        Activity activity = XEngineApplication.getCurrentActivity();
        if (activity == null || !(activity instanceof BaseXEngineActivity)) return;
        final BaseXEngineActivity act = (BaseXEngineActivity) activity;

//        if (lifeCycleListener == null) {
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
            }

            @Override
            public void onRequestPermissionsResult(int i, @NonNull String[] strings, @NonNull int[] ints) {

            }
        };
//        }
        act.addLifeCycleListener(lifeCycleListener);

        Intent intent = new Intent();
        intent.setClass(act.getApplicationContext(), ScanActivity.class);
        act.startActivityForResult(intent, REQUEST_CODE);

    }
}
