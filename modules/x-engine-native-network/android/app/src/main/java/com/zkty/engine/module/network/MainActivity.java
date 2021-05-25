package com.zkty.engine.module.network;

import android.os.Build;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;

import com.zkty.engine.module.network.net.CommonEngine;
import com.zkty.engine.module.network.net.callback.ServiceCallback;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.network.net.exception.ApiException;


public class MainActivity extends AppCompatActivity {

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void network(View view) {
        CommonEngine.getInstance().getScheduleListById( new ServiceCallback() {
            @Override
            public void onSuccess(Object jsonObj) {
                ToastUtils.showCenterToast("哈哈哈哈哈哈");
            }

            @Override
            public void onError(ApiException apiException) {

            }

            @Override
            public void onInvalid() {

            }
        });
    }
}
