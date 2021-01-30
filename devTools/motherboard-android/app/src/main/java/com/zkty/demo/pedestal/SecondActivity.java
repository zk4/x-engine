package com.zkty.demo.pedestal;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.modules.loaded.jsapi.RouterMaster;

public class SecondActivity extends AppCompatActivity {


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