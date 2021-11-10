package com.zkty.engine.jsi.rn_direct;

import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void rn_direct(View view) {
//        XEngineWebActivityManager.sharedInstance().startH5EngineActivity(this, "http://www.baidu.com");
    }
}
