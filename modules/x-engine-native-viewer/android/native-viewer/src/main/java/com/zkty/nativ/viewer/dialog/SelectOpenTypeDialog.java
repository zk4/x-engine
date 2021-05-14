package com.zkty.nativ.viewer.dialog;

import android.app.Dialog;
import android.content.Context;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.TextView;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.utils.DensityUtils;
import com.zkty.nativ.viewer.IviewerStatus;
import com.zkty.nativ.viewer.adapter.SelectOpenTypeAdapter;

import java.util.ArrayList;
import java.util.List;

import module.viewer.R;

/**
 * @author : MaJi
 * @time : (3/20/21)
 * dexc :
 */
public class SelectOpenTypeDialog {


    public static final class Builder implements View.OnClickListener {

        private final TextView tvOpenFile,tvSetDefault;
        private Context mContext;
        List<NativeModule> modelList = new ArrayList<>();
        private String routerUri;

        private final Dialog dialog;
        private final SelectOpenTypeAdapter adapter;

        public Builder(Context context, List<NativeModule> modelList ) {
            this.mContext = context;
            this.modelList = modelList;

            View view = LayoutInflater.from(context).inflate(
                    R.layout.dialog_select_open_type, null);

            RecyclerView mRecyclerView = view.findViewById(R.id.mRecyclerView);
            tvOpenFile = view.findViewById(R.id.tvOpenFile);
            tvSetDefault = view.findViewById(R.id.tvSetDefault);
            tvSetDefault.setOnClickListener(this);


            mRecyclerView.setLayoutManager(new LinearLayoutManager(mContext));
            adapter = new SelectOpenTypeAdapter(mContext,modelList);
            mRecyclerView.setAdapter(adapter);
            adapter.setOnClickListener(adapterItenClicklistener);

            // 定义Dialog布局和参数
            dialog = new Dialog(context, R.style.MyDialog);
            dialog.setContentView(view);
            Window dialogWindow = dialog.getWindow();
            dialogWindow.setGravity(Gravity.CENTER);
            WindowManager.LayoutParams lp = dialogWindow.getAttributes();
            lp.x = 0;
            lp.y = 0;
            lp.width = (int) (DensityUtils.getScreenWidth(context));
            lp.height = (int) (DensityUtils.getScreenHeight(context));
            lp.gravity = Gravity.BOTTOM;
            dialogWindow.setAttributes(lp);
        }


        public Builder show() {
            dialog.show();
            return this;

        }

        /**
         * 列表点击事件
         */
        SelectOpenTypeAdapter.OnClickListener adapterItenClicklistener = new SelectOpenTypeAdapter.OnClickListener() {
            @Override
            public void onItemClick(int pos) {
                adapter.setSelectPosition(pos);
                adapter.notifyDataSetChanged();
            }
        };

        /**
         * 确定按钮点击
         * @param listener
         * @return
         */
        public Builder setOpenClickListener( OnClickListener listener) {
            tvOpenFile.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v, (IviewerStatus) modelList.get(adapter.selectPosition),tvSetDefault.isSelected());
                    dialog.dismiss();
                }
            });
            return this;
        }


        @Override
        public void onClick(View v) {
            if (v.getId() == R.id.tvSetDefault) {
                tvSetDefault.setSelected(!tvSetDefault.isSelected());
            }
        }


        /**
         * 和Activity通信的接口
         */
        public interface OnClickListener {
            void onItemClick(View view, IviewerStatus bean, boolean isDefault);
        }

        private OnClickListener mOnClickListener;


        public void setOnClickListener(OnClickListener mOnClickListener) {
            this.mOnClickListener = mOnClickListener;
        }
    }


}
