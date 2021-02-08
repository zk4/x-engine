package com.zkty.modules.engine.engine;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.RelativeLayout;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.alibaba.fastjson.JSON;
import com.zkty.modules.engine.R;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.dto.PermissionDto;
import com.zkty.modules.engine.manager.MicroAppPermissionManager;
import com.zkty.modules.engine.webview.XEngineWebView;
import com.zkty.modules.engine.webview.XOneWebViewPool;

public class HomeActivity extends AppCompatActivity {
    private XEngineWebView mWebview;

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        int option = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
        getWindow().getDecorView().setSystemUiVisibility(option);
        // 设置状态栏背景色和字体颜色
        getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        getWindow().setStatusBarColor(getResources().getColor(R.color.colorPrimary));

        mWebview = XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool("com.times.microapp.test");
        ((RelativeLayout) findViewById(R.id.rl_root)).addView(mWebview, 0);
        String url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId("com.times.microapp.test");
        PermissionDto dto = MicroAppPermissionManager.sharedInstance().getPermission("com.times.microapp.test", "0");
        Log.d("HomeActivity", JSON.toJSONString(dto));
        mWebview.setPermission(dto);
        mWebview.loadUrl(url);


    }

    public void nextPage(View view) {
        startActivity(new Intent(this, XEngineWebActivity.class));
    }
}
