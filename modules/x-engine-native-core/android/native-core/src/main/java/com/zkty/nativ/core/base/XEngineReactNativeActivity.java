package com.zkty.nativ.core.base;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.view.View;
import android.widget.LinearLayout;

import androidx.appcompat.app.AppCompatActivity;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactInstanceManagerBuilder;
import com.facebook.react.ReactPackage;
import com.facebook.react.ReactRootView;
import com.facebook.soloader.SoLoader;

import java.util.List;

import nativ.core.R;

/**
 * @author : MaJi
 * @time : (12/7/21)
 * dexc :
 */
public class XEngineReactNativeActivity extends AppCompatActivity {

    private final int OVERLAY_PERMISSION_REQ_CODE = 1;  // 任写一个值
    private ReactRootView mReactRootView;
    private ReactInstanceManager mReactInstanceManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        SoLoader.init(this, false);
//        List<ReactPackage> packages = new PackageList(getApplication()).getPackages();


        String moduleName = getIntent().getStringExtra("moduleName");
        String scheme = getIntent().getStringExtra("scheme");
        String assetsName = getIntent().getStringExtra("assetsName");
        String modulePath = getIntent().getStringExtra("modulePath");




        mReactRootView = new ReactRootView(this);

        ReactInstanceManagerBuilder builder = ReactInstanceManager.builder();

        builder.setApplication(getApplication()).setCurrentActivity(this);
        builder.setBundleAssetName(assetsName);
        builder.setJSMainModulePath(modulePath);
        builder
//                .addPackages(packages)
                .setUseDeveloperSupport(true);
//                .setInitialLifecycleState(LifecycleState.RESUMED);

        mReactInstanceManager = builder.build();
        // 注意这里的MyReactNativeApp 必须对应"index.js"中的
        // "AppRegistry.registerComponent()"的第一个参数

        Bundle bundle = new Bundle();
        bundle.putString("title","标题1");
        mReactRootView.startReactApplication(mReactInstanceManager, moduleName, bundle);


        setContentView(mReactRootView);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (!Settings.canDrawOverlays(this)) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                        Uri.parse("package:" + getPackageName()));
                startActivityForResult(intent, OVERLAY_PERMISSION_REQ_CODE);
            }
        }

    }

}
