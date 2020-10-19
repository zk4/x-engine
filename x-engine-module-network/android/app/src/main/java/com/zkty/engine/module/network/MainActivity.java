package com.zkty.engine.module.network;

import android.Manifest;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.View;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.utils.ResourceManager;
import com.zkty.modules.loaded.callback.IXEngineNetProtocol;
import com.zkty.modules.loaded.callback.IXEngineNetProtocolCallback;
import com.zkty.modules.loaded.callback.XEngineNetRequest;
import com.zkty.modules.loaded.callback.XEngineNetResponse;
import com.zkty.modules.loaded.imp.DebugUtils;
import com.zkty.modules.loaded.imp.XEngineNetImpl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;


public class MainActivity extends AppCompatActivity {
    private static final String TAG = MainActivity.class.getSimpleName();


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.download).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String url = "https://8d43e215e8343f810d26627a6ca96c6b.dlied1.cdntips.net/dlied1.qq.com/qqweb/QQ_1/android_apk/Androidqq_8.4.8.4810_537065343.apk?mkey=5f6c0d257b78981c&f=8504&cip=123.120.190.233&proto=https&access_type=$header_ApolloNet";


                XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.GET, url, null, null, null, new IXEngineNetProtocolCallback() {
                    @Override
                    public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {

                        String temp = url.substring(url.lastIndexOf("/") + 1, url.length());
                        if (temp.contains("?")) {
                            temp = temp.substring(0, temp.lastIndexOf("?"));
                        }
                        DebugUtils.debug(TAG, "file name:" + temp);
                        DebugUtils.debug(TAG, "resp:" + response.toString());


                        File out = new File(ResourceManager.getCacheDir(), temp);
                        InputStream inputStream = null;
                        FileOutputStream outputStream = null;
                        try {
                            if (!out.exists()) {
                                out.createNewFile();
                            }
                            inputStream = response.getBody();
                            outputStream = new FileOutputStream(out);
                            long count = 0, total = 0;
                            long contentLength = response.getContentLength();

                            byte[] b = new byte[1024];
                            while (true) {
                                count = inputStream.read(b);
                                total = total + count;
                                if (count == -1) {

                                    break;
                                }
                                outputStream.write(b, 0, (int) count);
                                onDownLoadProgress(request, response, total, contentLength, total == contentLength);
                            }
                        } catch (IOException e) {

                        } finally {
                            try {
                                if (inputStream != null) {
                                    inputStream.close();
                                }
                                if (outputStream != null) {
                                    outputStream.close();
                                }
                            } catch (IOException e) {

                            }
                        }
                    }

                    @Override
                    public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {

                    }


                    int last = 0;

                    @Override
                    public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {
                        int progress = (int) ((bytesReaded * 100) / contentLength);
                        if (last != progress) {
                            Log.d(TAG, "readed:" + bytesReaded + "---contentLength:" + contentLength + "---progress:" + progress);
                        }
                        last = progress;
                    }

                    @Override
                    public void onFailed(XEngineNetRequest request, String error) {
                        DebugUtils.debug(TAG, "error:" + error);
                    }
                });

            }
        });


        findViewById(R.id.upload).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String url = "http://192.168.3.121:8888/";

                File jpg = new File(Environment.getExternalStorageDirectory(), "cat.jpg");

                if (!jpg.exists()) {
                    Log.d(TAG, "no exit!");
                    return;
                }
                Log.d(TAG, "exit!");

                Map<String, String> file = new HashMap<>();
                file.put("cat.jpg", jpg.getParent());
                XEngineNetImpl.getInstance().doRequest(IXEngineNetProtocol.Method.POST, url, null, null, file, new IXEngineNetProtocolCallback() {
                    @Override
                    public void onSuccess(XEngineNetRequest request, XEngineNetResponse response) {
                        DebugUtils.debug(TAG, "resp:" + response.toString());
                    }


                    private int last = 0;

                    @Override
                    public void onUploadProgress(XEngineNetRequest request, long bytesWritten, long contentLength, boolean done) {
                        DebugUtils.debug(TAG, "upload----written:" + bytesWritten + "---contentLength:" + contentLength + "---done:" + done);
                        int progress = (int) ((bytesWritten * 100) / contentLength);
                        if (last != progress) {
                            DebugUtils.debug(TAG, "progress:" + progress);
                        }
                        last = progress;
                    }

                    @Override
                    public void onDownLoadProgress(XEngineNetRequest request, XEngineNetResponse response, long bytesReaded, long contentLength, boolean done) {

                    }

                    @Override
                    public void onFailed(XEngineNetRequest request, String error) {
                        DebugUtils.debug(TAG, "error:" + error);
                    }
                });
            }
        });

        findViewById(R.id.app).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startWeb();
            }
        });

        requestPermissions(new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE}, 1);
    }


    private void startWeb() {
        Intent intent = new Intent(MainActivity.this, XEngineWebActivity.class);
        intent.putExtra(XEngineWebActivity.URL, "http://192.168.3.121:8080/");
        startActivity(intent);
    }
}
