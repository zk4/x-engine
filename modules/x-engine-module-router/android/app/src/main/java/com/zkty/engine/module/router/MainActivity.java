package com.zkty.engine.module.router;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Build;
import android.os.Bundle;
import android.view.View;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.loaded.jsapi.RouterMaster;


public class MainActivity extends AppCompatActivity {


    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(module.engine.R.color.white)
                .statusBarDarkFont(true).init();


    }

    public void router(View view) {
        XEngineWebActivityManager.sharedInstance().startXEngineActivity(this, "http://192.168.0.167:8080");
    }

    public void h5(View view) {
        RouterMaster.openTargetRouter(this, "h5", "https://baidu.com", null);

    }

    public void microApp(View view) {
        RouterMaster.openTargetRouter(this, "microapp", "com.zkty.microapp.moduledemo", null);

    }

    public void xcx(View view) {
    }

    public void uniApp(View view) {

        RouterMaster.openTargetRouter(this, "uni", "__UNI__5DE1E68", null);
    }

    public void nativePage(View view) {
        RouterMaster.openTargetRouter(this, "native", "com.zkty.engine.module.router.SecondActivity", null);

    }
}
