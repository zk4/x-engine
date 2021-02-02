package com.zkty.modules.engine.fargment;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;


import com.zkty.modules.engine.webview.XEngineWebView;
import com.zkty.modules.engine.webview.XOneWebViewPool;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;

import module.engine.R;

public class XEngineFragment extends Fragment {
    private static final String ARG_PARAM_URL = "arg_param_url";

    private XEngineWebView mWebView;
    private RelativeLayout mRoot;
    private String mUrl;


    private XEngineFragment() {
    }

    public static XEngineFragment newInstance(String uri) {
        XEngineFragment fragment = new XEngineFragment();
        Bundle args = new Bundle();
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
            mWebView = new XEngineWebView(getActivity());
            mWebView.setVerticalScrollBarEnabled(false);
            ViewGroup parent = (ViewGroup) mWebView.getParent();
            if (parent != null) {
                parent.removeAllViews();
            }
            mRoot.addView(mWebView, 0);
            mWebView.loadUrl(mUrl);
        }

    }

    public XEngineWebView getWebView() {
        return mWebView;
    }

}