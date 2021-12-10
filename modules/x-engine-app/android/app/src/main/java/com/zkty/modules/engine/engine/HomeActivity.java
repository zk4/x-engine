package com.zkty.modules.engine.engine;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.modules.engine.R;
import com.zkty.nativ.direct.DirectManager;
import com.zkty.nativ.jsi.view.MicroAppsInstall;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.scan.activity.ScanActivity;

import java.util.HashMap;
import java.util.Map;

public class HomeActivity extends AppCompatActivity {

    private EditText et_content;

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        et_content = findViewById(R.id.et_content);


    }

    public void nextPage(View view) {
        String protocol = "http:";
        String host = et_content.getText().toString();
          protocol = "http:";
         host = "10.2.46.17:8848/%E8%B0%83%E8%AF%95/index.html";
        String pathname = "";
        String fragment = "";
        XEngineWebActivityManager.sharedInstance().startXEngineActivity(this, protocol, host, pathname, fragment, null, true);
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
                Map<String, String> params = new HashMap<>();
                params.put("hideNavbar", "true");
                DirectManager.push(data.getStringExtra("result"), params);

            }
        }
    }

    public void nextAct(View view) {
        HashMap<String, String> query = new HashMap<>();
        query.put("title","title1");
        query.put("sex","1");
        query.put("age","2");

        HashMap<String, String> params = new HashMap<>();
        params.put("moduleName","tarodemo");
        params.put("bundleAssetName","index.android.jsbundle");
        params.put("jsMainModulePath","index");

        DirectManager.push("lrn","","","",query,params);

//        MicroAppsInstall.sharedInstance().init(XEngineApplication.getApplication());
    }

    public void download(View view) {
        MicroAppsInstall.sharedInstance().downloadMicroApp("http://10.2.128.10:8000/11.zip");
    }
}
