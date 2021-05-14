package com.zkty.nativ.viewer.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.viewer.IviewerStatus;

import java.util.List;

import module.viewer.R;

/**
 * @author : MaJi
 * @time : (5/13/21)
 * dexc :
 */
public class SelectOpenTypeAdapter extends  RecyclerView.Adapter<SelectOpenTypeAdapter.ViewHolder>{
    private final Context mContext;
    private List<NativeModule> mData;

    public int selectPosition = 0;
    public SelectOpenTypeAdapter(Context mContext, List<NativeModule> mData) {
        this.mContext = mContext;
        this.mData = mData;
    }

    public void setSelectPosition(int position){
        selectPosition = position;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.adapter_select_open_type,parent,false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        IviewerStatus modelInfoBean = (IviewerStatus) mData.get(position);
        holder.mTitle.setText(modelInfoBean.getModelName());
        holder.ivPic.setImageResource(modelInfoBean.getModelPicRes());
        if(selectPosition == position){
            holder.ivStatus.setImageResource(R.mipmap.ic_select);
        }else{
            holder.ivStatus.setImageResource(R.mipmap.ic_un_select);
        }

        holder.llContent.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mOnClickListener.onItemClick(position);
            }
        });
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder{

        private final ImageView ivStatus,ivPic;
        private final TextView mTitle;
        private final LinearLayout llContent;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            llContent = (LinearLayout)itemView.findViewById(R.id.llContent);
            mTitle = (TextView)itemView.findViewById(R.id.tv_title);
            ivPic = (ImageView)itemView.findViewById(R.id.iv_pic);
            ivStatus = (ImageView)itemView.findViewById(R.id.iv_status);
        }
    }

    /**
     * 和Activity通信的接口
     */
    public interface OnClickListener {
        void onItemClick(int pos);
    }

    private OnClickListener mOnClickListener;


    public void setOnClickListener(OnClickListener mOnClickListener) {
        this.mOnClickListener = mOnClickListener;
    }
}
