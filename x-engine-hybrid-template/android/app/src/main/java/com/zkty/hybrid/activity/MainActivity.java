package com.zkty.hybrid.activity;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.hybrid.R;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

public class MainActivity extends AppCompatActivity {
    private static final String TAG = MainActivity.class.getSimpleName();


    private Intent intent;


    private int CODE_REQUEST_QRCODE = 1;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        findViewById(R.id.modules).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                Toast.makeText(MainActivity.this, "暂未开放！", Toast.LENGTH_SHORT).show();
//                intent = new Intent(MainActivity.this, ModulesTestActivity.class);
//                startActivity(intent);
//                intent = new Intent(MainActivity.this, FingerprintActivity.class);
//                startActivity(intent);
            }
        });

        findViewById(R.id.microapps).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                intent = new Intent(MainActivity.this, MicroAppsListTestActivity.class);
                startActivity(intent);
            }
        });

        findViewById(R.id.qrcode).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivityForResult(new Intent(MainActivity.this, QrCodeActivity.class), CODE_REQUEST_QRCODE);
            }
        });

        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.M) {
            requestPermissions(new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1001);
        }
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == CODE_REQUEST_QRCODE) {
            if (data.hasExtra("result")) {
                String url = data.getStringExtra("result");
                if (!TextUtils.isEmpty(url)) {
                    XEngineWebActivityManager.sharedInstance().startXEngineActivity(this, url);
                }
            }
        }
    }

    private void unzip() {
        InputStream inputStream = null;
        FileOutputStream outputStream = null;
        try {
            ZipFile zipFile = new ZipFile(new File(Environment.getExternalStorageDirectory(), "__UNI__11E9B73.wgt"));
            if (zipFile != null) {
                Log.d(TAG, "zip name:" + zipFile.getName());
                Log.d(TAG, "zip entry size:" + zipFile.size());


                Enumeration<? extends ZipEntry> enumeration = zipFile.entries();


                File unzipDir = new File(Environment.getExternalStorageDirectory(), "unzip");
                if (!unzipDir.exists()) {
                    unzipDir.mkdirs();
                }

                while (enumeration.hasMoreElements()) {
                    ZipEntry zipEntry = enumeration.nextElement();
                    if (zipEntry.isDirectory()) {
                        Log.d(TAG, "dir:" + zipEntry.getName() + "---" + zipEntry.getCrc());

                        File f = new File(unzipDir, zipEntry.getName());
                        f.mkdirs();
                    } else {
                        Log.d(TAG, "file:" + zipEntry.getName() + "---" + zipEntry.getCrc());
                        File f = new File(unzipDir, zipEntry.getName());
                        f.createNewFile();

                        inputStream = zipFile.getInputStream(zipEntry);
                        outputStream = new FileOutputStream(f);
                        byte[] readed = new byte[1024];
                        int count;
                        while ((count = inputStream.read(readed)) != -1) {
                            outputStream.write(readed, 0, count);
                        }
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (outputStream != null) {
                    outputStream.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}