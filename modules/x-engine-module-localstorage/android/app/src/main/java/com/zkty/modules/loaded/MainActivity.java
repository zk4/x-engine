package com.zkty.modules.loaded;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.RelativeLayout;

import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.engine.webview.WebViewPool;
import com.zkty.modules.engine.webview.XEngineWebView;
import com.zkty.modules.localstorage.R;

public class MainActivity extends AppCompatActivity {
//    private XEngineWebView mWebView;


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

//        mWebView = WebViewPool.sharedInstance().getUnusedWebViewFromPool();

//        ((RelativeLayout) findViewById(R.id.rl_root)).addView(mWebView, 0);
//        String url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId("com.zkty.microapp.moduledemo");
//         mWebView.loadUrl(url);
//        mWebView.loadUrl("http://192.168.3.205:8080");


    }

    public void localStorage(View view) {
        XEngineWebActivityManager.sharedInstance().startXEngineActivity(this,"http://192.168.3.205:8080");
    }
}
