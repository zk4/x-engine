package com.zkty.engine.module.tzcash;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.RelativeLayout;

import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.webview.WebViewPool;
import com.zkty.modules.engine.webview.XEngineWebView;

import pay.PayUtils;


public class MainActivity extends AppCompatActivity {


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        findViewById(R.id.pay).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                PayUtils.Pay(MainActivity.this, "", "", "", "", new PayUtils.PayResultListener() {
                    @Override
                    public void onPayResultListener(String result) {

                    }
                });
            }
        });

    }
}
