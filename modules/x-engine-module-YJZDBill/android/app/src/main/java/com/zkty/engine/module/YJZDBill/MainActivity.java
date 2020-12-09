package com.zkty.engine.module.yjzdbill;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Build;
import android.os.Bundle;
import android.view.View;

import com.zkty.modules.engine.utils.XEngineWebActivityManager;

public class MainActivity extends AppCompatActivity {

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void yjzdbill(View view) {
        XEngineWebActivityManager.sharedInstance().startMicroEngineActivity(this, "com.zkty.microapp.moduledemo", null, null, "0");

    }
}