package com.zkty.nativ.react_native;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.view.KeyEvent;
import android.widget.LinearLayout;

import androidx.appcompat.app.AppCompatActivity;

import com.alibaba.fastjson.JSONObject;
import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactPackage;
import com.facebook.react.ReactRootView;
import com.facebook.react.common.LifecycleState;
import com.facebook.react.modules.core.DefaultHardwareBackBtnHandler;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;

import module.react_native.R;

/**
 * @author : MaJi
 * @time : (12/7/21)
 * dexc :
 */
public class XEngineReactNativeActivity extends AppCompatActivity implements DefaultHardwareBackBtnHandler {

    private final int OVERLAY_PERMISSION_REQ_CODE = 1;  // 任写一个值
    private ReactRootView mReactRootView;
    private ReactInstanceManager mReactInstanceManager;


    public static void start(Activity activity, String moduleName, String assetsName, String modulePath, Map<String, String> query){
        Intent intent = new Intent(activity,XEngineReactNativeActivity.class);
        intent.putExtra("moduleName",moduleName);
        intent.putExtra("assetsName",assetsName);
        intent.putExtra("modulePath",modulePath);
        intent.putExtra("query", (Serializable) query);
        activity.startActivity(intent);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rn_main);
        SoLoader.init(this, false);

        String moduleName = getIntent().getStringExtra("moduleName");
        String assetsName = getIntent().getStringExtra("assetsName");
        String modulePath = getIntent().getStringExtra("modulePath");
        Map<String, String>  query = (Map<String, String>) getIntent().getSerializableExtra("query");


        LinearLayout lllayout = findViewById(R.id.lllayout);

        List<ReactPackage> packages = new ArrayList<>(Arrays.<ReactPackage>asList(
                new MainReactPackage(null)
        ));

        mReactRootView = new ReactRootView(this);
        mReactInstanceManager = ReactInstanceManager.builder().
                setApplication(getApplication())
                .setCurrentActivity(this)
                .setBundleAssetName(assetsName)
                .setJSMainModulePath(modulePath)
                .addPackages(packages)
                .setUseDeveloperSupport(true)
                .setInitialLifecycleState(LifecycleState.RESUMED)
                .build();
        // 注意这里的MyReactNativeApp 必须对应"index.js"中的
        // "AppRegistry.registerComponent()"的第一个参数
        //参数
        Bundle bundle = new Bundle();
        ArrayList<String> keyList = new ArrayList<>(query.keySet());
        for (String key : keyList) {
            bundle.putString(key,query.get(key));
        }
        mReactRootView.startReactApplication(mReactInstanceManager, moduleName, bundle);

        lllayout.addView(mReactRootView);


        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (!Settings.canDrawOverlays(this)) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                        Uri.parse("package:" + getPackageName()));
                startActivityForResult(intent, OVERLAY_PERMISSION_REQ_CODE);
            }
        }
    }
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == OVERLAY_PERMISSION_REQ_CODE) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                if (!Settings.canDrawOverlays(this)) {
                    // SYSTEM_ALERT_WINDOW permission not granted
                }
            }
        }
        mReactInstanceManager.onActivityResult(this, requestCode, resultCode, data);
    }

    @Override
    protected void onPause() {
        super.onPause();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostPause(this);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostResume(this, this);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostDestroy(this);
        }
        if (mReactRootView != null) {
            mReactRootView.unmountReactApplication();
        }
    }

    @Override
    public void onBackPressed() {
        if (mReactInstanceManager != null) {
            mReactInstanceManager.onBackPressed();
        } else {
            super.onBackPressed();
        }
    }
    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_MENU && mReactInstanceManager != null) {
            mReactInstanceManager.showDevOptionsDialog();
            return true;
        }
        return super.onKeyUp(keyCode, event);
    }

    @Override
    public void invokeDefaultOnBackPressed() {
        super.onBackPressed();
    }
}
