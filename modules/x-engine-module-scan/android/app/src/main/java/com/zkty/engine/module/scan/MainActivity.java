package com.zkty.engine.module.scan;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.modules.engine.activity.XEngineWebActivity;


public class MainActivity extends AppCompatActivity {
    private static final String TAG = MainActivity.class.getSimpleName();

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.code).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent();
                intent.putExtra(XEngineWebActivity.URL, "http://192.168.0.180:9111/");
                intent.setClass(MainActivity.this, XEngineWebActivity.class);
                startActivity(intent);

//                Intent intent = new Intent();
//                intent.setClass(MainActivity.this, ScanActivity.class);
//                startActivity(intent);
            }
        });
    }
}
