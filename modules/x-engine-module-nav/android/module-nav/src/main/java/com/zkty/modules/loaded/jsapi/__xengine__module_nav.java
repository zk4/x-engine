package com.zkty.modules.loaded.jsapi;

import android.animation.Animator;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.text.TextUtils;
import android.util.Log;
import android.view.View;

import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.dsbridge.OnReturnValue;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.utils.DeviceUtils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.engine.webview.XOneWebViewPool;


public class __xengine__module_nav extends xengine__module_nav {
    private static final String TAG = __xengine__module_nav.class.getSimpleName();

    @Override
    public void _navigatorRouter(NavOpenAppDTO dto, CompletionHandler<Nullable> handler) {

        RouterMaster.openTargetRouter(XEngineWebActivityManager.sharedInstance().getCurrent(), dto.type, dto.uri, dto.path, null, null);
    }

    @Override
    public String moduleId() {
        return super.moduleId();
    }

    @Override
    public void _setNavTitle(NavTitleDTO dto, CompletionHandler<Nullable> handler) {
        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            mActivity.getXEngineNavBar().setTitle(dto.title, dto.titleColor, dto.titleSize);
        });
        handler.complete();
    }

    @Override
    public void _setNavLeftBtn(NavBtnDTO dto, CompletionHandler<Nullable> handler) {

        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            if (TextUtils.isEmpty(dto.__event__)) {
                mActivity.getXEngineNavBar().setNavLeftBtn(dto.title, dto.titleColor, dto.titleSize, dto.icon, dto.iconSize, dto.isBoldFont, null);
            } else {
                mActivity.getXEngineNavBar().setNavLeftBtn(dto.title, dto.titleColor, dto.titleSize, dto.icon, dto.iconSize, dto.isBoldFont, view -> {
                    mActivity.getXEngineWebView().callHandler(dto.__event__, new Object[]{new JSONObject().put("success", "success")}, retValue -> {
                    });
                });
            }
        });

        handler.complete();

    }

    @Override
    public void _setNavRightBtn(NavBtnDTO dto, CompletionHandler<Nullable> handler) {
        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            mActivity.getXEngineNavBar().setNavRightBtn(dto.title, dto.titleColor, dto.titleSize, dto.icon, dto.iconSize, dto.isBoldFont, view -> {
                if (DeviceUtils.isFastClick()) return;
                mActivity.getXEngineWebView().callHandler(dto.__event__, new OnReturnValue<Object>() {
                    @Override
                    public void onValue(Object retValue) {
                        Log.d("DsBridge", "append返回了");
                    }
                });
            });
        });
        handler.complete();

    }

    @Override
    public void _setNavRightMenuBtn(NavBtnDTO dto, CompletionHandler<Nullable> handler) {

        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();

        mActivity.runOnUiThread(() -> {
            mActivity.getXEngineNavBar().setNavRightMenuBtn(dto.title, dto.titleColor, dto.titleSize, dto.icon, dto.iconSize, dto.popList, Boolean.parseBoolean(dto.showMenuImg), dto.popWidth, (adapterView, view, i, l) -> {
                if (DeviceUtils.isFastClick()) return;
                mActivity.getXEngineWebView().callHandler(dto.__event__, new Object[]{String.valueOf(i)}, retValue -> {
                });
            });
        });
        handler.complete();


    }

    @Override
    public void _setNavRightMoreBtn(NavMoreBtnDTO dto, CompletionHandler<Nullable> handler) {
        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();

        mActivity.runOnUiThread(() -> {
            if (DeviceUtils.isFastClick()) return;
            mActivity.getXEngineNavBar().setNavRightMoreBtn(JSON.toJSONString(dto.btns), (adapterView, view, i, l) -> {
                mActivity.getXEngineWebView().callHandler(dto.btns.get(i).__event__, new Object[]{i}, retValue -> {
                });
            });

        });
        handler.complete();

    }

    @Override
    public void _navigatorPush(NavNavigatorDTO dto, CompletionHandler<Nullable> handler) {
        if (TextUtils.isEmpty(dto.url)) {
            handler.complete();
            return;
        }
        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            XEngineWebActivityManager.sharedInstance().navigatorPush(mActivity, dto.url, dto.params);
            handler.complete();
        });

    }

    @Override
    public void _navigatorBack(NavNavigatorDTO dto, CompletionHandler<Nullable> handler) {

        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            if (dto == null || TextUtils.isEmpty(dto.url)) {
                XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool(mActivity.getMicroAppId()).backUp();
                mActivity.finish();
            } else if ("0".equals(dto.url)) {
                XEngineWebActivityManager.sharedInstance().exitAllXWebPage();
            } else if ("/index".equals(dto.url)) {
                XEngineWebActivityManager.sharedInstance().backToIndexPage();
            } else {
                String url = MicroAppLoader.sharedInstance().getFullRouterUrl(dto.url, null);
                XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool(mActivity.getMicroAppId()).backToPage(url);
                XEngineWebActivityManager.sharedInstance().backToHistoryPage(url);
            }
            handler.complete();
        });

    }

    @Override
    public void _setNavSearchBar(NavSearchBarDTO dto, CompletionHandler<Nullable> handler) {

        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            mActivity.getXEngineNavBar().setNavSearchBar(dto.cornerRadius, dto.backgroundColor, dto.iconSearch, dto.iconSearchSize,
                    dto.iconClear, dto.iconClearSize, dto.textColor, dto.fontSize, dto.placeHolder, dto.isInput, dto.becomeFirstResponder, key -> {
                        mActivity.getXEngineWebView().callHandler(dto.__event__, new Object[]{key}, retValue -> {
                        });
                    });
        });
        handler.complete();

    }


    private void startAnim(View view) {
        AnimatorSet animator = new AnimatorSet();//组合动画
        ObjectAnimator translationY = ObjectAnimator.ofFloat(view, "translationY", 0, -1f);//
        animator.setDuration(200);//时间
        animator.play(translationY);//两个动画同时开始
        translationY.addListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {

            }

            @Override
            public void onAnimationEnd(Animator animation) {
                view.setVisibility(View.GONE);
            }

            @Override
            public void onAnimationCancel(Animator animation) {

            }

            @Override
            public void onAnimationRepeat(Animator animation) {

            }
        });
        animator.start();//开始
    }

    @Override
    public void _setSearchBarHidden(NavHiddenBarDTO dto, CompletionHandler<Nullable> handler) {
        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            if (mActivity.getXEngineNavBar().getSearchEditView() != null) {
                if (dto.isAnimation && dto.isHidden) {
                    startAnim(mActivity.getXEngineNavBar().getSearchEditView());
                } else {
                    mActivity.getXEngineNavBar().getSearchEditView().setVisibility(dto.isHidden ? View.GONE : View.VISIBLE);
                }
            }
        });

        handler.complete();
    }

    @Override
    public void _setNavBarHidden(NavHiddenBarDTO dto, CompletionHandler<Nullable> handler) {
        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            if (dto.isAnimation && dto.isHidden) {
                startAnim(mActivity.getXEngineNavBar());
            } else {
                mActivity.getXEngineNavBar().setVisibility(dto.isHidden ? View.GONE : View.VISIBLE);
            }
        });
        handler.complete();
    }
}