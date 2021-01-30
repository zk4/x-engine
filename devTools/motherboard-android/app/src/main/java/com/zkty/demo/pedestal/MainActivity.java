package com.zkty.demo.pedestal;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.loaded.jsapi.RouterMaster;

import activity.ScanActivity;

public class MainActivity extends AppCompatActivity implements MyTabWidget.OnTabSelectedListener {


    private TextView tv_title;
    private MyTabWidget mTabWidget;


    private FragmentManager mFragmentManager;
    private Fragment mContentFragment;
    private int mIndex = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(module.engine.R.color.white)
                .statusBarDarkFont(true).init();
        initView();


    }


    private void initView() {
//
        tv_title = findViewById(R.id.tv_title);
        mTabWidget = findViewById(R.id.tab_widget);

        getMyTabWidgetHeight();
        mTabWidget.removeAllViews();
        mTabWidget.init(this);
        mTabWidget.setOnTabSelectedListener(this);

        mFragmentManager = getSupportFragmentManager();
        FragmentTransaction transaction = mFragmentManager.beginTransaction();
        mContentFragment = HomeTabManager.getInstance().getFragmentByIndex(ConstantValues.HOME_INDEX);
        mTabWidget.removeAllViews();
        mTabWidget.init(this);
        transaction.add(R.id.fl_home_content, mContentFragment);
        transaction.commitAllowingStateLoss();
        setTabsDisplay(mIndex);
    }

    private void getMyTabWidgetHeight() {
        int w = View.MeasureSpec.makeMeasureSpec(0,
                View.MeasureSpec.UNSPECIFIED);
        int h = View.MeasureSpec.makeMeasureSpec(0,
                View.MeasureSpec.UNSPECIFIED);
        mTabWidget.measure(w, h);
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }

    public void setTabsDisplay(int index) {
        mTabWidget.setTabsDisplay(this, index, 0);
    }

    String[] titles = new String[]{"微应用", "模块", "日志"};

    @Override
    public void onTabSelected(int index) {
        mIndex = index;
        switchFragment(HomeTabManager.getInstance().getFragmentByIndex(mIndex), mIndex);
        setTabsDisplay(mIndex);
        tv_title.setText(titles[index]);

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
}