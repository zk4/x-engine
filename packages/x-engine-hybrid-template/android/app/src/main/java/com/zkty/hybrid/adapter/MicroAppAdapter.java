package com.zkty.hybrid.adapter;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.zkty.hybrid.R;
import com.zkty.modules.engine.activity.XEngineWebActivity;
import com.zkty.modules.engine.manager.MicroAppVersionBean;
import com.zkty.modules.engine.manager.MicroAppsManager;

import java.io.File;
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
                Intent intent = new Intent(mContext, XEngineWebActivity.class);
                Uri uri = Uri.fromFile(new File(MicroAppsManager.getInstance().getMicroAppPath(datas.get(position).getMicroAppId()), "index.html"));
                intent.putExtra(XEngineWebActivity.URL, uri.toString());
                mContext.startActivity(intent);
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
