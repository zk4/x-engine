package com.zkty.modules.engine.engine;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.modules.engine.R;
import com.zkty.nativ.broadcast.IBroadcast;
import com.zkty.nativ.broadcast.NativeBroadcast;
import com.zkty.nativ.core.ActivityStackManager;
import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.direct.DirectManager;
import com.zkty.nativ.jsi.view.MicroAppsInstall;
import com.zkty.nativ.jsi.view.XEngineWebActivityManager;
import com.zkty.nativ.scan.activity.ScanActivity;
import com.zkty.nativ.viewer.CallBack;
import com.zkty.nativ.viewer.Iviewer;
import com.zkty.nativ.viewer.Nativeviewer;

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
        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(Iviewer.class);
        if (module instanceof Nativeviewer) {
            Nativeviewer iView = (Nativeviewer) module;
            iView.openFileReader("http://10.2.46.11:8080/Desktop/111.docx", "docx", "111", new CallBack() {
                @Override
                public void success(String dto) {

                }
            });

        }


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
        MicroAppsInstall.sharedInstance().init(XEngineApplication.getApplication());
    }

    public void download(View view) {
        MicroAppsInstall.sharedInstance().downloadMicroApp("http://10.2.128.10:8000/11.zip");
    }
}
