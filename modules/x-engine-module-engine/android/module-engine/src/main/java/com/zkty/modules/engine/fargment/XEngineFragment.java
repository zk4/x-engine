package com.zkty.modules.engine.fargment;

import android.os.Bundle;
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
    private static final String ARG_PARAM0 = "arg_param0";
    private static final String ARG_PARAM1 = "arg_param1";
    private static final String ARG_PARAM2 = "arg_param2";
    private XEngineWebView mWebView;
    private RelativeLayout mRoot;
    private String mType;
    private String mUrl;
    private int mIndex;


    private XEngineFragment() {
    }

    public static XEngineFragment newInstance(int index, String type, String uri) {
        XEngineFragment fragment = new XEngineFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_PARAM0, index);
        args.putString(ARG_PARAM1, type);
        args.putString(ARG_PARAM2, uri);
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
            mIndex = getArguments().getInt(ARG_PARAM0);
            mType = getArguments().getString(ARG_PARAM1);
            mUrl = getArguments().getString(ARG_PARAM2);
            mWebView = XOneWebViewPool.sharedInstance().getUnusedWebViewFromPool("XEngineFragment_" + mIndex);
            ViewGroup parent = (ViewGroup) mWebView.getParent();
            if (parent != null) {
                parent.removeAllViews();
            }
            mRoot.addView(mWebView, 0);

            mWebView.loadUrl(mUrl);
        }


    }


    @Override
    public void onDestroy() {
        super.onDestroy();

    }
}