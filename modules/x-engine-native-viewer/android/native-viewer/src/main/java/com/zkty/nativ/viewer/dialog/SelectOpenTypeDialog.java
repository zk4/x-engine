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

import com.zkty.nativ.core.utils.DensityUtils;
import com.zkty.nativ.viewer.adapter.SelectOpenTypeAdapter;
import com.zkty.nativ.viewer.bean.ModelInfoBean;

import java.util.ArrayList;
import java.util.List;

import module.viewer.R;

/**
 * @author : MaJi
 * @time : (3/20/21)
 * dexc :
 */
public class SelectOpenTypeDialog {


    public static final class Builder {

        private final TextView tvOpenFile;
        private Context mContext;
        List<ModelInfoBean> modelList = new ArrayList<>();
        private String routerUri;

        private final Dialog dialog;
        private final SelectOpenTypeAdapter adapter;

        public Builder(Context context, List<ModelInfoBean> modelList ) {
            this.mContext = context;
            this.modelList = modelList;

            View view = LayoutInflater.from(context).inflate(
                    R.layout.dialog_select_open_type, null);

            RecyclerView mRecyclerView = view.findViewById(R.id.mRecyclerView);
            tvOpenFile = view.findViewById(R.id.tvOpenFile);
            mRecyclerView.setLayoutManager(new LinearLayoutManager(mContext));
            adapter = new SelectOpenTypeAdapter(mContext,modelList);
            mRecyclerView.setAdapter(adapter);
            adapter.setOnClickListener(new SelectOpenTypeAdapter.OnClickListener() {
                @Override
                public void onItemClick(int pos) {
                    adapter.setSelectPosition(pos);
                    adapter.notifyDataSetChanged();
                }
            });

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

        public Builder setOpenClickListener( OnClickListener listener) {
            tvOpenFile.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v,modelList.get(adapter.selectPosition));
                    dialog.dismiss();
                }
            });
            return this;
        }

        /**
         * 和Activity通信的接口
         */
        public interface OnClickListener {
            void onItemClick(View view,ModelInfoBean bean);
        }

        private OnClickListener mOnClickListener;


        public void setOnClickListener(OnClickListener mOnClickListener) {
            this.mOnClickListener = mOnClickListener;
        }
    }


}
