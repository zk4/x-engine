package com.zkty.engine.jsi.localstorage;

import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void localstorage(View view) {
//        XEngineWebActivityManager.sharedInstance().startH5EngineActivity(this, "http://www.baidu.com");
    }
}
