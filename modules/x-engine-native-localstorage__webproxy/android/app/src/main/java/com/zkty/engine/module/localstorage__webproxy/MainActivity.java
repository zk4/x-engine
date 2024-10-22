package com.zkty.engine.module.localstorage__webproxy;

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

    public void localstorage__webproxy(View view) {
        XEngineWebActivityManager.sharedInstance().startH5EngineActivity(this, "http://www.baidu.com");
    }
}
