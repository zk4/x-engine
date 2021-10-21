package com.zkty.demo.pedestal;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;


import butterknife.ButterKnife;
import butterknife.OnClick;

public class PageTowFragment extends Fragment {

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_2, container, false);
        ButterKnife.bind(this, view);

        return view;
    }


    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);


    }

    @OnClick({R.id.btn_1, R.id.btn_2, R.id.btn_3, R.id.btn_4, R.id.btn_5, R.id.btn_6, R.id.btn_7,R.id.btn_8})
    void onClick(View view) {
        String microAppId = null;
        String url = null;
        switch (view.getId()) {
            case R.id.btn_1:
                url = "http://my-bucket-1257400556.cos-website.ap-guangzhou.myqcloud.com/docs/modules/all/dist/nav/index.html";
                break;
            case R.id.btn_2:
                microAppId = "com.zkty.module.navpush";
                break;
            case R.id.btn_3:
                microAppId = "com.zkty.module.localstorage";
                break;
            case R.id.btn_4:
                url = "http://my-bucket-1257400556.cos-website.ap-guangzhou.myqcloud.com/docs/modules/all/dist/camera/index.html";
                break;
            case R.id.btn_5:
                microAppId = "com.zkty.module.bluetooth";
                break;
            case R.id.btn_6:
                url = "http://my-bucket-1257400556.cos-website.ap-guangzhou.myqcloud.com/docs/modules/all/dist/scan/index.html";
                break;
            case R.id.btn_7:
                url = "http://my-bucket-1257400556.cos-website.ap-guangzhou.myqcloud.com/docs/modules/all/dist/dcloud/index.html";
                break;
            case R.id.btn_8:
                url = "http://my-bucket-1257400556.cos-website.ap-guangzhou.myqcloud.com/docs/modules/all/dist/network/index.html";
                break;

        }
        if (microAppId != null) {
//            RouterMaster.openTargetRouter(getActivity(), "microapp", microAppId, null, null, null,false);

        } else if (url != null) {
//            RouterMaster.openTargetRouter(getActivity(), "h5", url, null, null, null,false);

        }

    }


}
