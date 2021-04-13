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

import com.zkty.nativ.jsi.webview.XEngineWebView;
import com.zkty.nativ.jsi.webview.XWebViewPool;

import nativ.jsi.R;


public class XEngineFragment extends Fragment {
    private String TAG = XEngineFragment.class.getSimpleName();
    private static final String ARG_PARAM_URL = "arg_param_url";
    private static final String ARG_PARAM_INDEX = "arg_param_index";

    private XEngineWebView mWebView;
    private RelativeLayout mRoot;
    private String mUrl;
    private XEngineFragment() {
    }

    public static XEngineFragment newInstance(int index, String uri) {
        XEngineFragment fragment = new XEngineFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_PARAM_INDEX, index);
        args.putString(ARG_PARAM_URL, uri);
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
            mUrl = getArguments().getString(ARG_PARAM_URL);
            int index = getArguments().getInt(ARG_PARAM_INDEX);
            mWebView = XWebViewPool.sharedInstance().getTabWebViewByIndex(index);
            mRoot.addView(mWebView, 0);
//            PermissionDto dto = MicroAppPermissionManager.sharedInstance().getPermission(mMicroAppId, "0");
//            mWebView.setPermission(dto);
            mWebView.loadUrl(mUrl);
        }

    }

    public XEngineWebView getWebView() {
        return mWebView;
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