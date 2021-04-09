package com.zkty.modules.nativ.jsi.view;

import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.zkty.modules.nativ.core.XEngineApplication;
import com.zkty.modules.engine.utils.XEngineMessage;
import com.zkty.modules.nativ.jsi.HistoryModel;
import com.zkty.modules.nativ.jsi.webview.XOneWebViewPool;

import org.greenrobot.eventbus.EventBus;

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


    public void startXEngineActivity(Context context, @NonNull String protocol, String host, String pathname, String fragment, boolean hideNavBar) {
        if (context == null) context = XEngineApplication.getApplication();

        Intent intent = new Intent(context, XEngineWebActivity.class);
        if (context instanceof Application) {
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        }
        if (TextUtils.isEmpty(host)) {
            XEngineWebActivity current = XEngineWebActivityManager.sharedInstance().getCurrent();
            if (current != null && current.getHistoryModel() != null) {
                host = current.getHistoryModel().host;
            }

        }


        HistoryModel model = new HistoryModel();
        model.protocol = protocol;
        model.host = host;
        model.pathname = pathname;
        model.fragment = fragment;

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

//        XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool(current.getMicroAppId()).goBackToIndexPage();
    }

    public void backToHistoryPage(String url) {
//        for (int i = activityList.size() - 1; i > 0; i--) {
//            if (UrlUtils.equalsWithoutArgs(activityList.get(i).getWebUrl(), url)) {
//                return;
//            }
//            if (i == activityList.size() - 1) {
//                activityList.get(i).finish();
//            } else {
//                activityList.get(i).finishWhitNoAnim();
//            }
//        }
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