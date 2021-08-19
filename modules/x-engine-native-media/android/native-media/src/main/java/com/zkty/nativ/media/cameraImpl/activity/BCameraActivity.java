package com.zkty.nativ.media.cameraImpl.activity;

import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.gyf.barlibrary.ImmersionBar;

import module.media.R;


public abstract class BCameraActivity extends AppCompatActivity {


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(View.inflate(this, bindLayout(), null));
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(R.color.white)
                .statusBarDarkFont(true).init();

        initConfig();
        initView();
        initListener();
        getData();
    }


    protected abstract int bindLayout();

    protected void initConfig() {
    }

    protected abstract void initView();

    protected abstract void initListener();

    protected abstract void getData();


}
