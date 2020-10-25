package com.zkty.engine.module.offline.adapter;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.zkty.engine.module.offline.R;
import com.zkty.engine.module.offline.activitys.CommonWebActivity;
import com.zkty.modules.engine.manager.MicroAppVersionBean;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import java.util.ArrayList;

public class MicroAppAdapter extends RecyclerView.Adapter<MicroAppAdapter.VHolder> {
    private static final String TAG = MicroAppAdapter.class.getSimpleName();


    private Context mContext;
    private ArrayList<MicroAppVersionBean> datas;


    public MicroAppAdapter(Context ctx) {
        mContext = ctx;
        datas = new ArrayList<>();
    }


    public void addItems(ArrayList<MicroAppVersionBean> items) {
        datas.addAll(items);
        notifyDataSetChanged();
    }

    public void addItem(MicroAppVersionBean item) {
        datas.add(item);
        notifyDataSetChanged();
    }


    @NonNull
    @Override
    public VHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return new VHolder(LayoutInflater.from(mContext).inflate(R.layout.item_microapp_layout, null));
    }

    @Override
    public void onBindViewHolder(@NonNull VHolder holder, final int position) {
        holder.item.setText(datas.get(position).getMicroAppId());
        holder.item.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                XEngineWebActivityManager.sharedInstance().startXEngineActivity(mContext, datas.get(position).getMicroAppId());
            }
        });
    }

    @Override
    public int getItemCount() {
        return datas.size();
    }


    public static class VHolder extends RecyclerView.ViewHolder {

        public TextView item;

        public VHolder(@NonNull View itemView) {
            super(itemView);
            item = itemView.findViewById(R.id.item);
        }
    }
}
