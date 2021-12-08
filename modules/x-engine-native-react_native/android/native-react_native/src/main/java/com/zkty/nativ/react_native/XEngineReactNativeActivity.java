package com.zkty.nativ.react_native;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactRootView;
import com.facebook.react.common.LifecycleState;
import com.facebook.soloader.SoLoader;

/**
 * @author : MaJi
 * @time : (12/7/21)
 * dexc :
 */
public class XEngineReactNativeActivity extends AppCompatActivity {

    private final int OVERLAY_PERMISSION_REQ_CODE = 1;  // 任写一个值
    private ReactRootView mReactRootView;
    private ReactInstanceManager mReactInstanceManager;


    public static void start(Activity activity, String moduleName, String assetsName, String modulePath){
        Intent intent = new Intent(activity,XEngineReactNativeActivity.class);
        intent.putExtra("moduleName",moduleName);
        intent.putExtra("assetsName",assetsName);
        intent.putExtra("modulePath",modulePath);
        activity.startActivity(intent);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        SoLoader.init(this, false);
//        List<ReactPackage> packages = new PackageList(getApplication()).getPackages();

        String moduleName = getIntent().getStringExtra("moduleName");
        String assetsName = getIntent().getStringExtra("assetsName");
        String modulePath = getIntent().getStringExtra("modulePath");


        mReactRootView = new ReactRootView(this);


        mReactInstanceManager = ReactInstanceManager.builder().
                setApplication(getApplication())
                .setCurrentActivity(this)
                .setBundleAssetName(assetsName)
                .setJSMainModulePath(modulePath)
//                .addPackages(packages)
                .setUseDeveloperSupport(false)
                .setInitialLifecycleState(LifecycleState.RESUMED)
                .build();
        // 注意这里的MyReactNativeApp 必须对应"index.js"中的
        // "AppRegistry.registerComponent()"的第一个参数
        Bundle bundle = new Bundle();
        bundle.putString("title","标题1");
        mReactRootView.startReactApplication(mReactInstanceManager, moduleName, bundle);

        setContentView(mReactRootView);

//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            if (!Settings.canDrawOverlays(this)) {
//                Intent intent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
//                        Uri.parse("package:" + getPackageName()));
//                startActivityForResult(intent, OVERLAY_PERMISSION_REQ_CODE);
//            }
//        }

    }

}
