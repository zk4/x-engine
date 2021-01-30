package com.zkty.engine.module.xxxx.view.base;

import android.os.Bundle;
import android.util.Log;

import androidx.appcompat.app.AppCompatActivity;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.gyf.barlibrary.ImmersionBar;
import com.zkty.engine.module.xxxx.dto.MessageEvent;
import com.zkty.engine.module.xxxx.dto.MessageType;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.manager.SchemeManager;
import com.zkty.modules.loaded.jsapi.UniMPMaster;


import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;

import butterknife.ButterKnife;
import io.dcloud.feature.sdk.DCUniMPJSCallback;
import io.dcloud.feature.sdk.DCUniMPSDK;


public abstract class BaseActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayoutId());
        ButterKnife.bind(this);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(module.engine.R.color.white)
                .statusBarDarkFont(true).init();
        EventBus.getDefault().register(this);


    }


    protected abstract int getLayoutId();

    @Subscribe
    public void onMessage(MessageEvent messageEvent) {
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBus.getDefault().unregister(this);
        ImmersionBar.with(this).destroy();
    }


}