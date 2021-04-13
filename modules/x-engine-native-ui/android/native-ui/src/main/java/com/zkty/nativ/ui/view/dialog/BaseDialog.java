package com.zkty.nativ.ui.view.dialog;

import android.app.Dialog;
import android.content.Context;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;

import androidx.annotation.NonNull;

import com.zkty.nativ.core.utils.DensityUtils;

import nativ.ui.R;

/**
 * @description 基类dialog
 */
public class BaseDialog extends Dialog {

    private static final String TAG = BaseDialog.class.getSimpleName();
    private int dialogID;

    private Context context;

    protected BaseDialog(Context context) {
        super(context, R.style.MyDialog);
        this.context = context;
    }

    protected BaseDialog(Context context, boolean cancelable) {
        super(context, R.style.MyDialog);
        setCancelable(cancelable);
    }

    protected BaseDialog(Context context, boolean cancelable, OnDismissListener dismissListener) {
        super(context, R.style.MyDialog);
        setCancelable(cancelable);
        setOnDismissListener(dismissListener);
    }

    public void setDialogView(int layoutResID) {
        View view = View.inflate(getContext(), layoutResID, null);
        setDialogView(view, 0.8, false);
    }

    public void setDialogViewLimit(int layoutResID) {
        View view = View.inflate(getContext(), layoutResID, null);
        setDialogView(view, 0.8, true);
    }

    public void setDialogView(View view) {
        WindowManager.LayoutParams params = new WindowManager.LayoutParams();
        params.width = (int) (DensityUtils.getScreenWidth(context));
        params.height = (int) (DensityUtils.getScreenHeight(context));
        params.gravity = Gravity.CENTER;
        mContentView = view;
        setContentView(view, params);


    }

    public void setDialogViewLimit(View view) {
        setDialogView(view, 0.8, true);
    }

    public void setDialogViewLimit(View view, double ratio) {
        setDialogView(view, ratio, true);
    }

    public void setDialogViewLimit(View view, double widthRatio, double heightRatio) {
        setDialogView(view, widthRatio, heightRatio, true);
    }

    public void setDialogView(View view, double ratio) {
        setDialogView(view, ratio, true);
    }

    private View mContentView;

    public void setDialogView(View view, double ratio, boolean isLimit) {
        WindowManager.LayoutParams params = new WindowManager.LayoutParams();
        if (isLimit) {
            params.width = (int) (DensityUtils.getScreenWidth(context) * ratio);
            params.height = (int) (DensityUtils.getScreenHeight(context) * ratio);
            if (params.width > params.height) {
                params.width = params.height;
            } else {
                params.height = params.width;
            }
        } else {
            params.width = (int) (DensityUtils.getScreenWidth(context) * ratio);
        }
        params.gravity = Gravity.CENTER;
        mContentView = view;
        setContentView(view, params);
    }

    public void setDialogView(View view, double widthRatio, double heightRatio) {
        setDialogView(view, widthRatio, heightRatio, true);
    }

    public void setDialogView(View view, double widthRatio, double heightRatio, boolean isLimit) {
        WindowManager.LayoutParams params = new WindowManager.LayoutParams();
        if (isLimit) {
            params.width = (int) (DensityUtils.getScreenWidth(context) * widthRatio);
            params.height = (int) (DensityUtils.getScreenHeight(context) * heightRatio);
            if (params.width > params.height) {
                params.width = params.height;
            } else {
                params.height = (int) (DensityUtils.getScreenWidth(context) * heightRatio);
            }
        } else {
            params.width = (int) (DensityUtils.getScreenWidth(context) * widthRatio);
        }
        params.gravity = Gravity.CENTER;
        setContentView(view, params);
    }

    public int getDialogID() {
        return dialogID;
    }

    public void setDialogID(int dialogID) {
        this.dialogID = dialogID;
    }

    @Override
    public void show() {
        try {
            super.show();
        } catch (Exception e) {
            Log.e(TAG, e.getMessage());
        }
    }

    private boolean cancel;

    @Override
    public void setCanceledOnTouchOutside(boolean cancel) {
        super.setCanceledOnTouchOutside(cancel);
        this.cancel = cancel;
    }

    @Override
    public boolean onTouchEvent(@NonNull MotionEvent event) {
        if (null != mContentView && cancel && !inRangeOfView(mContentView, event)) {
            this.dismiss();
        }
        return super.onTouchEvent(event);
    }

    private boolean inRangeOfView(View view, MotionEvent ev) {
        int[] location = new int[2];
        view.getLocationOnScreen(location);
        int x = location[0];
        int y = location[1];
        return !(ev.getX() < x || ev.getX() > (x + view.getWidth()) || ev.getY() < y || ev.getY() > (y + view.getHeight()));

    }
}
