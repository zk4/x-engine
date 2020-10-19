package com.zkty.engine.module.demo;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Build;
import android.os.Bundle;
import android.widget.RelativeLayout;

import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.webview.WebViewPool;
import com.zkty.modules.engine.webview.XEngineWebView;


public class MainActivity extends AppCompatActivity {
    private XEngineWebView mWebView;


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mWebView = WebViewPool.sharedInstance().getUnusedWebViewFromPool();
        ((RelativeLayout) findViewById(R.id.rl_root)).addView(mWebView, 0);
        MicroAppLoader.sharedInstance().setRootPath("demo");
        String url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId("com.zkty.microapp.moduledemo");
        mWebView.loadUrl("http://192.168.3.103:8080");

    }
}
