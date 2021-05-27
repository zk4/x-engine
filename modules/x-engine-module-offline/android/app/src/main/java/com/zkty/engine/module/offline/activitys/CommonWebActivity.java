package com.zkty.engine.module.offline.activitys;

import android.net.Uri;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.webkit.WebView;
import android.widget.LinearLayout;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.engine.module.offline.R;
import com.zkty.modules.engine.manager.MicroAppsManager;
import com.zkty.modules.engine.webview.WebViewPool;
import com.zkty.modules.engine.webview.XEngineWebView;

import java.io.File;

public class CommonWebActivity extends AppCompatActivity {
    private static final String TAG = CommonWebActivity.class.getSimpleName();

    private XEngineWebView webView;
    private LinearLayout container;

    public static final String KEY_URI = "microAppId";

    private String microApp;

    private String getAppPath(String microApp) {
        String path = MicroAppsManager.getInstance().getMicroAppPath(microApp) + "/index.html";
        Uri uu = Uri.fromFile(new File(path));
        return uu.toString();
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_common_web_layout);
        container = findViewById(R.id.container);
        webView = WebViewPool.sharedInstance().getUnusedWebViewFromPool();
        container.addView(webView);

        webView.getSettings().setAllowFileAccess(true);
        webView.getSettings().setAllowContentAccess(true);
        webView.getSettings().setAllowFileAccessFromFileURLs(true);

        if (getIntent().hasExtra(KEY_URI)) {
            microApp = getIntent().getStringExtra(KEY_URI);
        }

        if (!TextUtils.isEmpty(microApp)) {
            String path = getAppPath(microApp);
            Log.d(TAG, "path:" + path);
            webView.loadUrl(path);
        } else {
            Toast.makeText(this, "url invalid!", Toast.LENGTH_SHORT).show();
        }

    }
}
