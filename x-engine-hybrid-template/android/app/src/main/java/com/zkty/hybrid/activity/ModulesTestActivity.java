package com.zkty.hybrid.activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.hybrid.R;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.manager.MicroAppsManager;

import java.io.File;

public class ModulesTestActivity extends AppCompatActivity {
    private static final String TAG = ModulesTestActivity.class.getSimpleName();


    private Intent intent;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_modules_test_layout);
        findViewById(R.id.network).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                intent = new Intent(ModulesTestActivity.this, XEngineWebActivity.class);
                intent.putExtra(XEngineWebActivity.URL, "http://192.168.3.121:8083/");
                startActivity(intent);
            }
        });

        findViewById(R.id.camera).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String path = MicroAppsManager.getInstance().getMicroAppPath("com.zkty.microapp.camera");
                if (!TextUtils.isEmpty(path)) {
                    intent = new Intent(ModulesTestActivity.this, XEngineWebActivity.class);
                    Uri uri = Uri.fromFile(new File(path, "index.html"));
                    intent.putExtra(XEngineWebActivity.URL, uri.toString());
                    startActivity(intent);
                } else {
                    Toast.makeText(ModulesTestActivity.this, "敬请期待！", Toast.LENGTH_SHORT).show();
                }
            }
        });

        findViewById(R.id.localStorage).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String path = MicroAppsManager.getInstance().getMicroAppPath("com.zkty.microapp.localStorage");
                if (!TextUtils.isEmpty(path)) {
                    intent = new Intent(ModulesTestActivity.this, XEngineWebActivity.class);
                    Uri uri = Uri.fromFile(new File(path, "index.html"));
                    intent.putExtra(XEngineWebActivity.URL, uri.toString());
                    startActivity(intent);
                } else {
                    Toast.makeText(ModulesTestActivity.this, "敬请期待！", Toast.LENGTH_SHORT).show();
                }
            }
        });

        findViewById(R.id.dcloud).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                intent = new Intent(ModulesTestActivity.this, XEngineWebActivity.class);
                intent.putExtra(XEngineWebActivity.URL, "http://192.168.3.121:8081");
                startActivity(intent);
            }
        });

        findViewById(R.id.nav).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                intent = new Intent(ModulesTestActivity.this, XEngineWebActivity.class);
                intent.putExtra(XEngineWebActivity.URL, "http://192.168.3.121:8082/");
                startActivity(intent);
            }
        });

    }
}
