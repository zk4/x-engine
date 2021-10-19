package com.zkty.nativ.jsi.view;


import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.fragment.app.Fragment;

import com.gome.analysis.AnalysisManager;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.jsi.webview.XWebViewPool;

import java.util.HashMap;
import java.util.Map;

import nativ.jsi.R;


public class XEngineFragment extends Fragment {
    private String TAG = XEngineFragment.class.getSimpleName();
    private static final String ARG_PARAM_HISTORY_MODEL = "arg_param_history_model";
    private static final String ARG_PARAM_INDEX = "arg_param_index";

    private static final String ON_NATIVE_SHOW = "onNativeShow";
    private static final String ON_NATIVE_HIDE = "onNativeHide";
    private static final String ON_NATIVE_DESTROYED = "onNativeDestroyed";
    private static final String ON_WEBVIEW_SHOW = "onWebviewShow";

    private XEngineWebView mWebView;
    private RelativeLayout mRoot;

    public XEngineFragment() {
    }

    public static XEngineFragment newInstance(int index, HistoryModel historyModel) {
        XEngineFragment fragment = new XEngineFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_PARAM_INDEX, index);
        args.putSerializable(ARG_PARAM_HISTORY_MODEL, historyModel);
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_x_engine, container, false);
        return view;
    }

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mRoot = view.findViewById(R.id.rl_root);
        if (getArguments() != null) {
            HistoryModel historyModel = (HistoryModel) getArguments().getSerializable(ARG_PARAM_HISTORY_MODEL);
            int index = getArguments().getInt(ARG_PARAM_INDEX);
            mWebView = XWebViewPool.sharedInstance().getTabWebViewByIndex(index);
            AnalysisManager.getInstance().initX5WebView(mWebView);
            XWebViewPool.sharedInstance().setCurrentTabWebView(mWebView);
            if (historyModel.protocol == null && historyModel.host == null && historyModel.pathname == null) {
                View view1 = getLayoutInflater().inflate(R.layout.layout_notfound_page, null);
                mRoot.addView(view1, 0);
                RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);
                view1.setLayoutParams(lp);

            } else {
                mRoot.addView(mWebView, 0);
//            PermissionDto dto = MicroAppPermissionManager.sharedInstance().getPermission(mMicroAppId, "0");
//            mWebView.setPermission(dto);
                mWebView.loadUrl(historyModel);
            }
            mWebView.setOnPageStateListener(() -> broadcast(ON_WEBVIEW_SHOW, ON_WEBVIEW_SHOW));
        }

    }

    public XEngineWebView getWebView() {
        return mWebView;
    }

    @Override
    public void onHiddenChanged(boolean hidden) {
        super.onHiddenChanged(hidden);
        if (!hidden) {
            XWebViewPool.sharedInstance().setCurrentTabWebView(mWebView);
            broadcast(ON_NATIVE_SHOW, ON_NATIVE_SHOW);
        } else {
            broadcast(ON_NATIVE_HIDE, ON_NATIVE_HIDE);
        }
    }

    @Override
    public void onDestroy() {
        broadcast(ON_NATIVE_DESTROYED, ON_NATIVE_DESTROYED);
        super.onDestroy();
    }

    private void broadcast(String type, String payload) {
//        Log.d("DWebView-Log", "broadcast：type=" + type + " ,payload = " + payload + "__" + mWebView.hashCode());
        Map<String, String> bro = new HashMap<>();
        bro.put("type", type);
        bro.put("payload", payload);
        mWebView.callHandler("com.zkty.jsi.engine.lifecycle.notify", new Object[]{bro}, retValue -> Log.d("NativeBroadcast", "broadcast:" + payload));

    }


}