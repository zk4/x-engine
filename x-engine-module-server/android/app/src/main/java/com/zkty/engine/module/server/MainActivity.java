package com.zkty.engine.module.server;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Build;
import android.os.Bundle;
import android.widget.RelativeLayout;

import com.zkty.modules.loaded.webview.WebViewPool;
import com.zkty.modules.loaded.webview.XEngineWebView;

public class MainActivity extends AppCompatActivity {
    private XEngineWebView mWebView;


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mWebView = WebViewPool.sharedInstance().getUnusedWebViewFromPool();
        ((RelativeLayout) findViewById(R.id.rl_root)).addView(mWebView, 0);

        StringBuilder sb = new StringBuilder();
        sb.append("file:///android_asset/server/")
                .append("com.zkty.microapp.")
                .append("moduledemo.")
                .append("0")
                .append("/index.html");
        mWebView.loadUrl(sb.toString());

    }
}
