package com.zkty.modules.loaded.widget.dialog;

import android.content.Context;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import module.ui.R;


public class CommonDialog extends BaseDialog implements View.OnClickListener {

    private OnCommonDialogCallBack messageDialogCallBack = null;
    private TextView messageDialogTitle;
    private TextView messageDialogMsgContent;
    private TextView messageDialogTvOk;
    private TextView messageDialogTvCancel;

    private LinearLayout layoutMessageDialog;
    private LinearLayout viewDialogContent;
    private RelativeLayout mzDialogBtnLayout;
    private LinearLayout messageDialogTitleLayout;
    private Context mContext;

    public CommonDialog(Context context) {
        this(context, -1, -1, true);
    }

    public CommonDialog(Context context, boolean isLimit) {
        this(context, -1, -1, isLimit);
    }

    public CommonDialog(Context context, int cancel, int ok) {
        this(context, cancel, ok, true);
    }

    public CommonDialog(Context context, int cancel, int ok, boolean isLimit, double ratio) {
        super(context);
        mContext = context;
        View content = View.inflate(context, R.layout.dialog_common, null);
        getWindow().setGravity(Gravity.CENTER);
        messageDialogTitle = (TextView) content.findViewById(R.id.message_dialog_title);
        messageDialogMsgContent = (TextView) content.findViewById(R.id.message_dialog_msg_content);
        messageDialogTvCancel = (TextView) content.findViewById(R.id.message_dialog_tv_cancle);
        layoutMessageDialog = (LinearLayout) content.findViewById(R.id.layout_message_dialog);
        viewDialogContent = (LinearLayout) content.findViewById(R.id.view_dialog_content);
        mzDialogBtnLayout = (RelativeLayout) content.findViewById(R.id.mz_dialog_btn_layout);
        messageDialogTitleLayout = (LinearLayout) content.findViewById(R.id.message_dialog_title_layout);

        if (cancel > 0) {
            messageDialogTvCancel.setText(cancel);
        }

        messageDialogTvCancel.setOnClickListener(this);
        messageDialogTvOk = (TextView) content.findViewById(R.id.message_dialog_tv_ok);
        if (ok > 0) {
            messageDialogTvOk.setText(ok);
        }
        messageDialogTvOk.setOnClickListener(this);
        messageDialogTitle.setVisibility(View.GONE);
        messageDialogTitleLayout.setVisibility(View.GONE);
        // 设置内容
        if (isLimit) {
            setDialogViewLimit(content, ratio);
        } else {
            setDialogView(content, ratio);
        }
    }

    public CommonDialog(Context context, int cancel, int ok, boolean isLimit, double widthRatio, double heightRatio) {
        super(context);
        mContext = context;
        View content = View.inflate(context, R.layout.dialog_common, null);
        getWindow().setGravity(Gravity.CENTER);
        messageDialogTitle = (TextView) content.findViewById(R.id.message_dialog_title);
        messageDialogMsgContent = (TextView) content.findViewById(R.id.message_dialog_msg_content);
        messageDialogTvCancel = (TextView) content.findViewById(R.id.message_dialog_tv_cancle);
        layoutMessageDialog = (LinearLayout) content.findViewById(R.id.layout_message_dialog);
        viewDialogContent = (LinearLayout) content.findViewById(R.id.view_dialog_content);
        mzDialogBtnLayout = (RelativeLayout) content.findViewById(R.id.mz_dialog_btn_layout);
        messageDialogTitleLayout = (LinearLayout) content.findViewById(R.id.message_dialog_title_layout);

        if (cancel > 0) {
            messageDialogTvCancel.setText(cancel);
        }

        messageDialogTvCancel.setOnClickListener(this);
        messageDialogTvOk = (TextView) content.findViewById(R.id.message_dialog_tv_ok);
        if (ok > 0) {
            messageDialogTvOk.setText(ok);
        }
        messageDialogTvOk.setOnClickListener(this);
        messageDialogTitle.setVisibility(View.GONE);
        messageDialogTitleLayout.setVisibility(View.GONE);
        // 设置内容
        if (isLimit) {
            setDialogViewLimit(content, widthRatio, heightRatio);
        } else {
            setDialogView(content, widthRatio, heightRatio);
        }
    }

    public CommonDialog(Context context, int cancel, int ok, boolean isLimit) {
        super(context);
        mContext = context;
        View content = View.inflate(context, R.layout.dialog_common, null);
        WindowManager.LayoutParams params = new WindowManager.LayoutParams();
        params.y = 100;
        getWindow().setAttributes(params);
        getWindow().setGravity(Gravity.CENTER_HORIZONTAL);
        messageDialogTitle = (TextView) content.findViewById(R.id.message_dialog_title);
        messageDialogMsgContent = (TextView) content.findViewById(R.id.message_dialog_msg_content);
        messageDialogTvCancel = (TextView) content.findViewById(R.id.message_dialog_tv_cancle);
        layoutMessageDialog = (LinearLayout) content.findViewById(R.id.layout_message_dialog);
        viewDialogContent = (LinearLayout) content.findViewById(R.id.view_dialog_content);
        mzDialogBtnLayout = (RelativeLayout) content.findViewById(R.id.mz_dialog_btn_layout);
        messageDialogTitleLayout = (LinearLayout) content.findViewById(R.id.message_dialog_title_layout);

        if (cancel > 0) {
            messageDialogTvCancel.setText(cancel);
        }

        messageDialogTvCancel.setOnClickListener(this);
        messageDialogTvOk = (TextView) content.findViewById(R.id.message_dialog_tv_ok);
        if (ok > 0) {
            messageDialogTvOk.setText(ok);
        }
        messageDialogTvOk.setOnClickListener(this);
        messageDialogTitle.setVisibility(View.GONE);
        messageDialogTitleLayout.setVisibility(View.GONE);
        // 设置内容
        if (isLimit) {
            setDialogViewLimit(content, 0.8);
        } else {
            setDialogView(content);
        }
    }

