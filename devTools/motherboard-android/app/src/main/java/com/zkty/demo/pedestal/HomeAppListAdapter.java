package com.zkty.demo.pedestal;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.zkty.demo.pedestal.dto.MessageEvent;
import com.zkty.demo.pedestal.dto.MicroAppBean;

import org.greenrobot.eventbus.EventBus;

import java.util.List;


public class HomeAppListAdapter extends RecyclerView.Adapter<HomeAppListAdapter.GridViewHolder> {
    public static final int SPAN_COUNT = 3;

    private Context mContext;
    private List<MicroAppBean> mData;


    public HomeAppListAdapter(Context context, List<MicroAppBean> data) {
        this.mContext = context;
        this.mData = data;
    }

    @Override
    public GridViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_home_app, parent, false);
        return new GridViewHolder(view);
    }

    @Override
    public void onBindViewHolder(GridViewHolder holder, int position) {
        final int pos = holder.getAdapterPosition();
        final MicroAppBean data = mData.get(pos);
        if (data == null) return;

        holder.title.setText(data.url);
        holder.container.setOnClickListener(view -> {
            EventBus.getDefault().post(new MessageEvent(MessageEvent.ON_MICRO_APP_CLICK, position));
        });

    }

    @Override
    public int getItemCount() {
        return mData == null ? 0 : mData.size();
    }

    public static class GridViewHolder extends RecyclerView.ViewHolder {

        TextView title;
        RelativeLayout container;

        public GridViewHolder(View itemView) {
            super(itemView);
            title = itemView.findViewById(R.id.tv_item_name);
            container = itemView.findViewById(R.id.item_content);
        }
    }

}
