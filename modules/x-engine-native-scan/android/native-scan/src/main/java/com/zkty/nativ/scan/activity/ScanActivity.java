package com.zkty.nativ.scan.activity;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.NotificationManagerCompat;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.nativ.core.utils.ToastUtils;

import cn.bingoogolapple.qrcode.core.QRCodeView;
import cn.bingoogolapple.qrcode.zxing.ZXingView;
import nativ.scan.R;


public class ScanActivity extends AppCompatActivity {
    private static final String TAG = ScanActivity.class.getSimpleName();


    private ZXingView zXingView;
    private TextView hint;
    private int CODE_PERMISSION_CAMERA = 1;

    private String[] permissions = {Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE};


    private boolean flashStatus = false;
    private ImageView flash;
    private ImageView mBack;

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_scan_layout);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(R.color.white)
                .statusBarDarkFont(true).init();

        zXingView = findViewById(R.id.zxingview);
        mBack = (ImageView) findViewById(R.id.activity_scan_layout_img);
        hint = findViewById(R.id.hint);

        zXingView.setDelegate(new QRCodeView.Delegate() {
            @Override
            public void onScanQRCodeSuccess(String result) {
                Log.d(TAG, result);
                Intent intent = new Intent();
                intent.putExtra("result", result);
                setResult(Activity.RESULT_OK, intent);
                finish();
            }

            @Override
            public void onCameraAmbientBrightnessChanged(boolean isDark) {
                if (isDark) {
                    String str = "环境过暗，请打开闪光灯！";
                    if (NotificationManagerCompat.from(ScanActivity.this).areNotificationsEnabled()) {
                        ToastUtils.showNormalShortToast(str);
                    } else {
                        hint.setText(str);
                    }
                }
            }

            @Override
            public void onScanQRCodeOpenCameraError() {
                String str = "摄像头错误！";
                if (NotificationManagerCompat.from(ScanActivity.this).areNotificationsEnabled()) {
                    ToastUtils.showNormalShortToast(str);
                } else {
                    hint.setText(str);
                }
            }
        });

        flash = findViewById(R.id.flash);
        flash.setImageResource(R.mipmap.flash_off);
        flash.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!flashStatus) {
                    flashStatus = true;
                    zXingView.openFlashlight();
                    flash.setImageResource(R.mipmap.flash_on);
                } else {
                    flashStatus = false;
                    zXingView.closeFlashlight();
                    flash.setImageResource(R.mipmap.flash_off);
                }
            }
        });
        mBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }


    @Override
    protected void onStart() {
        super.onStart();
        if (checkCallingOrSelfPermission(permissions[0]) == PackageManager.PERMISSION_GRANTED) {
            startScan();
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                requestPermissions(permissions, CODE_PERMISSION_CAMERA);
            }
        }
    }


    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == CODE_PERMISSION_CAMERA) {
            if (checkCallingOrSelfPermission(permissions[0]) == PackageManager.PERMISSION_GRANTED) {
                startScan();
            } else {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    requestPermissions(permissions, CODE_PERMISSION_CAMERA);
                }
            }
        }
    }


    private void startScan() {
        zXingView.startCamera(); // 打开后置摄像头开始预览，但是并未开始识别
//        mZXingView.startCamera(Camera.CameraInfo.CAMERA_FACING_FRONT); // 打开前置摄像头开始预览，但是并未开始识别
        zXingView.startSpotAndShowRect(); // 显示扫描框，并开始识别
    }

    @Override
    protected void onStop() {
        zXingView.stopCamera(); // 关闭摄像头预览，并且隐藏扫描框
        super.onStop();
        zXingView.closeFlashlight();
    }

    @Override
    protected void onDestroy() {
        zXingView.onDestroy(); // 销毁二维码扫描控件
        ImmersionBar.with(this).destroy();
        super.onDestroy();
    }
}
