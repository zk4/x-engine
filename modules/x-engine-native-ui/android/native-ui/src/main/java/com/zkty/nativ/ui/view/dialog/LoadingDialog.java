package com.zkty.nativ.ui.view.dialog;

import android.content.Context;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import nativ.ui.R;


/**
 * @author xiefei
 * @description 加载的对话框
 */
public class LoadingDialog extends BaseDialog {

    private TextView messageView;
    private LoadingView mLoadingView;
    private ImageView mSuccessView;

    public enum TYPE {SUCCESS, LOADING, NONE, FAIL}

    public LoadingDialog(Context context) {
        super(context);
        View content = LayoutInflater.from(context).inflate(R.layout.dialog_loading_ui, null);
        messageView = (TextView) content.findViewById(R.id.dialog_loading_message);
        mLoadingView = (LoadingView) content.findViewById(R.id.normal_loading_img);
        mSuccessView = (ImageView) content.findViewById(R.id.normal_img);
//        getWindow().setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT);
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
                mSuccessView.setImageResource(R.mipmap.icon_state_y);
                mSuccessView.setVisibility(View.VISIBLE);
                break;
            case FAIL:
                mSuccessView.setImageResource(R.mipmap.icon_state_x);
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
