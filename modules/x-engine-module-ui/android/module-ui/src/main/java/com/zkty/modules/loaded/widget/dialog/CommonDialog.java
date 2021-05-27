package com.zkty.modules.loaded.widget.dialog;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.text.Html;
import android.text.TextUtils;

import android.view.LayoutInflater;
import android.view.View;

import android.widget.TextView;

import com.zkty.modules.engine.utils.Utils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import module.ui.R;


public class CommonDialog extends BaseDialog {

    private TextView titleTv;
    private TextView messageTv;
    private TextView cancelTv;
    private TextView confirmTv;

    private Context mContext;


    public CommonDialog(Context context) {
        super(context);
        this.mContext = context;
        View content = LayoutInflater.from(context).inflate(R.layout.dialog_common, null);
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

    public void setContentCanCall(String message) {
        if (!TextUtils.isEmpty(message)) {
            String phone = Utils.getPhoneNumberFormString(message);
            if (!TextUtils.isEmpty(phone)) {
                message = message.replace(phone, "<font color='#E8374A'>" + phone + "</font>");
                messageTv.setText(Html.fromHtml(message));
                messageTv.setOnClickListener(v -> showBottomDialog(phone));
            } else {
                messageTv.setText(message);
            }
        }

    }

    private void showBottomDialog(String phone) {
        String[] sexItem = new String[]{"呼叫  " + phone};
        BottomDialog bottomDialog = new BottomDialog(mContext);
        bottomDialog.initDialog(null, null, sexItem, (view, which, l) -> {
            if (which != -2) {
                Intent intent = new Intent(Intent.ACTION_DIAL);
                Uri data = Uri.parse("tel:" + phone);
                intent.setData(data);
                mContext.startActivity(intent);
            }
        });

        bottomDialog.showDialog();


    }

    public void setTitle(String message) {
        if (!TextUtils.isEmpty(message)) {
            titleTv.setText(message);
            titleTv.setVisibility(View.VISIBLE);
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

    public void setShowCancel() {
        cancelTv.setVisibility(View.VISIBLE);
    }

    public void setHideConfirm() {
        confirmTv.setVisibility(View.GONE);
    }

    public void setShowConfirm() {
        confirmTv.setVisibility(View.VISIBLE);
    }


}
