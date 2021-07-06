package com.zkty.modules.engine.engine;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.alibaba.android.arouter.facade.annotation.Autowired;
import com.alibaba.android.arouter.facade.annotation.Route;
import com.alibaba.android.arouter.launcher.ARouter;
import com.zkty.modules.engine.R;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.DensityUtils;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.direct.DirectManager;
import com.zkty.nativ.jsi.view.MicroAppLoader;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.scan.activity.ScanActivity;

import java.util.HashMap;
import java.util.Map;

@Route(path = "/app/home")
public class HomeActivity extends AppCompatActivity {
    private XEngineWebView mWebview;

    @Autowired()
    String name;
    @Autowired()
    String age;

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        ARouter.getInstance().inject(this);
        ToastUtils.showNormalShortToast("name=" + name + ",age = " + age);

    }

    public void nextPage(View view) {
        String scheme = "microapp";
        String host = "com.zkty.microapp.demo";
        Map<String, String> params = new HashMap<>();
        params.put("hideNavbar", "true");

        DirectManager.push(scheme, host, null, null, null, params);

    }

    public void scan(View view) {
        Intent intent = new Intent(this, ScanActivity.class);
        startActivityForResult(intent, 100);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == 100) {
            if (data.hasExtra("result")) {
                Log.d("HomeActivity", "扫码结果：" + data.getStringExtra("result"));
                Map<String, String> params = new HashMap<>();
                params.put("hideNavbar", "true");
                DirectManager.push(data.getStringExtra("result"), params);

            }
        }
    }
}
