package com.zkty.modules.engine.engine;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.modules.engine.R;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.DensityUtils;
import com.zkty.nativ.direct.DirectManager;
import com.zkty.nativ.jsi.view.MicroAppLoader;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.scan.activity.ScanActivity;

import java.util.HashMap;
import java.util.Map;

public class HomeActivity extends AppCompatActivity {
    private XEngineWebView mWebview;

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

    }

    public void nextPage(View view) {
        String protocol = "file:";
        String host = "com.zkty.module.share";
//          protocol = "http:";
//         host = "10.2.128.89:8080";


        String pathname = "";
        String fragment = "";


        XEngineWebActivityManager.sharedInstance().startXEngineActivity(this, protocol, host, pathname, fragment, null, true);
    }

    public void scan(View view) {
        Intent intent = new Intent(this, ScanActivity.class);
        startActivityForResult(intent, 100);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == 100) {
            if (data.hasExtra("result")) {
                Map<String, String> params = new HashMap<>();
                params.put("hideNavbar", "true");
                DirectManager.push(data.getStringExtra("result"), params);

            }
        }
    }
}
