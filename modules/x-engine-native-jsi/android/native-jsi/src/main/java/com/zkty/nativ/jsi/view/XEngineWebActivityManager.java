package com.zkty.nativ.jsi.view;

import android.app.Application;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.exception.XEngineException;
import com.zkty.nativ.jsi.webview.XWebViewPool;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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


    public void startXEngineActivity(Context context, @NonNull String protocol, String host, String pathname, String fragment, Map<String, String> query, boolean hideNavBar) {
        if (context == null) context = XEngineApplication.getApplication();

        Intent intent = new Intent(context, XEngineWebActivity.class);
        if (context instanceof Application) {
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        }

        HistoryModel model = new HistoryModel();
        model.protocol = protocol;
        model.host = host;
        model.pathname = pathname;
        model.fragment = fragment;
        model.query = query;

        intent.putExtra(XEngineWebActivity.HIDE_NAV_BAR, hideNavBar);
        intent.putExtra(XEngineWebActivity.HISTORYMODEL, model);

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

        activityList.remove(activity);
        if (activityList.isEmpty()) {
            XWebViewPool.sharedInstance().cleanWebView();
        }
    }

    public void exitAllXWebPage() {
        if (current != null)
            current.showScreenCapture(true);
        XWebViewPool.sharedInstance().cleanWebView();

        for (XEngineWebActivity activity : activityList) {
            activity.finish();
        }
        activityList.clear();
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
    }

    public void backToHistoryPage(int index) {

        if (Math.abs(index) > activityList.size()) {
//            throw new XEngineException("error：返回数大于历史数量！");
            index = activityList.size();
//            return;
        }
        for (int i = activityList.size() - 1; i >= 0; i--) {

            if (i == activityList.size() - 1) {
                activityList.get(i).finish();
            } else if (i >= activityList.size() + index) {
                activityList.get(i).finishWhitNoAnim();
            }

        }

    }

    public void backToHistoryPage(String fragment) {
        int index = -1;

        for (int i = activityList.size() - 1; i >= 0; i--) {
            if (fragment.equals(activityList.get(i).getHistoryModel().fragment)) {
                index = i;
            }
        }
        if (index > -1) {
            for (int i = activityList.size() - 1; i > index; i--) {

                if (i == activityList.size() - 1) {
                    activityList.get(i).finish();
                } else if (i > index) {
                    activityList.get(i).finishWhitNoAnim();
                }
            }
        } else {
            throw new XEngineException("error：没有此历史页面！");
        }
    }


    public List<XEngineWebActivity> getActivityList() {
        return activityList;
    }
}