package com.zkty.engine.jsi.camera;

import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

import com.zkty.nativ.jsi.view.XEngineWebActivityManager;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void camera(View view) {

        XEngineWebActivityManager.sharedInstance().startXEngineActivity(this, "omp","10.2.128.89:9111","","/",true);
    }
}
