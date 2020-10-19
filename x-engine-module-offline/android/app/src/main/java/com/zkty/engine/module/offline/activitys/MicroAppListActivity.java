package com.zkty.engine.module.offline.activitys;

import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;


import com.zkty.engine.module.offline.R;
import com.zkty.engine.module.offline.adapter.MicroAppAdapter;
import com.zkty.modules.engine.manager.MicroAppVersionBean;
import com.zkty.modules.engine.manager.MicroAppsManager;

import java.util.ArrayList;

public class MicroAppListActivity extends AppCompatActivity {
    private static final String TAG = MicroAppListActivity.class.getSimpleName();


    private String app = "com.zkty.microapp.xiaoqu.door";

    private RecyclerView recyclerView;
    private MicroAppAdapter appAdapter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_micro_app_list_layout);

        recyclerView = findViewById(R.id.recyclerView);
        recyclerView.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false));

        appAdapter = new MicroAppAdapter(this);

        recyclerView.setAdapter(appAdapter);

        ArrayList<String> apps = MicroAppsManager.getInstance().listAllMicroApps();
        ArrayList<MicroAppVersionBean> microapps = new ArrayList<>();

        for (int i = 0; i < apps.size(); i++) {
            MicroAppVersionBean bean = new MicroAppVersionBean();
            bean.setMicroAppId(apps.get(i));
            microapps.add(bean);
        }

        appAdapter.addItems(microapps);

    }
}
