package com.zkty.demo.pedestal;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.zkty.demo.pedestal.dto.MessageEvent;
import com.zkty.demo.pedestal.dto.MicroAppBean;
import com.zkty.modules.loaded.jsapi.RouterMaster;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;

import java.util.ArrayList;
import java.util.List;

import activity.ScanActivity;
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
        if (!TextUtils.isEmpty(et_url.getText())) {
            String url = et_url.getText().toString();
            RouterMaster.openTargetRouter(getActivity(), "h5", url, null, null, null);

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
    public void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK && requestCode == CODE_REQUEST_QRCODE) {
            if (data.hasExtra("result")) {
                String url = data.getStringExtra("result");
                if (!TextUtils.isEmpty(url)) {
                    MicroAppBean bean = new MicroAppBean(url);
                    mList.add(0, bean);
                    mAdapter.notifyDataSetChanged();
                    RouterMaster.openTargetRouter(getActivity(), "h5", url, null, null, null);
                }
            }
        }

    }

    @Subscribe
    public void onMessage(MessageEvent messageEvent) {
        if (messageEvent.type == MessageEvent.ON_MICRO_APP_CLICK) {
            if (messageEvent.position == mList.size() - 1) {
                Intent intent = new Intent(getActivity(), ScanActivity.class);
                startActivityForResult(intent, CODE_REQUEST_QRCODE);
            } else {

                MicroAppBean microAppBean = mList.get(messageEvent.position);
                RouterMaster.openTargetRouter(getActivity(), "h5", microAppBean.url, null, null, null);

            }
        }
    }


}
