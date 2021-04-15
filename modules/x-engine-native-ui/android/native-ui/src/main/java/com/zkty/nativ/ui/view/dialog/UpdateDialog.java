package com.zkty.nativ.ui.view.dialog;

import android.content.Context;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import nativ.ui.R;


/**
 * @author xiefei
 * @description 升级的对话框
 */
public class UpdateDialog extends BaseDialog {

    private TextView titleTv;
    private TextView messageTv;
    private TextView cancelTv;
    private TextView confirmTv;


    public UpdateDialog(Context context) {
        super(context);
        View content = LayoutInflater.from(context).inflate(R.layout.dialog_update, null);
        titleTv = content.findViewById(R.id.tv_title);
        messageTv = content.findViewById(R.id.tv_content);
        cancelTv = content.findViewById(R.id.tv_cancel);
        confirmTv = content.findViewById(R.id.tv_confirm);
        setDialogView(content);
        cancelTv.setOnClickListener(v -> {
            if (this.callback != null) this.callback.onCancel();
        });
        confirmTv.setOnClickListener(v -> {
            if (this.callback != null) this.callback.onConfirm();
        });
    }

    public void setContent(String message) {
        if (!TextUtils.isEmpty(message)) {
            messageTv.setText(message);
        }
    }

    public void setTitle(String message) {
        if (!TextUtils.isEmpty(message)) {
            titleTv.setText(message);
        }
    }

    public void setCancel(String message) {
        if (!TextUtils.isEmpty(message)) {
            cancelTv.setText(message);
        }
    }

    public void setConfirm(String message) {
        if (!TextUtils.isEmpty(message)) {
            confirmTv.setText(message);
        }
    }

    public interface ClickCallback {
        void onCancel();

        void onConfirm();
    }

    private ClickCallback callback;

    public void setClickCallback(ClickCallback callback) {
        this.callback = callback;
    }

    public void setSingleMode() {
        cancelTv.setVisibility(View.GONE);
    }


}
