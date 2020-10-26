package com.zkty.demo.pedestal;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.loaded.jsapi.RouterMaster;

import activity.ScanActivity;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private static final int CODE_REQUEST_QRCODE = 0x10;
    private ImageView ivScan;
    private EditText editText;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(module.engine.R.color.white)
                .statusBarDarkFont(true).init();
        initView();
        initListener();

    }


    private void initView() {
        ivScan = findViewById(R.id.iv_main_scan);
        editText = findViewById(R.id.et_web);
    }

    private void initListener() {
        ivScan.setOnClickListener(this);
    }


    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.iv_main_scan:
                startActivityForResult(new Intent(MainActivity.this, ScanActivity.class), CODE_REQUEST_QRCODE);
                break;

            default:
                break;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == CODE_REQUEST_QRCODE) {
            if (data.hasExtra("result")) {
                String url = data.getStringExtra("result");
                if (!TextUtils.isEmpty(url) && url.startsWith("http")) {
                    RouterMaster.openTargetRouter(MainActivity.this, "h5", url, null);
                }
            }
        }
    }

    public void load(View view) {
        if (TextUtils.isEmpty(editText.getText())) {
            Toast.makeText(this, "请输入网址", Toast.LENGTH_LONG).show();
            return;
        }
        String url = editText.getText().toString();
        if (!url.startsWith("http")) {
            url = "http://" + url;
        }
        RouterMaster.openTargetRouter(MainActivity.this, "h5", url, null);

    }
}