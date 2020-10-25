package com.zkty.modules.loaded.jsapi;

import android.content.Intent;
import android.text.TextUtils;
import android.view.View;

import androidx.annotation.Nullable;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.zkty.modules.dsbridge.CompletionHandler;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;
import com.zkty.modules.engine.webview.XOneWebViewPool;


public class __xengine__module_nav extends xengine__module_nav {
    private static final String TAG = __xengine__module_nav.class.getSimpleName();

    @Override
    public void _navigatorRouter(NavOpenAppDTO dto, CompletionHandler<Nullable> handler) {

        RouterMaster.openTargetRouter(XEngineWebActivityManager.sharedInstance().getCurrent(), dto.type, dto.uri, dto.path);
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
                mActivity.getXEngineWebView().callHandler(dto.__event__, new Object[]{new JSONObject().put("success", "success")}, retValue -> {
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
                mActivity.getXEngineWebView().callHandler(dto.__event__, new Object[]{i}, retValue -> {
                });
            });
        });
        handler.complete();


    }

    @Override
    public void _setNavRightMoreBtn(NavMoreBtnDTO dto, CompletionHandler<Nullable> handler) {
        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();

        mActivity.runOnUiThread(() -> {
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
            if (dto == null || dto.url == null) {
                XOneWebViewPool.sharedInstance().peekUnusedWebViewFromPool().backUp();
                mActivity.finish();
            } else if ("0".equals(dto.url)) {
                XEngineWebActivityManager.sharedInstance().exitAllXWebPage();
            } else if ("/index".equals(dto.url)) {
                XEngineWebActivityManager.sharedInstance().backToIndexPage();
            } else {
                String url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId(dto.url, null);
                XOneWebViewPool.sharedInstance().peekUnusedWebViewFromPool().backToPage(url);
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

    @Override
    public void _setHidden(NavHiddenBarDTO dto, CompletionHandler<Nullable> handler) {

        XEngineWebActivity mActivity = XEngineWebActivityManager.sharedInstance().getCurrent();
        mActivity.runOnUiThread(() -> {
            mActivity.getXEngineNavBar().setVisibility(dto.isHidden ? View.GONE : View.VISIBLE);
        });
        handler.complete();

    }
}