package com.zkty.modules.engine.utils;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;
import android.view.Gravity;
import android.widget.Toast;

import com.zkty.modules.engine.XEngineApplication;

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

    public static void showNormalShortToast(Context context, int resid) {
        if (mToast == null) {
            mToast = Toast.makeText(context
                    , resid, Toast.LENGTH_SHORT);
        } else {
            mToast.setText(resid);
        }
        mToast.show();
    }

    public static void showNormalLongToast(Context context, int resid) {
        if (mToast == null) {
            mToast = Toast.makeText(context
                    , resid, Toast.LENGTH_LONG);
        } else {
            mToast.setText(resid);
        }
        mToast.show();
    }

    public static void showNormalShortToast(CharSequence content) {
        if (TextUtils.isEmpty(content)) {
            return;
        }
        if (mToast == null) {
            mToast = Toast.makeText(XEngineApplication.getApplication().getApplicationContext(), content, Toast.LENGTH_SHORT);
        } else {
            mToast.setText(content);
        }
        mToast.show();
    }

    public static void showNormalLongToast(CharSequence content) {
        if (TextUtils.isEmpty(content)) {
            return;
        }
        if (mToast == null) {
            mToast = Toast.makeText(XEngineApplication.getApplication().getApplicationContext(), content, Toast.LENGTH_LONG);
        } else {
            mToast.setText(content);
        }
        mToast.show();
    }

    public static void showThreadToast(CharSequence content) {
        if (TextUtils.isEmpty(content)) {
            return;
        }
        Handler handler = new Handler(Looper.getMainLooper());
        handler.post(() -> {
            if (mToast != null)
                mToast.setText(content);
            else {
                mToast = Toast.makeText(XEngineApplication.getApplication().getApplicationContext(), content, Toast.LENGTH_SHORT);
            }
            mToast.show();
        });

    }

    public static void showNormalShortToast(int resid) {
        if (mToast == null) {
            mToast = Toast.makeText(XEngineApplication.getApplication().getApplicationContext(), resid, Toast.LENGTH_SHORT);
        } else {
            mToast.setText(resid);
        }
        mToast.show();
    }

    public static void showNormalLongToast(int resid) {
        if (mToast == null) {
            mToast = Toast.makeText(XEngineApplication.getApplication().getApplicationContext(), resid, Toast.LENGTH_LONG);
        } else {
            mToast.setText(resid);
        }
        mToast.show();
    }

    public static void showCenterToast(int resId) {
        if (centerToast == null) {
            centerToast = Toast.makeText(XEngineApplication.getApplication().getApplicationContext(), resId, Toast.LENGTH_SHORT);
            centerToast.setGravity(Gravity.CENTER, 0, 0);
        } else {
            centerToast.setText(resId);
        }
        centerToast.show();

    }

    public static void showCenterToast(String message) {
        if (centerToast == null) {
            centerToast = Toast.makeText(XEngineApplication.getApplication().getApplicationContext(), message, Toast.LENGTH_SHORT);
            centerToast.setGravity(Gravity.CENTER, 0, 0);
        } else {
            centerToast.setText(message);
        }
        centerToast.show();
    }

}
