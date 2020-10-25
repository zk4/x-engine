package com.zkty.engine.module.offline.activitys;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import com.zkty.engine.module.offline.R;
import com.zkty.modules.engine.manager.MicroAppsManager;
import com.zkty.modules.engine.utils.FileUtils;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;
import com.zkty.modules.loaded.callback.XEngineNetRequest;
import com.zkty.modules.loaded.callback.XEngineNetResponse;
import com.zkty.modules.loaded.imp.MicroAppsUpdateManager;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private static final String TAG = MainActivity.class.getSimpleName();

    private TextView install;
    private TextView micro;

    private TextView last;
    private TextView lastApps;

    private TextView uninstall;

    private TextView remote;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        install = findViewById(R.id.install);
        micro = findViewById(R.id.micro);

        last = findViewById(R.id.last);
        lastApps = findViewById(R.id.last_apps);

        uninstall = findViewById(R.id.uninstall);

        remote = findViewById(R.id.remote);

        install.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                checkStoragePermission();

                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        String prefix = "moduleApps/";
                        String app = "";
                        String version = "";
                        try {
                            //
                            app = "com.zkty.microapp.xiaoqu.door";
                            version = "0";
                            InputStream asset = getAssets().open(prefix + app + "." + version + ".zip");
                            MicroAppsManager.getInstance().installFormAsset(asset, app, version);


                            //
                            app = "com.zkty.microapp.xiaoqu.door";
                            version = "1";
                            asset = getAssets().open(prefix + app + "." + version + ".zip");
                            MicroAppsManager.getInstance().installFormAsset(asset, app, version);

                            //
                            app = "com.zkty.microapp.xiaoqu.door";
                            version = "2";
                            asset = getAssets().open(prefix + app + "." + version + ".zip");
                            MicroAppsManager.getInstance().installFormAsset(asset, app, version);

                            //
                            app = "com.zkty.microapp.xiaoqu.door";
                            version = "2";
                            asset = getAssets().open(prefix + app + "." + version + ".zip");
                            MicroAppsManager.getInstance().installFormAsset(asset, app, version);

                            //
                            app = "com.zkty.microapp.camera";
                            version = "0";
                            asset = getAssets().open(prefix + app + "." + version + ".zip");
                            MicroAppsManager.getInstance().installFormAsset(asset, app, version);


                            //
                            app = "com.zkty.microapp.pullDownRefresh";
                            version = "0";
                            asset = getAssets().open(prefix + app + "." + version + ".zip");
                            MicroAppsManager.getInstance().installFormAsset(asset, app, version);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }).start();
            }
        });
        micro.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent ii = new Intent(MainActivity.this, MicroAppListActivity.class);
                startActivity(ii);
            }
        });


        last.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                StringBuilder stringBuilder = new StringBuilder();

                ArrayList<String> apps = MicroAppsManager.getInstance().listAllMicroApps();
                if (apps != null) {
                    for (int i = 0; i < apps.size(); i++) {
                        int version = MicroAppsManager.getInstance().getHighMicroAppVersionCode(apps.get(i));
                        stringBuilder.append(apps.get(i)).append("----").append(version).append("\n");
                    }
                }

                lastApps.setText(stringBuilder.toString());
            }
        });

        uninstall.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                File apps = MicroAppsManager.getInstance().getWebAppRoot();
                if (apps.exists()) {
                    FileUtils.deleteFile(apps);
                }
            }
        });

        remote.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "remote!");
                MicroAppsUpdateManager microAppsUpdateManager = new MicroAppsUpdateManager();
                microAppsUpdateManager.checkMicroAppsUpdate("http://192.168.43.40:80", "/microApp.json", "", "", 0, new IXEngineNetProtocolCallback() {
                    @Override
                    public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {         //注意不要在这里读取数据流
                        Log.d(TAG, "success!");
                    }

                    @Override
                    public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

                    }

                    @Override
                    public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

                    }

                    @Override
                    public void onFailed(XEngineNetRequest request, String error) {
                        Log.d(TAG, "error:" + error);
                    }
                });

            }
        });

        checkStoragePermission();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }

    private void checkStoragePermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            int code = ActivityCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE);
            if (code == PackageManager.PERMISSION_DENIED) {
                requestPermissions(new String[]{Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE}, 0);
            }
        }
    }
}