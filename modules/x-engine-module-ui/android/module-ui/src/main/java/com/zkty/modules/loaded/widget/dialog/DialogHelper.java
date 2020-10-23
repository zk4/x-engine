package com.zkty.modules.loaded.widget.dialog;

import android.content.Context;
import android.os.Handler;

public class DialogHelper {
    private DialogHelper() {
    }

    private static LoadingDialog mLoadingDialog;

    public static void showLoadingDialog(Context cxt, String content, long duration) {
        if (mLoadingDialog == null) {
            mLoadingDialog = new LoadingDialog(cxt);
        }
        mLoadingDialog.setContentMessage(content);
        mLoadingDialog.setMode(LoadingDialog.TYPE.LOADING);
        mLoadingDialog.setCanceledOnTouchOutside(false);
        if (!mLoadingDialog.isShowing()) {
            mLoadingDialog.show();
        }
        if (duration > 0) {
            new Handler().postDelayed(() -> hideDialog(), duration * 1000);
        }

    }

    public static void showSuccessDialog(Context cxt, String content, long duration) {
        if (mLoadingDialog == null) {
            mLoadingDialog = new LoadingDialog(cxt);
        }
        mLoadingDialog.setContentMessage(content);
        mLoadingDialog.setMode(LoadingDialog.TYPE.SUCCESS);
        mLoadingDialog.setCanceledOnTouchOutside(false);
        if (!mLoadingDialog.isShowing()) {
            mLoadingDialog.show();
        }
        if (duration > 0) {
            new Handler().postDelayed(() -> hideDialog(), duration * 1000);
        }

    }

    public static void showFailDialog(Context cxt, String content, long duration) {
        if (mLoadingDialog == null) {
            mLoadingDialog = new LoadingDialog(cxt);
        }
        mLoadingDialog.setContentMessage(content);
        mLoadingDialog.setMode(LoadingDialog.TYPE.FAIL);
        mLoadingDialog.setCanceledOnTouchOutside(false);
        if (!mLoadingDialog.isShowing()) {
            mLoadingDialog.show();
        }
        if (duration > 0) {
            new Handler().postDelayed(() -> hideDialog(), duration * 1000);
        }

    }

    public static void showNoIconDialog(Context cxt, String content, long duration) {
        if (mLoadingDialog == null) {
            mLoadingDialog = new LoadingDialog(cxt);
        }
        mLoadingDialog.setContentMessage(content);
        mLoadingDialog.setMode(LoadingDialog.TYPE.NONE);
        mLoadingDialog.setCanceledOnTouchOutside(false);
        if (!mLoadingDialog.isShowing()) {
            mLoadingDialog.show();
        }
        if (duration > 0) {
            new Handler().postDelayed(() -> hideDialog(), duration * 1000);
        }

    }

    public static void hideDialog() {
        if (mLoadingDialog != null && mLoadingDialog.isShowing()) {
            mLoadingDialog.dismiss();
            mLoadingDialog = null;
        }
    }
}
