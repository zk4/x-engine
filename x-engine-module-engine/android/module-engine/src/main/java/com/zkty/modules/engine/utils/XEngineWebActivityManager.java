package com.zkty.modules.engine.utils;

import android.content.Context;
import android.content.Intent;
import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.webview.XOneWebViewPool;

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

    public void startXEngineActivity(Context context, @NonNull String url) {
        if (!url.startsWith("http")) {
            url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId(url);
        }
        XOneWebViewPool.sharedInstance().peekUnusedWebViewFromPool().preLoad(url);
        context.startActivity(new Intent(context, XEngineWebActivity.class));

    }

    public void startXEngineActivity(Context context, @NonNull String url, @NonNull String path) {
        if (!url.startsWith("http")) {
            url = MicroAppLoader.sharedInstance().getMicroAppByMicroAppId(url);
        }
        url = TextUtils.isEmpty(path) ? url : url + "?" + path;
        XOneWebViewPool.sharedInstance().peekUnusedWebViewFromPool().preLoad(url);
        context.startActivity(new Intent(context, XEngineWebActivity.class));

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
        activityList.remove(activity);
        if (activityList.isEmpty()) {
            XOneWebViewPool.sharedInstance().peekUnusedWebViewFromPool().cleanCache();
        }
    }

    public void exitAllXWebPage() {
        XEngineWebActivity current = XEngineWebActivityManager.sharedInstance().getCurrent();
        current.showScreenCapture(true);
        for (XEngineWebActivity activity : activityList) {
            activity.finish();
        }
        XOneWebViewPool.sharedInstance().peekUnusedWebViewFromPool().cleanCache();
    }

    public void backToIndexPage() {
        XEngineWebActivity activity = XEngineWebActivityManager.sharedInstance().getCurrent();
        activity.showScreenCapture(true);
        for (int i = 0; i < activityList.size(); i++) {
            if (i != 0) {
                activityList.get(i).finish();
            }
        }
        XOneWebViewPool.sharedInstance().peekUnusedWebViewFromPool().goBackToIndexPage();
    }

    public void backToHistoryPage(String url) {
        for (int i = activityList.size() - 1; i > 0; i--) {
            if (activityList.get(i).getWebUrl().contains(url)) {
                return;
            }
            activityList.get(i).finish();
        }
    }

    public XEngineWebActivity getLastActivity() {
        if (activityList.size() < 2) {
            return null;
        }
        return activityList.get(activityList.size() - 2);
    }

}