    public void setBtnLayoutVisibility(boolean isShow) {
        mzDialogBtnLayout.setVisibility(isShow ? View.VISIBLE : View.GONE);
    }

    public void setTitleLayoutVisibility(boolean isShow) {
        messageDialogTitleLayout.setVisibility(isShow ? View.VISIBLE : View.GONE);
    }

    public void setMessageTitle(int title) {
        messageDialogTitle.setVisibility(View.VISIBLE);
        messageDialogTitle.setText(title);
        messageDialogTitleLayout.setVisibility(View.VISIBLE);
    }


    public void setMessageTitle(String title) {
        if (!TextUtils.isEmpty(title)) {
            messageDialogTitle.setVisibility(View.VISIBLE);
            messageDialogTitle.setText(title);
            messageDialogTitleLayout.setVisibility(View.VISIBLE);
        }
    }

    /**
     * 设置dialog标题是否可见
     *
     * @param isShow
     */
    public void setTitleVisibility(boolean isShow) {
        messageDialogTitle.setVisibility(isShow ? View.VISIBLE : View.GONE);
    }

    /**
     * 设置dialog高度
     *
     * @param px 像素
     */
    public void setLayoutHeight(int px) {
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, px);
        layoutMessageDialog.setLayoutParams(params);
    }

    /**
     * 设置dialog内容布局
     *
     * @param
     */
    public void setMesssageView(int id) {
        View view = View.inflate(mContext, id, null);
        messageDialogMsgContent.setVisibility(View.GONE);
        viewDialogContent.setVisibility(View.VISIBLE);
        viewDialogContent.addView(view);
    }

    /**
     * 设置dialog内容布局是否可见
     *
     * @param
     */
    public void setContentVisibility(int visibility) {
        messageDialogMsgContent.setVisibility(visibility);
    }

    /**
     * 设置dialog内容布局
     *
     * @param
     */
    public void setMessageView(View view) {
        if (view != null) {
            messageDialogMsgContent.setVisibility(View.GONE);
            viewDialogContent.setVisibility(View.VISIBLE);
            viewDialogContent.addView(view);
        }
    }


    public void setContentMessage(int resid) {
        if (resid > 0) {
            messageDialogMsgContent.setText(resid);
            setContentVisibility(View.VISIBLE);
        }

    }

    public void setContentMessage(String msgStr) {
        if (!TextUtils.isEmpty(msgStr)) {
            messageDialogMsgContent.setText(msgStr);
            setContentVisibility(View.VISIBLE);
        }
    }


    /**
     * @description 设置显示文本
     */
    public void setConfirmText(String context) {
        if (!TextUtils.isEmpty(context)) {
            messageDialogTvOk.setText(context);
        }
    }

    public void setConfirmText(int context) {
        messageDialogTvOk.setText(context);
    }

    public void setConfirmTextColor(int sid) {
        messageDialogTvOk.setTextColor(sid);
    }

    public void setCancelText(String context) {
        if (!TextUtils.isEmpty(context)) {
            messageDialogTvCancel.setText(context);
        }
    }

    public void setCancelText(int context) {
        messageDialogTvCancel.setText(context);
    }

    /**
     * @description 只显示一个按钮
     */
    public void setSingleType(int... content) {
        messageDialogTvCancel.setVisibility(View.GONE);
        if (content != null && content.length > 0) {
            messageDialogTvOk.setText(content[0]);
        }
    }

    /**
     * @description 设置一个按钮背景
     */
    public void setSingleTypeBg(int bgRes) {
        messageDialogTvCancel.setVisibility(View.GONE);
        messageDialogTvOk.setBackgroundResource(bgRes);
    }

    /**
     * @description 设置一个按钮
     */
    public void setCancelVisibility(boolean visibility) {
        messageDialogTvCancel.setVisibility(visibility ? View.VISIBLE : View.GONE);

    }

    public void setContentGravity(int gravity) {
        messageDialogMsgContent.setGravity(gravity | Gravity.CENTER_VERTICAL);
    }


    @Override
    public void onClick(View v) {
        if (messageDialogCallBack == null) {
            return;
        }

        if (R.id.message_dialog_tv_ok == v.getId()) {
            messageDialogCallBack.onClick(true);
        } else if (R.id.message_dialog_tv_cancle == v.getId()) {
            messageDialogCallBack.onClick(false);
        }

        dismiss();
    }


    private boolean isDismiss = true;

    public void setDismiss(boolean isDismiss) {
        this.isDismiss = isDismiss;
    }

    @Override
    public void dismiss() {
        if (!isDismiss) {
            return;
        }
        super.dismiss();
        if (onCallback != null) {
            onCallback.isDismiss(true);
        }
    }

    @Override
    public void show() {
        super.show();
        if (onCallback != null) {
            onCallback.isDismiss(false);
        }
    }

    public void setCommonDialogCallBack(OnCommonDialogCallBack messageDialogCallBack) {
        this.messageDialogCallBack = messageDialogCallBack;
    }

    /**
     * @description 回调接口
     */
    public interface OnCommonDialogCallBack {
        void onClick(boolean isConfirm);
    }

    private OnDismissCallback onCallback;

    public void setOnDismissCallback(OnDismissCallback onCallback) {
        this.onCallback = onCallback;
    }

    public interface OnDismissCallback {
        public void isDismiss(boolean isDismiss);
    }


}
