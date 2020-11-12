package com.zkty.modules.engine.activity;

import android.app.Instrumentation;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Handler;
import android.os.PersistableBundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.gyf.barlibrary.ImmersionBar;
import com.jude.swipbackhelper.SwipeBackHelper;
import com.jude.swipbackhelper.SwipeListener;
import com.tencent.smtt.sdk.WebBackForwardList;
import com.tencent.smtt.sdk.WebHistoryItem;
import com.zkty.modules.engine.utils.DeviceUtils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.engine.view.XEngineNavBar;
import com.zkty.modules.engine.webview.XEngineWebView;
import com.zkty.modules.engine.webview.XOneWebViewPool;

import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;

import module.engine.R;

public class XEngineWebActivity extends AppCompatActivity {
    private static final String TAG = XEngineWebActivity.class.getSimpleName();

    protected XEngineWebView mWebView;
    private RelativeLayout mRoot;
    protected XEngineNavBar xEngineNavBar;
    private ImageView ivScreen;

    public static final String URL = "x_engine_url";
    public static final String MICRO_APP_ID = "micro_app_id";
    public static final String INDEX_URL = "index_url";
    private String url;
    private String indexUrl;
    private String mMicroAppId;

    //    private ArrayList<LifecycleListener> lifecycleListeners;
    private Set<LifecycleListener> lifecycleListeners;
    private boolean isFirst = true;


    public interface LifecycleListener {

        void onCreate();

        void onStart();

        void onRestart();

        void onResume();

        void onPause();

        void onStop();

        void onDestroy();

        void onActivityResult(int requestCode, int resultCode, @Nullable Intent data);

