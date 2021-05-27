package com.zkty.engine.module.ui;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.RelativeLayout;

import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.engine.webview.WebViewPool;
import com.zkty.modules.engine.webview.XEngineWebView;
import com.zkty.modules.engine.webview.XOneWebViewPool;


public class MainActivity extends AppCompatActivity {
    private XEngineWebView mWebView;


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


    }

    public void ui(View view) {
        XEngineWebActivityManager.sharedInstance().startXEngineActivity(this, "http://172.20.10.6:9111/");
    }
}
