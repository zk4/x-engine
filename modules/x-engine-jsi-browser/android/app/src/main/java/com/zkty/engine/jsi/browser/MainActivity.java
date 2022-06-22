package com.zkty.engine.jsi.browser;

import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void browser(View view) {
//        XEngineWebActivityManager.sharedInstance().startH5EngineActivity(this, "http://www.baidu.com");
    }
}
