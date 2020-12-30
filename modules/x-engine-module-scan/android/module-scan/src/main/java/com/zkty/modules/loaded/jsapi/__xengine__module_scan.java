package com.zkty.modules.loaded.jsapi;


import android.app.Activity;
import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.dsbridge.OnReturnValue;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import activity.ScanActivity;

public class __xengine__module_scan extends xengine__module_scan {
    private static final String TAG = "xengine__module_scan";


    private int REQUEST_CODE = 0;
    private XEngineWebActivity.LifecycleListener lifeCycleListener;

    @Override
    public void _openScanView(final ScanOpenDto dto, final CompletionHandler<Nullable> handler) {
        Log.d(TAG, JSONObject.toJSONString(dto));

        XEngineWebActivity xEngineWebActivity = XEngineWebActivityManager.sharedInstance().getCurrent();

        if (lifeCycleListener == null) {
            lifeCycleListener = new XEngineWebActivity.LifecycleListener() {
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
                    if (resultCode == Activity.RESULT_OK && requestCode == REQUEST_CODE) {
                        if (intent.hasExtra("result")) {
                            String code = intent.getStringExtra("result");
                            if (!TextUtils.isEmpty(code)) {
                                if (mXEngineWebView != null) {
                                    mXEngineWebView.callHandler(dto.__event__, new Object[]{code}, new OnReturnValue<Object>() {
                                        @Override
                                        public void onValue(Object retValue) {

                                        }
                                    });
                                }
                            }
                        }
                    }
                }

                @Override
                public void onRequestPermissionsResult(int i, @NonNull String[] strings, @NonNull int[] ints) {

                }
            };
        }
        xEngineWebActivity.addLifeCycleListener(lifeCycleListener);

        Intent intent = new Intent();
        intent.setClass(xEngineWebActivity.getApplicationContext(), ScanActivity.class);
        xEngineWebActivity.startActivityForResult(intent, REQUEST_CODE);
        handler.complete();
    }
}
