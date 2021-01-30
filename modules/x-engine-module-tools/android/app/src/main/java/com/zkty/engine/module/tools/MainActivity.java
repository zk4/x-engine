package com.zkty.engine.module.tools;

import android.Manifest;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

import com.zkty.tools.XEngineUtils;

import java.io.File;


public class MainActivity extends AppCompatActivity {
    private static final String TAG = MainActivity.class.getSimpleName();
//    private XEngineWebView mWebView;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.compress).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "compress!");

                File xdir = new File(Environment.getExternalStorageDirectory(), "x-engine-dir");
                if (xdir.exists()) {
                    File zip = new File(Environment.getExternalStorageDirectory(), "x-engine-dir.zip");
                    if (XEngineUtils.zipFile(xdir.getPath(), zip.getPath())) {
                        Log.d(TAG, "zip success!");
                    } else {
                        Log.d(TAG, "zip failed!");
                    }
                } else {
                    Log.d(TAG, "error no dir!");
                }


            }
        });

        findViewById(R.id.uncompress).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "uncompress!");

                File zip = new File(Environment.getExternalStorageDirectory(), "tj.zip");
                if (zip.exists()) {
                    File out = new File(Environment.getExternalStorageDirectory(), "tj-0");
                    if (XEngineUtils.unzipFile(zip.getPath(), out.getPath())) {
                        Log.d(TAG, "uncompress success!");
                    } else {
                        Log.d(TAG, "uncompress failed!");
                    }
                } else {
                    Log.d(TAG, "zip not exit!");
                }

            }
        });


        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.M) {
            requestPermissions(new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1001);
        }

//        mWebView = WebViewPool.sharedInstance().getUnusedWebViewFromPool();
//        ((RelativeLayout) findViewById(R.id.rl_root)).addView(mWebView, 0);
//        MicroAppLoader.sharedInstance().setRootPath("tools");
//        String url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId("com.zkty.microapp.moduledemo");
//        mWebView.loadUrl("http://192.168.3.103:8080");

    }
}
