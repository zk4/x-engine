package com.zkty.modules.engine.engine;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.widget.RelativeLayout;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.modules.engine.R;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.MicroAppLoader;
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

        mWebview = XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool();
        ((RelativeLayout) findViewById(R.id.rl_root)).addView(mWebview, 0);
        String url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId("com.zkty.microapp.moduledemo");
        mWebview.loadUrl(url);
    }


    // 复写安卓返回事件 转为响应 h5 返回
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if ((keyCode == KeyEvent.KEYCODE_BACK) && mWebview.canGoBack()) {
            mWebview.backUp();
            return true;
        } else {
            this.finish();
        }
        return super.onKeyDown(keyCode, event);
    }


    public void nextPage(View view) {
           startActivity(new Intent(this, XEngineWebActivity.class));
    }
}
