package com.zkty.engine.module.camera;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.zkty.modules.engine.activity.XEngineWebActivity;


public class MainActivity extends AppCompatActivity {
    private TextView camera;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        camera = findViewById(R.id.camera);

        final StringBuilder sb = new StringBuilder();
        sb.append("file:///android_asset/")
                .append("com.zkty.microapp.")
                .append("camera.")
                .append("0")
                .append("/index.html");
        camera.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent();
//                intent.putExtra(XEngineWebActivity.URL, sb.toString());
                intent.putExtra(XEngineWebActivity.URL, "http://192.168.3.14:8080/");
                intent.setClass(MainActivity.this, XEngineWebActivity.class);
                startActivity(intent);
            }
        });
    }
}
