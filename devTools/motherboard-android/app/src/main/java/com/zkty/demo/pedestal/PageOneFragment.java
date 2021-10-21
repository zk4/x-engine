package com.zkty.demo.pedestal;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.huawei.hms.ml.scan.HmsScan;
import com.zkty.demo.pedestal.dto.MessageEvent;
import com.zkty.demo.pedestal.dto.MicroAppBean;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class PageOneFragment extends Fragment {
    public static final int CODE_REQUEST_QRCODE = 0x10;
    @BindView(R.id.recycle_view)
    public RecyclerView mRecyclerView;
    @BindView(R.id.et_url)
    public EditText et_url;

    private HomeAppListAdapter mAdapter;

    private List<MicroAppBean> mList;


    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_1, container, false);
        ButterKnife.bind(this, view);
        EventBus.getDefault().register(this);
        return view;
    }


    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initView();
    }

    @OnClick(R.id.btn_load)
    void load() {
        try {
            if (!TextUtils.isEmpty(et_url.getText())) {
                startRoter(et_url.getText().toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void initView() {
        mList = new ArrayList<>();
        mList.add(new MicroAppBean("扫一扫"));

        mAdapter = new HomeAppListAdapter(getActivity(), mList);
        mRecyclerView.setHasFixedSize(true);
        mRecyclerView.setLayoutManager(new GridLayoutManager(getContext(),
                HomeAppListAdapter.SPAN_COUNT, LinearLayoutManager.VERTICAL, false));
        mRecyclerView.setAdapter(mAdapter);

    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        EventBus.getDefault().unregister(this);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent intent) {
        if (resultCode == Activity.RESULT_OK && requestCode == CODE_REQUEST_QRCODE) {
            HmsScan obj = intent.getParcelableExtra(DefinedActivity.SCAN_RESULT);
            if (obj != null) {
                String url = obj.getOriginalValue();
                MicroAppBean bean = new MicroAppBean(url);
                mList.add(0, bean);
                mAdapter.notifyDataSetChanged();
                startRoter(url);
            }
        }
    }
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] strings, @NonNull int[] ints) {
        if (requestCode == CODE_PERMISSION_CAMERA) {
            if (getActivity().checkCallingOrSelfPermission(permissions[0]) == PackageManager.PERMISSION_GRANTED) {
                Intent intent = new Intent(getActivity(), DefinedActivity.class);
                startActivityForResult(intent, CODE_REQUEST_QRCODE);
            } else {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    getActivity().requestPermissions(permissions, CODE_PERMISSION_CAMERA);
                }
            }
        }
    }

    private String[] permissions = {Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE};
    private int CODE_PERMISSION_CAMERA = 1;
    @Subscribe
    public void onMessage(MessageEvent messageEvent) {
        if (messageEvent.type == MessageEvent.ON_MICRO_APP_CLICK) {
            if (messageEvent.position == mList.size() - 1) {
                if (getActivity().checkCallingOrSelfPermission(permissions[0]) == PackageManager.PERMISSION_GRANTED) {
                    Intent intent = new Intent(getActivity(), DefinedActivity.class);
                    startActivityForResult(intent, CODE_REQUEST_QRCODE);
                } else {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        getActivity().requestPermissions(permissions, CODE_PERMISSION_CAMERA);
                    }
                }


//                NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IScan.class);
//                if (module instanceof NativeScan)
//                    iScan = (NativeScan) module;
//                if(iScan != null)
//                    iScan.openScanView(new CallBack() {
//                        @Override
//                        public void succes(String code) {
//                            MicroAppBean bean = new MicroAppBean(code);
//                            mList.add(0, bean);
//                            mAdapter.notifyDataSetChanged();
//                            startRoter(code);
//                        }
//                    });
            } else {
                MicroAppBean microAppBean = mList.get(messageEvent.position);
                startRoter(microAppBean.url);
            }
        }
    }


    private void startRoter(String url){
        try {
            if (!TextUtils.isEmpty(url)) {
                Intent intent =new Intent(getContext(), WebActivity.class);
                intent.putExtra("url",url);
                startActivity(intent);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
