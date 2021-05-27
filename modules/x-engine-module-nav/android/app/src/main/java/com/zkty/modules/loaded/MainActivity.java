package com.zkty.modules.loaded;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.engine.webview.XEngineWebView;
import com.zkty.modules.loaded.nav.R;


public class MainActivity extends AppCompatActivity {
    private XEngineWebView mWebView;


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(module.engine.R.color.white)
                .statusBarDarkFont(true).init();

    }


    public void nav(View view) {
        XEngineWebActivityManager.sharedInstance().startH5EngineActivity(this, "http://172.20.10.6:8080/");
    }

    public void navPush(View view) {
        XEngineWebActivityManager.sharedInstance().startMicroEngineActivity(this, "com.zkty.module.navpush", null, null, null);
    }
}
