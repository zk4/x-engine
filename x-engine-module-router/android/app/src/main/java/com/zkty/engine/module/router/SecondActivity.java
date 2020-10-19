package com.zkty.engine.module.router;

import android.os.Build;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.loaded.jsapi.RouterMaster;


public class SecondActivity extends AppCompatActivity {


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(module.engine.R.color.white)
                .statusBarDarkFont(true).init();


    }


}
