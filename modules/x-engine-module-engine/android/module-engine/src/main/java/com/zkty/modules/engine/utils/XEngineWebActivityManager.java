package com.zkty.modules.engine.utils;

import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;

import com.zkty.modules.engine.XEngineApplication;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.webview.XOneWebViewPool;

import org.greenrobot.eventbus.EventBus;

import java.time.temporal.TemporalAccessor;
import java.util.ArrayList;
import java.util.List;

public class XEngineWebActivityManager {
    private static List<XEngineWebActivity> activityList;

    private XEngineWebActivity current;

    private XEngineWebActivityManager() {
        activityList = new ArrayList<>();
    }

    private static volatile XEngineWebActivityManager instance = null;

    public static XEngineWebActivityManager sharedInstance() {
        if (instance == null) {
            synchronized (XEngineWebActivityManager.class) {
                if (instance == null) {
                    instance = new XEngineWebActivityManager();
                }
            }
        }
        return instance;
    }

    /**
     * @param context
     * @param url     appid 或url
     */
    public void startH5EngineActivity(Context context, @NonNull String url, boolean hideNavBar) {
        if (context == null) {
            context = XEngineApplication.getApplication();
        }

        XOneWebViewPool.IS_WEB = true;
//        XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool().preLoad(url);
        Intent intent = new Intent(context, XEngineWebActivity.class);
        if (context instanceof Application) {
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        }
        intent.putExtra(XEngineWebActivity.URL, url);
        intent.putExtra(XEngineWebActivity.HIDE_NAV_BAR, hideNavBar);
        context.startActivity(intent);

    }

    public void startMicroEngineActivity(Context context, @NonNull String microAppId, String path, String args, String version, boolean hideNavBar) {
        if (context == null) {
            context = XEngineApplication.getApplication();
        }


        String indexUrl = null;
        if (TextUtils.isEmpty(version)) {
            indexUrl = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId(microAppId);
        } else {
            indexUrl = MicroAppLoader.sharedInstance().getMicroAppByMicroAppIdAndVersion(microAppId, version);
        }
        Intent intent = new Intent(context, XEngineWebActivity.class);
        if (context instanceof Application) {
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        }
        intent.putExtra(XEngineWebActivity.INDEX_URL, indexUrl);
        intent.putExtra(XEngineWebActivity.MICRO_APP_ID, microAppId);
        intent.putExtra(XEngineWebActivity.HIDE_NAV_BAR, hideNavBar);

        String url = null;
        if (TextUtils.isEmpty(path) || "null".equals(path)) {
            url = indexUrl;
        } else if (path.startsWith("/index")) {
            url = indexUrl + path.replaceFirst("/index", "");
        } else {
            url = indexUrl + "#" + path;
        }
        url = TextUtils.isEmpty(args) || "null".equals(args) ? url : url + "?" + args;

        String router = UrlUtils.getRouterFormPath(path);
        if (!TextUtils.isEmpty(router)) {
            intent.putExtra(XEngineWebActivity.ROUTER, router);
        }


        intent.putExtra(XEngineWebActivity.URL, url);
        context.startActivity(intent);

    }

    //应用内路由
    public void navigatorPush(Context context, @NonNull String router, @NonNull String params, boolean hideNavBar) {

        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        if (activity == null) {
            return;
        }
        activity.showScreenCapture(true);
        String url = MicroAppLoader.sharedInstance().getFullRouterUrl(router, params);
        if (url != null && url.startsWith("/data")) {
            url = "file://" + url;
        }
//        XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool().preLoad(url);
        Intent intent = new Intent(context, XEngineWebActivity.class);
        intent.putExtra(XEngineWebActivity.URL, url);
        intent.putExtra(XEngineWebActivity.INDEX_URL, activity.getIndexUrl());
        intent.putExtra(XEngineWebActivity.MICRO_APP_ID, activity.getMicroAppId());
        intent.putExtra(XEngineWebActivity.HIDE_NAV_BAR, hideNavBar);

        String router1 = UrlUtils.getRouterFormPath(router);
        if (!TextUtils.isEmpty(router)) {
            intent.putExtra(XEngineWebActivity.ROUTER, router1);
        }
        context.startActivity(intent);

    }

    public void addActivity(XEngineWebActivity activity) {
        activityList.add(activity);
        current = activity;
    }

    public void setCurrent(XEngineWebActivity current) {
        this.current = current;
    }

    public XEngineWebActivity getCurrent() {
        return current;
    }

    public void clearActivity(XEngineWebActivity activity) {

        if (activity.getXEngineWebView().getHistoryCount() == 0) {
            activity.getXEngineWebView().cleanCache();
            XOneWebViewPool.sharedInstance().removeWebView(activity.getXEngineWebView());
        }

        activityList.remove(activity);
        if (activityList.isEmpty()) {
            XOneWebViewPool.sharedInstance().cleanWebView();
        }
    }

    public void exitAllXWebPage() {
        XEngineWebActivity current = XEngineWebActivityManager.sharedInstance().getCurrent();
        current.showScreenCapture(true);
        XOneWebViewPool.sharedInstance().cleanWebView();

        for (XEngineWebActivity activity : activityList) {
            activity.finish();
        }
    }

    public void backToIndexPage() {
        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        activity.showScreenCapture(true);
        for (int i = 0; i < activityList.size(); i++) {
            if (i != 0) {
                if (i == activityList.size() - 1) {
                    activityList.get(i).finish();
                } else {
                    activityList.get(i).finishWhitNoAnim();
                }
            }
        }
        XEngineWebActivity current = XEngineWebActivityManager.sharedInstance().getCurrent();

        XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool(current.getMicroAppId()).goBackToIndexPage();
    }

    public void backToHistoryPage(String url) {
        for (int i = activityList.size() - 1; i > 0; i--) {
            if (UrlUtils.equalsWithoutArgs(activityList.get(i).getWebUrl(), url)) {
                return;
            }
            if (i == activityList.size() - 1) {
                activityList.get(i).finish();
            } else {
                activityList.get(i).finishWhitNoAnim();
            }
        }
    }

    public XEngineWebActivity getLastActivity() {
        if (activityList.size() < 2) {
            return null;
        }
        return activityList.get(activityList.size() - 2);
    }


    public void removeHistoryPage(List<String> histories) {
        //通知activity finish
        for (String history : histories) {
            EventBus.getDefault().post(new XEngineMessage(XEngineMessage.MSG_TYPE_PAGE_CLOSE, history));
        }
    }

    public List<XEngineWebActivity> getActivityList() {
        return activityList;
    }
}