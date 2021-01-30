package com.zkty.engine.module.xxxx.view.activity;


import android.Manifest;
import android.app.Activity;

import android.content.Intent;

import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageView;


import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.engine.module.xxxx.BuildConfig;
import com.zkty.engine.module.xxxx.ConstantValues;
import com.zkty.engine.module.xxxx.R;
import com.zkty.engine.module.xxxx.dto.MessageEvent;
import com.zkty.engine.module.xxxx.dto.MessageType;
import com.zkty.engine.module.xxxx.view.base.BaseActivity;
import com.zkty.engine.module.xxxx.view.fragment.HomeTabManager;
import com.zkty.engine.module.xxxx.view.widgets.MyTabView;
import com.zkty.modules.engine.utils.PermissionsUtils;
import com.zkty.modules.engine.utils.ToastUtils;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;

import butterknife.BindView;

public class HomeActivity extends BaseActivity implements MyTabView.OnTabSelectedListener {

    @BindView(R.id.tab_widget)
    MyTabView mTabWidget;

    private ImageView mCenterBtn;


    private FragmentManager mFragmentManager;
    private Fragment mContentFragment;
    private int mIndex = 0;
    private static int CODE_REQUEST_QRCODE = 0x121;
    private static final int REQUEST_PERMISSION_CODE = 100;     //权限申请
    private static final int REQUEST_OP_BLUETOOTH = 102;

    private long firstTime = 0;


    private PermissionsUtils permissionsUtils = new PermissionsUtils();
    private String[] permissions = new String[]{
            Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE,
            Manifest.permission.READ_EXTERNAL_STORAGE};


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EventBus.getDefault().post(new MessageEvent(MessageType.TYPE_START_HOME_ACTIVITY, null));
        initTab();
        initView();
        checkPermissions();

    }

    private void checkPermissions() {
        permissionsUtils.checkPermissions(this, permissions, new PermissionsUtils.IPermissionsResult() {
            @Override
            public void passPermissions() {


            }

            @Override
            public void forbidPermissions() {

            }
        });

    }


    private void initTab() {
        getMyTabWidgetHeight();
        mTabWidget.removeAllViews();
        mTabWidget.init(this);
        mTabWidget.setOnTabSelectedListener(this);
    }

    private void initView() {
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(R.color.white)
                .statusBarDarkFont(true).init();

        mFragmentManager = getSupportFragmentManager();
        FragmentTransaction transaction = mFragmentManager.beginTransaction();
        mContentFragment = HomeTabManager.getInstance().getFragmentByIndex(ConstantValues.HOME_INDEX);
        mTabWidget.removeAllViews();
        mTabWidget.init(this);
        transaction.add(R.id.fl_home_content, mContentFragment);
        transaction.commitAllowingStateLoss();
        setTabsDisplay(mIndex);
        mCenterBtn = mTabWidget.getCenterBtn();
        initCenterBtnListener();

    }


    private void getMyTabWidgetHeight() {
        int w = View.MeasureSpec.makeMeasureSpec(0,
                View.MeasureSpec.UNSPECIFIED);
        int h = View.MeasureSpec.makeMeasureSpec(0,
                View.MeasureSpec.UNSPECIFIED);
        mTabWidget.measure(w, h);
    }

    public void setTabsDisplay(int index) {
        mTabWidget.setTabsDisplay(this, index, 0);

    }

    private void switchFragment(Fragment to, int index) {
        if (mContentFragment != to) {
            FragmentTransaction transaction = mFragmentManager.beginTransaction().setCustomAnimations(
                    R.anim.home_fade_in, R.anim.home_fade_out);
            if (!to.isAdded()) {    // 先判断是否被add过
                transaction.hide(mContentFragment).add(R.id.fl_home_content, to, index + "").commitAllowingStateLoss(); // 隐藏当前的fragment，add下一个到Activity中
            } else {
                transaction.hide(mContentFragment).show(to).commitAllowingStateLoss(); // 隐藏当前的fragment，显示下一个
            }
            mContentFragment = to;
        }
    }

    @Override
    public void onTabSelected(int index) {
        mIndex = index;
        switchFragment(HomeTabManager.getInstance().getFragmentByIndex(mIndex), mIndex);
        setTabsDisplay(mIndex);


    }

    @Override
    protected int getLayoutId() {
        return R.layout.activity_home;
    }

    @Override
    protected void onResume() {
        super.onResume();
//        Log.d("HomeActivity", BuildConfig.JSON);
    }


    @Subscribe
    public void onMessage(MessageEvent messageEvent) {
//        switch (messageEvent.getType()) {
//            case MessageType.TYPE_START_LOGIN_ACTIVITY:
//                finish();
//                break;
//
//        }

    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK && event.getAction() == KeyEvent.ACTION_DOWN) {
//            if (updateDialog.isShowing() && updateBean.getForceUpdate() == 0) {
//                return super.onKeyDown(keyCode, event);
//            } else
            if (System.currentTimeMillis() - firstTime > 2000) {
                ToastUtils.showToast(HomeActivity.this, "再按一次退出程序");
                firstTime = System.currentTimeMillis();
            } else {
                finish();
                // System.exit(0);
            }
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == CODE_REQUEST_QRCODE) {
            if (data.hasExtra("result")) {
                String url = data.getStringExtra("result");
                if (!TextUtils.isEmpty(url)) {
                    if (url.startsWith("http")) {
//                        RouterWrapper.getInstance().openTargetRouter(HomeActivity.this, "h5", url, null, null, null, false);
                    } else if (url.startsWith("msg://")) {

                    }
                }
            }
        }
    }


    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        permissionsUtils.onRequestPermissionsResult(this, requestCode, permissions, grantResults);

    }

    private void initCenterBtnListener() {
        mCenterBtn.setOnClickListener(v -> ToastUtils.showNormalShortToast("单击"));

    }

}

