package com.zkty.nativ.jsi.view;


import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.sensorsdata.analytics.android.sdk.SensorsDataAPI;
import com.zkty.nativ.jsi.HistoryModel;
import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.jsi.webview.XWebViewPool;

import nativ.jsi.R;


public class XEngineFragment extends Fragment {
    private String TAG = XEngineFragment.class.getSimpleName();
    private static final String ARG_PARAM_HISTORY_MODEL = "arg_param_history_model";
    private static final String ARG_PARAM_INDEX = "arg_param_index";

    private XEngineWebView mWebView;
    private RelativeLayout mRoot;

    private XEngineFragment() {
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

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        mRoot = view.findViewById(R.id.rl_root);
        if (getArguments() != null) {
            HistoryModel historyModel = (HistoryModel) getArguments().getSerializable(ARG_PARAM_HISTORY_MODEL);
            int index = getArguments().getInt(ARG_PARAM_INDEX);
            mWebView = XWebViewPool.sharedInstance().getTabWebViewByIndex(index);
            SensorsDataAPI.sharedInstance().showUpX5WebView(mWebView,true);
            XWebViewPool.sharedInstance().setCurrentTabWebView(mWebView);
            mRoot.addView(mWebView, 0);
//            PermissionDto dto = MicroAppPermissionManager.sharedInstance().getPermission(mMicroAppId, "0");
//            mWebView.setPermission(dto);
            mWebView.loadUrl(historyModel);
        }

    }

    public XEngineWebView getWebView() {
        return mWebView;
    }

    @Override
    public void onHiddenChanged(boolean hidden) {
        super.onHiddenChanged(hidden);
        if (!hidden){
            XWebViewPool.sharedInstance().setCurrentTabWebView(mWebView);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    public void broadcast(String msg) {
        Log.d(TAG, "发送全局广播：" + msg);
        if (mWebView != null)
            mWebView.callHandler("com.zkty.module.engine.broadcast", new Object[]{msg}, retValue -> Log.d(TAG, "broadcast:" + msg));
    }


}