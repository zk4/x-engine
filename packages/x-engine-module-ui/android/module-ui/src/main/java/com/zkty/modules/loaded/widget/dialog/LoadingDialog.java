package com.zkty.modules.loaded.widget.dialog;

import android.content.Context;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import module.ui.R;

/**
 * @author xiefei
 * @description 加载的对话框
 */
public class LoadingDialog extends BaseDialog {

    private TextView messageView;
    private LoadingView mLoadingView;
    private ImageView mSuccessView;

    public enum TYPE {SUCCESS, LOADING, NONE}

    public LoadingDialog(Context context) {
        super(context);
        View content = LayoutInflater.from(context).inflate(R.layout.dialog_loading, null);
        messageView = (TextView) content.findViewById(R.id.dialog_loading_message);
        mLoadingView = (LoadingView) content.findViewById(R.id.normal_loading_img);
        mSuccessView = (ImageView) content.findViewById(R.id.normal_img);
        setDialogView(content, 0.5);
    }

    public void setContentMessage(String message) {
        if (!TextUtils.isEmpty(message)) {
            messageView.setText(message);
        }
    }

    public void setMode(TYPE type) {
        mLoadingView.setVisibility(View.GONE);
        mSuccessView.setVisibility(View.GONE);

        switch (type) {
            case LOADING:
                mLoadingView.setVisibility(View.VISIBLE);
                break;
            case SUCCESS:
                mSuccessView.setVisibility(View.VISIBLE);
                break;
            case NONE:
            default:
                break;
        }

    }

    public void setContentMessage(int message) {
        messageView.setText(message);
    }

    @Override
    public void show() {
        super.show();
        mLoadingView.startAnimation();
    }
}
