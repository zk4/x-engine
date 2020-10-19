package com.zkty.modules.engine.engine;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.zkty.modules.engine.R;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.webview.XEngineWebView;
import com.zkty.modules.engine.webview.XOneWebViewPool;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
     private XEngineWebView mWebview;
    private List<XEngineWebView> webViews = new ArrayList<>();
    private LinearLayout llRoot;

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        int option = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE;
        getWindow().getDecorView().setSystemUiVisibility(option);
        // 设置状态栏背景色和字体颜色
        getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        getWindow().setStatusBarColor(getResources().getColor(R.color.colorPrimary));

         mWebview = XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool();
        llRoot = findViewById(R.id.rl_root);
        llRoot.addView(mWebview, 0);
        String url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId("com.zkty.microapp.moduledemo");
        mWebview.loadUrl(url);
    }


    // 复写安卓返回事件 转为响应 h5 返回
//    @Override
//    public boolean onKeyDown(int keyCode, KeyEvent event) {
//        if ((keyCode == KeyEvent.KEYCODE_BACK) && mWebview.canGoBack()) {
//            mWebview.goBack();
//            return true;
//        } else {
//            this.finish();
//        }
//        return super.onKeyDown(keyCode, event);
//    }

    public void addView(View view) {
        XEngineWebView webView = XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool();
        ViewGroup.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 50);
        webView.setBackgroundColor(getResources().getColor(webViews.size() % 2 == 0 ? R.color.colorBlue : R.color.colorRed));
        webView.setLayoutParams(params);
        llRoot.addView(webView, webViews.size());
        webViews.add(webView);
    }

    public void removeView(View view) {

    }

}