        void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults);
    }

    public void addLifeCycleListener(LifecycleListener lifeCycleListener) {
        if (lifeCycleListener != null)
            lifecycleListeners.add(lifeCycleListener);
    }

    public boolean removeLifeCycleListener(LifecycleListener lifeCycleListener) {
        if (lifecycleListeners != null && !lifecycleListeners.isEmpty() && lifecycleListeners.contains(lifeCycleListener)) {
            return lifecycleListeners.remove(lifeCycleListener);
        } else {
            return false;
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        SwipeBackHelper.onCreate(this);
        setContentView(R.layout.activity_engine_webview);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(R.color.white)
                .statusBarDarkFont(true).init();

        xEngineNavBar = findViewById(R.id.nav_bar);
        mRoot = findViewById(R.id.content_root);
        ivScreen = findViewById(R.id.iv_screen);
        mMicroAppId = getIntent().getStringExtra(MICRO_APP_ID);
        indexUrl = getIntent().getStringExtra(INDEX_URL);
        mWebView = XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool(mMicroAppId);
        ((RelativeLayout) findViewById(R.id.rl_root)).addView(mWebView, 0);
        XEngineWebActivityManager.sharedInstance().addActivity(this);
        lifecycleListeners = new LinkedHashSet<>();
        if (getIntent().hasExtra(URL)) {
            url = getIntent().getStringExtra(URL);
            mWebView.loadUrl(url);
        }

        url = TextUtils.isEmpty(mWebView.getOriginalUrl()) ? mWebView.getUrl() : mWebView.getOriginalUrl();
        xEngineNavBar.setLeftListener(view -> backUp());
        Log.d(TAG, "onCreate()--" + (lifecycleListeners != null ? lifecycleListeners.size() : 0));
    }


    @Override
    public void onPostCreate(@Nullable Bundle savedInstanceState, @Nullable PersistableBundle persistentState) {
        super.onPostCreate(savedInstanceState, persistentState);
//        SwipeBackHelper.onPostCreate(this);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        Log.d(TAG, "onActivityResult()--" + (lifecycleListeners != null ? lifecycleListeners.size() : 0) + "----requestCode:" + requestCode + "---resultCode:" + resultCode);
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onActivityResult(requestCode, resultCode, data);
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        Log.d(TAG, "onRequestPermissionsResult()--" + (lifecycleListeners != null ? lifecycleListeners.size() : 0));
        if (lifecycleListeners != null) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onRequestPermissionsResult(requestCode, permissions, grantResults);
            }
        }
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        Log.d(TAG, "onRestart()--" + (lifecycleListeners != null ? lifecycleListeners.size() : 0));
        if (lifecycleListeners != null && !lifecycleListeners.isEmpty()) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onRestart();
            }
        }
    }

    @Override
    protected void onResume() {
        Log.d(TAG, "onResume()--" + (lifecycleListeners != null ? lifecycleListeners.size() : 0));
        if (isFirst) {
            isFirst = false;
        } else {
            new Handler().postDelayed(() ->
                            showScreenCapture(false)
                    , 400);
            if (XOneWebViewPool.IS_SINGLE) {
                if (mWebView.getParent() != null) {
                    ((ViewGroup) mWebView.getParent()).removeView(mWebView);
                }
                ((RelativeLayout) findViewById(R.id.rl_root)).addView(mWebView, 0);
            } else {
                XOneWebViewPool.sharedInstance().putWebViewBackToPool(mWebView);
            }
        }

        super.onResume();
        XEngineWebActivityManager.sharedInstance().setCurrent(this);
        if (lifecycleListeners != null && !lifecycleListeners.isEmpty()) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onResume();
            }
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.d(TAG, "onPause()--" + (lifecycleListeners != null ? lifecycleListeners.size() : 0));
        if (lifecycleListeners != null && !lifecycleListeners.isEmpty()) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onPause();
            }
        }
    }


    @Override
    protected void onStop() {
        super.onStop();
        Log.d(TAG, "onStop()--" + (lifecycleListeners != null ? lifecycleListeners.size() : 0));
        if (lifecycleListeners != null && !lifecycleListeners.isEmpty()) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onStop();
            }
        }
    }

    @Override
    protected void onDestroy() {
        Log.d(TAG, "onDestroy()--" + (lifecycleListeners != null ? lifecycleListeners.size() : 0));
        if (lifecycleListeners != null && !lifecycleListeners.isEmpty()) {
            Iterator<LifecycleListener> iterator = lifecycleListeners.iterator();
            while (iterator.hasNext()) {
                iterator.next().onDestroy();
            }
        }
        Log.d(TAG, "lifeCycleListeners size before:" + lifecycleListeners.size());

        if (lifecycleListeners != null) {
            lifecycleListeners.clear();
        }
        Log.d(TAG, "lifeCycleListeners size after:" + lifecycleListeners.size());
        XEngineWebActivityManager.sharedInstance().clearActivity(this);
        super.onDestroy();
//        SwipeBackHelper.onDestroy(this);

    }

    public String getWebUrl() {
        return this.url;
    }

    public String getIndexUrl() {
        return this.indexUrl;
    }

    public String getMicroAppId() {
        return this.mMicroAppId;
    }

    public XEngineNavBar getXEngineNavBar() {
        return this.xEngineNavBar;

    }

    public XEngineWebView getXEngineWebView() {
        return this.mWebView;

    }

    private void backUp() {
        //模拟 KeyEvent.ACTION_DOWN事件,调用onKeyDown
        new Thread(new Runnable() {
            public void run() {
                // 开线程调用方法
                try {
                    Instrumentation inst = new Instrumentation();
                    inst.sendKeyDownUpSync(KeyEvent.KEYCODE_BACK);

                } catch (Exception e) {
                    // 异常catch
                }
            }
        }).start();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            WebBackForwardList backForwardList = mWebView.copyBackForwardList();
            if (backForwardList != null && backForwardList.getSize() != 0) {
                //当前页面在历史队列中的位置
                int currentIndex = backForwardList.getCurrentIndex();
                WebHistoryItem historyItem =
                        backForwardList.getItemAtIndex(currentIndex - 1);//前一个页面
                if (historyItem != null) {
                    String backPageUrl = historyItem.getOriginalUrl();//前一个页面地址
                    XEngineWebActivity last = XEngineWebActivityManager.sharedInstance().getLastActivity();//前一个activity
                    //当前页面前面是原生，webview可以返回，且可返回页不是空白，说明页面内进行了路由，应执行goback;
//                    if (last == null && mWebView.canGoBack() && !"about:blank".equals(backPageUrl)) {//单页面，可返回
//                        mWebView.goBack();
//                        return true;
//                    }
//                    if (last != null && !last.getWebUrl().equals(backPageUrl)) {
//                        mWebView.goBack();
//                        return true;
//                    }

                    if (mWebView.canGoBack()) {

                        if (last == null) {
                            if ("about:blank".equals(backPageUrl)) {
                                finish();
                            } else {
                                mWebView.goBack();
                            }
                        } else {
                            if (last.getWebUrl().equals(backPageUrl)) {
                                finish();
                            }
                            mWebView.goBack();
                        }
                    } else {
                        finish();
                    }
                    return true;
                }
            }
        }
        return super.onKeyDown(keyCode, event);
    }

    public void showScreenCapture(boolean isShow) {
        if (isShow) {
            Bitmap bitmap = captureView(mRoot);
            ivScreen.setImageBitmap(bitmap);
        }
        ivScreen.setVisibility(isShow ? View.VISIBLE : View.GONE);
        url = mWebView.getOriginalUrl();
    }

    private Bitmap captureView(View view) {
        // 根据View的宽高创建一个空的Bitmap
        Bitmap bitmap = Bitmap.createBitmap(
                view.getWidth(),
                view.getHeight(),
                Bitmap.Config.RGB_565);
        // 利用该Bitmap创建一个空的Canvas
        Canvas canvas = new Canvas(bitmap);
        // 绘制背景(可选)
        canvas.drawColor(Color.WHITE);
        // 将view的内容绘制到我们指定的Canvas上
        view.draw(canvas);
        return bitmap;
    }

    @Override
    public void finish() {
        super.finish();
        showScreenCapture(true);
    }

    @Override
    public boolean dispatchTouchEvent(MotionEvent ev) {
        if (ev.getAction() == MotionEvent.ACTION_DOWN) {
            // 判断连续点击事件时间差
            if (DeviceUtils.isFastClick()) {
                return true;
            }
        }
        return super.dispatchTouchEvent(ev);
    }

}