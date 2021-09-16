package com.zkty.nativ.jsi.utils;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.graphics.Rect;
import android.view.View;
import android.view.inputmethod.InputMethodManager;

import com.zkty.nativ.core.XEngineApplication;


/**
 * 打开或关闭软键盘
 */
public class KeyBoardUtils {
    /**
     * 打卡软键盘
     *
     * @param view
     * @param mContext 上下文
     */
    public static void openKeybord(View view, Context mContext) {
        InputMethodManager imm = (InputMethodManager) mContext
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.showSoftInput(view, InputMethodManager.RESULT_SHOWN);
        imm.toggleSoftInput(InputMethodManager.SHOW_FORCED,
                InputMethodManager.HIDE_IMPLICIT_ONLY);
    }

    /**
     * 关闭软键盘
     *
     * @param view
     * @param mContext 上下文
     */
    public static void closeKeybord(View view, Context mContext) {
        InputMethodManager imm = (InputMethodManager) mContext
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
    }


    /**
     * 判断软键盘是否打开 若返回true，则表示输入法打开
     */

    public static boolean isSoftKeyboardShowed(Activity mContext) {
        //获取当前屏幕内容的高度
        int screenHeight = mContext.getWindow().getDecorView().getHeight();
        //获取View可见区域的bottom
        Rect rect = new Rect();
        //DecorView即为activity的顶级view
        mContext.getWindow().getDecorView().getWindowVisibleDisplayFrame(rect);
        //考虑到虚拟导航栏的情况（虚拟导航栏情况下：screenHeight = rect.bottom + 虚拟导航栏高度）
        //选取screenHeight*2/3进行判断
        return screenHeight * 2 / 3 > rect.bottom;

    }
}
