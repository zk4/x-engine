package com.zkty.modules.loaded.util;

import android.content.Context;
import android.os.Looper;
import android.text.TextUtils;
import android.view.Gravity;
import android.widget.Toast;

public class ToastUtils {

    private static Toast mToast;
    private static Toast centerToast;

    /**
     * 非阻塞试显示Toast,防止出现连续点击Toast时的显示问题
     */
    public static void showToast(Context context, CharSequence text, int duration) {

        if (mToast == null) {
            mToast = Toast.makeText(context, text, duration);
        } else {
            mToast.setText(text);
            mToast.setDuration(duration);
        }
        mToast.show();


    }

    public static void showToast(Context context, CharSequence text) {
        showToast(context, text, Toast.LENGTH_SHORT);
    }

    /*-------------------------------- 以下为新添加toast工具方法 --------------------------------*/

    public static void showNormalShortToast(Context context, CharSequence content) {
        if (TextUtils.isEmpty(content)) {
            return;
        }
        if (mToast == null) {
            mToast = Toast.makeText(context, content, Toast.LENGTH_SHORT);
        } else {
            mToast.setText(content);
        }
        mToast.show();
    }

    public static void showNormalLongToast(Context context, CharSequence content) {
        if (TextUtils.isEmpty(content)) {
            return;
        }
        if (mToast == null) {
            mToast = Toast.makeText(context, content, Toast.LENGTH_LONG);
        } else {
            mToast.setText(content);
        }
        mToast.show();
    }


    public static void showCenterToast(Context context, String message) {
        if (centerToast == null) {
            centerToast = Toast.makeText(context, message, Toast.LENGTH_SHORT);
            centerToast.setGravity(Gravity.CENTER, 0, 0);
        } else {
            centerToast.setText(message);
        }
        centerToast.show();
    }

}
